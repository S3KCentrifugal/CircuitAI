# Preserve the component benchmark's detailed measurements

## Summary

Published a supplement to D-221's original component benchmark record. This
preserves the same measurements and compiler/source pins; it is not a rerun.

## Changes

The initial archive omitted `kernel-results.json` because the archiver excludes
`*-results.json` from input metadata. A new immutable record stores its original
bytes as `kernel-measurements.json` and retains validation output with hashes.
The implementation report and benchmark index now link this supplement.

## Reasoning

Keep the original published verdict and hashes intact. Correct evidence
packaging through an explicitly labelled supplement, without changing measured
values or presenting another record as another executed test.

## Validation

The supplement's measurement hash equals the original scratch result. No
gameplay, binary or test assertions changed. Original native and live results
and their limitations still apply. See the
[report](../../../../doc/reviews/2026-10-06-extra-high-performance-remediation.md).
