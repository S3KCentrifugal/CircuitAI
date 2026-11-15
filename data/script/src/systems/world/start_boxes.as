// The game's real start boxes. With start points chosen in game, BAR's
// game_initial_spawn checks a start point against the polygon boxes of the lobby's
// mapmetadata_startbox_override modoption, or else the map's own default boxes
// (mapmetadata_startboxes_set), not against the script's startrect rectangle the
// native setup reads. The two differ: King's Assault 2026-11-15 had startrect
// 0.7-1.0 in the script but box 158-200 (0.79-1.0) in the game, so a spot 16 elmos
// outside the real box looked 400 elmos inside to the AI, was sent unclamped and
// the game replaced it with its own guess.
//
// Both modoptions are base64url(zlib(json)) in the lobby's 0-200 map units:
//   set:      {"2": {"startboxes": [{"poly": [{"x":0,"y":0},{"x":42,"y":200}]}, ...]}, "3": ...}
//   override: {"startboxes": [...]}
// A 2-point poly is a rectangle (corners). Arrangement choice follows
// luarules/gadgets/include/startbox_utilities.lua resolveArrangement: the override
// when it has a box for every ally team, else the set keyed by the ally team count,
// else the smallest larger key, else the largest smaller key.
//
// Cost: once per game from StartPick::Run; the payloads are < 1 KB.
#include "../../helpers/common/generic_helpers.as"

namespace StartBoxes {
	bool loaded = false;
	string source = "";
	// boxes[allyTeam] = polygon in elmos (x, 0, z)
	array<array<AIFloat3>> boxes;

	// ---------- base64url ----------
	int B64(uint8 c) {
		if (c >= 65 && c <= 90) return c - 65;        // A-Z
		if (c >= 97 && c <= 122) return c - 97 + 26;  // a-z
		if (c >= 48 && c <= 57) return c - 48 + 52;   // 0-9
		if (c == 45 || c == 43) return 62;             // - +
		if (c == 95 || c == 47) return 63;             // _ /
		return -1;                                     // = and anything else
	}

	bool Base64Decode(const string& in s, array<uint8>& dst) {
		uint acc = 0; int nb = 0;
		for (uint i = 0; i < s.length(); ++i) {
			const int v = B64(s[i]);
			if (v < 0) {
				if (s[i] == 61) break;  // '=' padding
				return false;
			}
			acc = (acc << 6) | uint(v); nb += 6;
			if (nb >= 8) { nb -= 8; dst.insertLast(uint8((acc >> nb) & 0xFF)); }
		}
		return true;
	}

	// ---------- inflate (RFC 1950/1951), after zlib's puff.c ----------
	class Huffman {
		array<int> count = array<int>(16, 0);
		array<int> symbol;
	}

	class Inflater {
		array<uint8>@ inp;
		uint pos = 0;
		uint bitbuf = 0;
		int bitcnt = 0;
		bool err = false;
		array<uint8> outb;

		int Bits(int need) {
			uint val = bitbuf;
			while (bitcnt < need) {
				if (pos >= inp.length()) { err = true; return 0; }
				val |= uint(inp[pos++]) << uint(bitcnt);
				bitcnt += 8;
			}
			bitbuf = val >> uint(need);
			bitcnt -= need;
			return int(val & ((uint(1) << uint(need)) - uint(1)));
		}

		void Construct(Huffman@ h, const array<int>& in lengths, int off, int n) {
			for (int l = 0; l < 16; ++l) h.count[l] = 0;
			for (int s = 0; s < n; ++s) h.count[lengths[off + s]]++;
			array<int> offs(16, 0);
			for (int l = 1; l < 15; ++l) offs[l + 1] = offs[l] + h.count[l];
			h.symbol.resize(n);
			for (int s = 0; s < n; ++s)
				if (lengths[off + s] != 0) h.symbol[offs[lengths[off + s]]++] = s;
		}

		int Decode(Huffman@ h) {
			int code = 0, first = 0, index = 0;
			for (int len = 1; len < 16; ++len) {
				code |= Bits(1);
				if (err) return -1;
				const int c = h.count[len];
				if (code - c < first) return h.symbol[index + (code - first)];
				index += c; first += c;
				first <<= 1; code <<= 1;
			}
			err = true;
			return -1;
		}

		void Codes(Huffman@ lencode, Huffman@ distcode) {
			const array<int> lbase = {3,4,5,6,7,8,9,10,11,13,15,17,19,23,27,31,35,43,51,59,67,83,99,115,131,163,195,227,258};
			const array<int> lext = {0,0,0,0,0,0,0,0,1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,0};
			const array<int> dbase = {1,2,3,4,5,7,9,13,17,25,33,49,65,97,129,193,257,385,513,769,1025,1537,2049,3073,4097,6145,8193,12289,16385,24577};
			const array<int> dext = {0,0,0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12,12,13,13};
			while (!err) {
				int sym = Decode(lencode);
				if (err || sym < 0) { err = true; return; }
				if (sym < 256) { outb.insertLast(uint8(sym)); continue; }
				if (sym == 256) return;
				sym -= 257;
				if (sym >= 29) { err = true; return; }
				const int len = lbase[sym] + Bits(lext[sym]);
				const int dsym = Decode(distcode);
				if (err || dsym < 0 || dsym >= 30) { err = true; return; }
				const int dist = dbase[dsym] + Bits(dext[dsym]);
				if (err || uint(dist) > outb.length()) { err = true; return; }
				for (int k = 0; k < len; ++k) { const uint8 cb = outb[outb.length() - uint(dist)]; outb.insertLast(cb); }
				if (outb.length() > 65536) { err = true; return; }  // a box payload is tiny
			}
		}

		void Stored() {
			bitbuf = 0; bitcnt = 0;
			if (pos + 4 > inp.length()) { err = true; return; }
			const uint len = uint(inp[pos]) | (uint(inp[pos + 1]) << 8);
			pos += 4;
			if (pos + len > inp.length()) { err = true; return; }
			for (uint k = 0; k < len; ++k) outb.insertLast(inp[pos++]);
		}

		void Fixed() {
			array<int> lengths(320, 0);
			for (int s = 0; s < 144; ++s) lengths[s] = 8;
			for (int s = 144; s < 256; ++s) lengths[s] = 9;
			for (int s = 256; s < 280; ++s) lengths[s] = 7;
			for (int s = 280; s < 288; ++s) lengths[s] = 8;
			for (int s = 288; s < 318; ++s) lengths[s] = 5;
			Huffman@ lencode = Huffman();
			Huffman@ distcode = Huffman();
			Construct(lencode, lengths, 0, 288);
			Construct(distcode, lengths, 288, 30);
			Codes(lencode, distcode);
		}

		void Dynamic() {
			const array<int> order = {16,17,18,0,8,7,9,6,10,5,11,4,12,3,13,2,14,1,15};
			const int nlen = Bits(5) + 257;
			const int ndist = Bits(5) + 1;
			const int ncode = Bits(4) + 4;
			if (err || nlen > 286 || ndist > 30) { err = true; return; }
			array<int> lengths(320, 0);
			for (int i = 0; i < ncode; ++i) lengths[order[i]] = Bits(3);
			Huffman@ lencode = Huffman();
			Huffman@ distcode = Huffman();
			Construct(lencode, lengths, 0, 19);
			int index = 0;
			while (index < nlen + ndist && !err) {
				int sym = Decode(lencode);
				if (err || sym < 0) { err = true; return; }
				if (sym < 16) { lengths[index++] = sym; continue; }
				int len = 0;
				if (sym == 16) {
					if (index == 0) { err = true; return; }
					len = lengths[index - 1];
					sym = 3 + Bits(2);
				} else if (sym == 17) sym = 3 + Bits(3);
				else sym = 11 + Bits(7);
				if (index + sym > nlen + ndist) { err = true; return; }
				while (sym-- > 0) lengths[index++] = len;
			}
			if (err) return;
			array<int> dl(30, 0);
			for (int i = 0; i < ndist; ++i) dl[i] = lengths[nlen + i];
			Construct(lencode, lengths, 0, nlen);
			Construct(distcode, dl, 0, 30);
			Codes(lencode, distcode);
		}

		bool Run(array<uint8>@ data) {
			@inp = data;
			if (inp.length() < 3 || (inp[0] & 0x0F) != 8) return false;  // zlib header: deflate
			pos = 2;
			int last = 0;
			do {
				last = Bits(1);
				const int type = Bits(2);
				if (err) return false;
				if (type == 0) Stored();
				else if (type == 1) Fixed();
				else if (type == 2) Dynamic();
				else return false;
			} while (last == 0 && !err);
			return !err;
		}
	}

	// ---------- minimal JSON ----------
	class JNode {
		int kind = 0;  // 0 null, 1 number, 2 string, 3 array, 4 object, 5 bool
		double num = 0;
		string str;
		array<JNode@> items;   // array items, object values
		array<string> keys;    // object keys
		JNode@ Get(const string& in k) {
			for (uint i = 0; i < keys.length(); ++i) if (keys[i] == k) return items[i];
			return null;
		}
	}

	class JParser {
		string s;
		uint p = 0;
		bool err = false;
		void Ws() { while (p < s.length() && (s[p] == 32 || s[p] == 9 || s[p] == 10 || s[p] == 13)) ++p; }
		string Str() {
			string r = "";
			++p;  // opening quote
			while (p < s.length() && s[p] != 34) {
				if (s[p] == 92) ++p;  // backslash: keep the next char as is (box payloads hold no escapes)
				if (p < s.length()) r += s.substr(p, 1);
				++p;
			}
			if (p >= s.length()) err = true; else ++p;
			return r;
		}
		JNode@ Value(int depth) {
			Ws();
			JNode@ n = JNode();
			if (err || p >= s.length() || depth > 16) { err = true; return n; }
			const uint8 c = s[p];
			if (c == 123) {  // {
				n.kind = 4; ++p; Ws();
				if (p < s.length() && s[p] == 125) { ++p; return n; }
				while (!err) {
					Ws();
					if (p >= s.length() || s[p] != 34) { err = true; break; }
					n.keys.insertLast(Str());
					Ws();
					if (p >= s.length() || s[p] != 58) { err = true; break; }
					++p;
					n.items.insertLast(Value(depth + 1));
					Ws();
					if (p < s.length() && s[p] == 44) { ++p; continue; }
					if (p < s.length() && s[p] == 125) { ++p; break; }
					err = true;
				}
			} else if (c == 91) {  // [
				n.kind = 3; ++p; Ws();
				if (p < s.length() && s[p] == 93) { ++p; return n; }
				while (!err) {
					n.items.insertLast(Value(depth + 1));
					Ws();
					if (p < s.length() && s[p] == 44) { ++p; continue; }
					if (p < s.length() && s[p] == 93) { ++p; break; }
					err = true;
				}
			} else if (c == 34) {
				n.kind = 2; n.str = Str();
			} else if (c == 116 || c == 102 || c == 110) {  // true false null
				n.kind = (c == 110) ? 0 : 5; n.num = (c == 116) ? 1 : 0;
				while (p < s.length() && s[p] >= 97 && s[p] <= 122) ++p;
			} else {
				const uint b = p;
				while (p < s.length() && ((s[p] >= 48 && s[p] <= 57) || s[p] == 45 || s[p] == 43 || s[p] == 46 || s[p] == 101 || s[p] == 69)) ++p;
				if (p == b) { err = true; return n; }
				n.kind = 1; n.num = parseFloat(s.substr(b, p - b));
			}
			return n;
		}
	}

	JNode@ DecodePayload(const string& in b64) {
		array<uint8> raw;
		if (b64.length() < 8 || !Base64Decode(b64, raw)) return null;
		Inflater@ inf = Inflater();
		if (!inf.Run(raw)) return null;
		string txt = "";
		txt.resize(inf.outb.length());
		for (uint i = 0; i < inf.outb.length(); ++i) txt[i] = inf.outb[i];
		JParser@ jp = JParser();
		jp.s = txt;
		JNode@ root = jp.Value(0);
		return jp.err ? null : root;
	}

	// The arrangement's boxes in elmos; false when malformed.
	bool ReadBoxes(JNode@ arr, array<array<AIFloat3>>& outBoxes) {
		if (arr is null || arr.kind != 4) return false;
		JNode@ sb = arr.Get("startboxes");
		if (sb is null || sb.kind != 3 || sb.items.length() == 0) return false;
		const float sx = float(AiTerrainWidth()) / 200.0f;
		const float sz = float(AiTerrainHeight()) / 200.0f;
		outBoxes.resize(0);
		for (uint i = 0; i < sb.items.length(); ++i) {
			JNode@ poly = (sb.items[i] is null) ? null : sb.items[i].Get("poly");
			if (poly is null || poly.kind != 3 || poly.items.length() < 2) return false;
			array<AIFloat3> pts;
			for (uint j = 0; j < poly.items.length(); ++j) {
				JNode@ q = poly.items[j];
				JNode@ qx = (q is null) ? null : q.Get("x");
				JNode@ qy = (q is null) ? null : q.Get("y");
				if (qx is null || qy is null) return false;
				pts.insertLast(AIFloat3(float(qx.num) * sx, 0, float(qy.num) * sz));
			}
			if (pts.length() == 2) {
				const AIFloat3 a = pts[0], c = pts[1];
				pts.resize(0);
				pts.insertLast(AIFloat3(a.x, 0, a.z));
				pts.insertLast(AIFloat3(c.x, 0, a.z));
				pts.insertLast(AIFloat3(c.x, 0, c.z));
				pts.insertLast(AIFloat3(a.x, 0, c.z));
			}
			outBoxes.insertLast(pts);
		}
		return true;
	}

	string ModOption(dictionary@ mo, const string& in key) {
		string v = "";
		if (mo !is null && mo.exists(key)) mo.get(key, v);
		return v;
	}

	// numAllyTeams: the game's active ally team count (startbox_utilities getActiveAllyTeamCount)
	void Load(int numAllyTeams) {
		loaded = false;
		boxes.resize(0);
		dictionary@ mo = aiSetupMgr.GetModOptions();
		const string ov = ModOption(mo, "mapmetadata_startbox_override");
		if (ov.length() > 8) {
			JNode@ root = DecodePayload(ov);
			array<array<AIFloat3>> b;
			if (root is null) Log("override did not decode");
			else if (ReadBoxes(root, b) && int(b.length()) >= numAllyTeams) {
				boxes = b; loaded = true; source = "override"; return;
			}
		}
		const string st = ModOption(mo, "mapmetadata_startboxes_set");
		if (st.length() > 8) {
			JNode@ root = DecodePayload(st);
			if (root is null || root.kind != 4) { Log("startboxes_set did not decode"); return; }
			int exact = -1, larger = -1, smaller = -1;
			int largerKey = 1 << 30, smallerKey = -1;
			for (uint i = 0; i < root.keys.length(); ++i) {
				const int k = int(parseInt(root.keys[i]));
				if (k == numAllyTeams) exact = int(i);
				else if (k > numAllyTeams && k < largerKey) { largerKey = k; larger = int(i); }
				else if (k < numAllyTeams && k > smallerKey) { smallerKey = k; smaller = int(i); }
			}
			const int pick = (exact >= 0) ? exact : ((larger >= 0) ? larger : smaller);
			if (pick < 0) return;
			array<array<AIFloat3>> b;
			if (ReadBoxes(root.items[pick], b)) {
				boxes = b; loaded = true; source = "map set '" + root.keys[pick] + "'";
			}
		}
	}

	bool InPoly(const array<AIFloat3>& in poly, float x, float z) {
		bool c = false;
		const uint n = poly.length();
		for (uint i = 0, j = n - 1; i < n; j = i++) {
			const float x1 = poly[i].x, z1 = poly[i].z, x2 = poly[j].x, z2 = poly[j].z;
			if (((z1 > z) != (z2 > z)) && (x < (x2 - x1) * (z - z1) / (z2 - z1) + x1)) c = !c;
		}
		return c;
	}

	// 1 inside allyTeam's box, 0 outside, -1 no box known for it
	int BoxAt(int allyTeam, const AIFloat3& in p) {
		if (!loaded || allyTeam < 0 || uint(allyTeam) >= boxes.length()) return -1;
		return InPoly(boxes[allyTeam], p.x, p.z) ? 1 : 0;
	}

	void Log(const string& in msg) {
		GenericHelpers::LogUtil("[StartBoxes] " + msg, 1);
	}
}
