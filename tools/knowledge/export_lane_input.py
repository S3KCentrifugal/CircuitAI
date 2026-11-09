"""Offline FLD1 terrain fixture from an installed SMF archive (no running game).

Requires numpy and 7-Zip. Reconstructs Recoil ReadMap's triangle-normal slope
formula; this is archive-derived evidence, not an engine-captured input dump.
Start boxes are explicit and map options/terrain deformation are not applied.
"""
import argparse
import os
from pathlib import Path
import shutil
import struct
import subprocess

import numpy as np


def export(archive, member, output, name, axis="ns", height_min=None, height_max=None):
    raw = subprocess.check_output([
        os.environ.get("SEVENZIP") or shutil.which("7z") or "C:/Program Files/7-Zip/7z.exe",
        "x", "-so", str(archive), member])
    if raw[:16] != b"spring map file\0":
        raise ValueError("Expected SMF map")
    x, z = struct.unpack_from("<ii", raw, 24)
    low, high, ptr = struct.unpack_from("<ffi", raw, 44)
    if height_min is not None: low = height_min
    if height_max is not None: high = height_max
    h = np.frombuffer(raw, dtype="<u2", count=(x+1)*(z+1), offset=ptr)
    h = (h.astype(np.float32) * np.float32((high-low)/65535) + np.float32(low)).reshape(z+1, x+1)
    tl, tr, bl, br = h[:-1, :-1], h[:-1, 1:], h[1:, :-1], h[1:, 1:]
    n1 = 8 / np.sqrt(64 + (tr-tl)**2 + (bl-tl)**2)
    n2 = 8 / np.sqrt(64 + (bl-br)**2 + (tr-br)**2)
    faces = np.stack([n[dz::2, dx::2] for n in (n1, n2) for dz in (0, 1) for dx in (0, 1)])
    avg, minimum = faces.mean(axis=0), faces.min(axis=0)
    slopes = 1 - (minimum + (avg-minimum)*(minimum/avg))
    # Engine GetHeightMap returns centre heights (mean of four corners).
    heights = ((tl+tr+bl+br)*np.float32(.25)).astype("<f4")
    w, d = x*8, z*8
    boxes = [(0, w, 0, d*.2), (0, w, d*.8, d)] if axis == "ns" else [(0, w*.2, 0, d), (w*.8, w, 0, d)]
    out = bytearray(b"FLD1" + struct.pack("<10i", w, d, x, z, x//2, z//2, 0, 2, 0, 0))
    for values in (heights, slopes.astype("<f4")):
        out += struct.pack("<i", values.size) + values.tobytes()
    for i, box in enumerate(boxes):
        out += struct.pack("<i4f", i, *box)
    encoded = name.encode()
    out += struct.pack("<i", len(encoded)) + encoded
    Path(output).write_bytes(out)


if __name__ == "__main__":
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--archive", required=True)
    p.add_argument("--member", required=True)
    p.add_argument("--out", required=True)
    p.add_argument("--name", required=True)
    p.add_argument("--axis", choices=["ns", "ew"], default="ns")
    p.add_argument("--height-min", type=float)
    p.add_argument("--height-max", type=float)
    a = p.parse_args()
    export(a.archive, a.member, a.out, a.name, a.axis, a.height_min, a.height_max)
