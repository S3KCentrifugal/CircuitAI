#!/usr/bin/env python3
"""Release notes for an SMRTBARb release: what changed since the channel's
previous release, grouped and short, for players rather than developers.

    tools/release/notes.py <version> <channel> [<previous tag>]

<version> is e.g. 1.958, <channel> test or prod. The previous release is the
nearest earlier tag of the same channel (v*-<channel>), else the nearest earlier
release tag of any kind. Commit subjects follow "type(scope): text"
(conventional commits); each becomes one line:

    feat -> New, fix -> Fixes, perf -> Improvements,
    anything else (ci, chore, docs, refactor, ...) -> folded under Maintenance.

Decision ids (D-112) and the scope stay as short tags so a line can be traced.
Prints Markdown on stdout.
"""
import re
import subprocess
import sys

REPO_URL = "https://github.com/S3KCentrifugal/CircuitAI"
GROUPS = [("feat", "New"), ("fix", "Fixes"), ("perf", "Improvements")]
SUBJECT = re.compile(r"^(?P<type>[a-z]+)(\((?P<scope>[^)]*)\))?(?P<bang>!)?:\s*(?P<text>.+)$")


def git(*args):
    return subprocess.run(["git", *args], capture_output=True, text=True, check=False).stdout.strip()


def previous_tag(channel):
    for pattern in ("v*-%s" % channel, "v*"):
        tag = git("describe", "--tags", "--abbrev=0", "--match", pattern, "HEAD")
        if tag:
            return tag
    return ""


def friendly(text):
    text = text.strip().rstrip(".")
    return text[:1].upper() + text[1:] if text else text


def main():
    if len(sys.argv) < 3:
        sys.exit(__doc__)
    version, channel = sys.argv[1], sys.argv[2]
    prev = sys.argv[3] if len(sys.argv) > 3 else previous_tag(channel)
    rng = "%s..HEAD" % prev if prev else "HEAD"
    log = git("log", "--no-merges", "--format=%h%x09%s", rng)
    if not prev:
        log = "\n".join(log.splitlines()[:30])   # no earlier release: the last 30 changes

    grouped = {name: [] for _, name in GROUPS}
    maintenance, other = [], []
    for line in log.splitlines():
        sha, _, subject = line.partition("\t")
        m = SUBJECT.match(subject)
        if not m:
            other.append((sha, friendly(subject)))
            continue
        kind, scope, text = m.group("type"), (m.group("scope") or "").strip(), m.group("text")
        # the decision id in front of the text becomes a tag at the end
        did = re.match(r"^(D-\d+)\s+(.*)$", text)
        tags = [t for t in (scope, did.group(1) if did else "") if t]
        text = friendly(did.group(2) if did else text)
        entry = (sha, text + (" (" + ", ".join(tags) + ")" if tags else ""))
        name = dict(GROUPS).get(kind)
        (grouped[name] if name else maintenance).append(entry)

    out = []
    if channel == "test":
        out.append("**Test build** - for trying out before it reaches prod; may be unstable.")
    else:
        out.append("**Production build** - the recommended version.")
    out.append("")
    changes = sum(len(v) for v in grouped.values()) + len(other) + len(maintenance)
    since = ("since [%s](%s/releases/tag/%s)" % (prev, REPO_URL, prev)) if prev else "(first release)"
    out.append("%d change%s %s." % (changes, "" if changes == 1 else "s", since))
    for _, name in GROUPS:
        if grouped[name]:
            out.append("")
            out.append("### " + name)
            out.extend("- %s" % text for _, text in grouped[name])
    if other:
        out.append("")
        out.append("### Other changes")
        out.extend("- %s" % text for _, text in other)
    if maintenance:
        out.append("")
        out.append("<details><summary>Maintenance (%d)</summary>" % len(maintenance))
        out.append("")
        out.extend("- %s" % text for _, text in maintenance)
        out.append("")
        out.append("</details>")
    if not changes:
        out.append("")
        out.append("No changes since the previous release.")

    tag = "v%s-%s" % (version, channel)
    out += [
        "",
        "### Install",
        "Unzip `SMRTBARb-%s.zip` into `<BAR>/data/engine/<engine version>/AI/Skirmish/` "
        "(it creates `SMRTBARb/stable/`)." % tag,
        "",
        "`SMRTBARb-%s-dbg.zip` holds the debug symbols of this build, for reading a crash report." % tag,
    ]
    if prev:
        out += ["", "[Full list of commits](%s/compare/%s...%s)" % (REPO_URL, prev, tag)]
    print("\n".join(out))


if __name__ == "__main__":
    main()
