<p align="center"><img src="docs/logo.svg" width="96" alt="" /></p>

# rangemeet

[![CI](https://github.com/Gulliby-development/rangemeet/actions/workflows/ci.yml/badge.svg)](https://github.com/Gulliby-development/rangemeet/actions/workflows/ci.yml) [![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

rangemeet helps package maintainers compare several version constraints: see each range, find their common range, identify incompatible pairs, or choose the best available version. It is intended for terminal users and for scripts and CI. The program is offline and uses only the Dart standard library at runtime.

## Build and run

Use Dart SDK 3.8.0 or newer (the package constraint is `^3.8.0`). The package supports Windows, macOS and Linux. From the repository directory, run:

```sh
dart run bin/rangemeet.dart COMMAND
```

Replace `COMMAND` with one of the commands below. The examples use `rangemeet` as shorthand for `dart run bin/rangemeet.dart` in that directory. The example shell syntax is POSIX; the Dart program itself is cross-platform. The first dependency setup may need the package's development tools, but running rangemeet does not need network access.

## Commands

```text
usage: rangemeet check
       rangemeet show
       rangemeet meet
       rangemeet clash [--limit N]
       rangemeet pick --have LIST
```

The commands read constraints from standard input. `help`, `-h` and `--help` as the first argument print the five-line usage and exit 0, ignoring any following arguments. `--version` prints `rangemeet 0.1.0` and exits 0, also ignoring following arguments. With no command, usage goes to standard error and the exit status is 2. Command names are lowercase.

- `check` exits 0 and prints `ok N constraints`; for one item the exact form is `ok 1 constraint`. With no constraints it prints `ok 0 constraints`.
- `show` exits 0 and prints one `NAME INTERVAL` line per constraint in input order, then `N constraints` (singular `1 constraint`). With no constraints its only line is `0 constraints`.
- `meet` prints `meet INTERVAL of N constraints` (singular `1 constraint`), or `meet empty of N constraints` when the intersection is empty. No constraints produce `meet * of 0 constraints`. A nonempty meet exits 0; an empty meet exits 1.
- `clash` prints each disjoint pair as `NAME1 NAME2`, then `clashes K`. Pairs are ordered by the earlier input index and then the later input index; touching bounds are disjoint. No pairs, including with empty input, produce `clashes 0` and exit 0; one or more pairs exit 1. `--limit N` displays at most N pairs while K still counts all pairs. If pairs are omitted, it prints `and M more pair` when M is 1 and `and M more pairs` otherwise, immediately before the total.
- `pick --have LIST` prints `pick VERSION` for the numerically highest listed version admitted by every constraint, or `pick none` and exits 1 if none fits. With no constraints, the highest candidate wins; duplicate candidates do not change the result.

Successful commands write their result to standard output and nothing to standard error. Command-line errors exit 2; invalid input exits 1. Errors write nothing to standard output and one line to standard error in the form `rangemeet: MESSAGE`. Clashes and empty meet/pick results use their command-specific output and status above, not a diagnostic.

## Input and version rules

Each non-comment, non-blank line has a unique name followed by one to four comparators, for example `app ^1.2.3`. Names are 1–12 characters: a lowercase letter followed by lowercase letters, digits or hyphens. Only spaces and tabs separate words; surrounding spaces and tabs are ignored. A line containing only spaces/tabs is skipped, as is a line whose first word starts with `#`. Text is split at LF; empty text has no lines, while a final unterminated line counts. Exactly one CR at the end of each line is removed. Skipped lines still count for diagnostic line numbers. At most 40 lines are allowed, including skipped lines.

A version part is a decimal whole number from 0 through 9999, with no leading zero except for zero itself. Partial versions contain one to three dot-separated parts. Missing numeric parts are filled with zero; a wildcard (`x`, `X` or `*`) may replace the remaining parts, but cannot precede a number. Thus `1.x`, `1.2.x`, `1.x.x` and `x` are valid partial versions, while `x.1` and `1.x.3` are not. Versions compare numerically by major, minor and patch; for example, 1.10.0 is greater than 1.9.0. Candidate versions for `pick` are exactly three numeric parts, separated by commas, with 1–20 candidates and no spaces.

A comparator is an optional operator followed by a partial version. The supported operators are `^`, `~`, `>=`, `<=`, `>`, `<` and `=`; omitting the operator has the same range meaning as `=`. The longest operator that begins a comparator is used. For the rules below, N is the number of leading numeric parts before any wildcard, A.B.C is the version formed by filling missing parts with zero, and NEXT is the first version above all versions beginning with those N numeric parts: for N=3 it is A.B.(C+1), for N=2 it is A.(B+1).0, and for N=1 it is (A+1).0.0. For N=0, NEXT does not exist.

Ranges are half-open: LOW is included and HIGH is excluded. Each comparator defines this interval:

| Form | LOW | HIGH |
| --- | --- | --- |
| No operator or `=` | A.B.C | NEXT, or no upper bound when N=0 |
| `>=` | A.B.C | No upper bound |
| `>` | NEXT | No upper bound; empty when N=0 |
| `<` | 0.0.0 | A.B.C |
| `<=` | 0.0.0 | NEXT, or no upper bound when N=0 |
| `~` with N=0 | 0.0.0 | No upper bound |
| `~` with N=1 | A.B.C | NEXT |
| `~` with N=2 or 3 | A.B.C | A.(B+1).0 |
| `^` with N=0 | 0.0.0 | No upper bound |
| `^` with N>0, A>0 or N=1 | A.B.C | (A+1).0.0 |
| `^` with N>0, A=0 and (B>0 or N=2) | A.B.C | 0.(B+1).0 |
| `^` otherwise | A.B.C | 0.0.(C+1) |

For example, `>1.2` starts at 1.3.0, `~1` spans the major-1 range, `~*` spans all versions, `^0` ends at 1.0.0, `^0.0` ends at 0.1.0, and `^0.0.0` ends at 0.0.1. Multiple comparators on one line intersect to form its interval; if that interval admits no version, the line is invalid. Calculated bounds can contain a component of 10000 in either LOW or HIGH, such as the LOW from `>9999.9999.9999`; these are output as-is, never normalized. Intervals use the shortest matching form, in this order: `*` for all versions; `=A.B.C` for one exact version; `>=LOW` when unbounded above; `<HIGH` when starting at zero; otherwise `>=LOW <HIGH`. Counts use singular for one and plural otherwise, including zero.

## Diagnostics

Input exceeding 40 lines fails first with `rangemeet: input is too long (max 40 lines)`. For each other non-skipped line, the first applicable problem is reported as `rangemeet: line N: REASON`, where N counts all lines. Validation order is: one-word line (`expected NAME CONSTRAINT`); more than four comparators (`too many comparators (max 4)`); invalid first word/name (`bad name WORD`); first invalid comparator (`bad constraint WORD`); empty intersection (`constraint admits no version`); repeated name (`duplicate name NAME`). WORD and NAME are the offending input tokens, unchanged.

Command-line words are checked left to right, stopping at the first problem before input is read. An empty word, `-`, or any word not beginning with `-` where an option is expected is `rangemeet: unexpected argument WORD`. An unrecognized dash-prefixed word is `rangemeet: unknown option WORD`; a known option not accepted by the command is `rangemeet: option OPTION is not valid for COMMAND`. Each option consumes the next word as its value even if it looks like an option. For an option, errors are checked in this order: repeated option (`given twice: OPTION`), missing next word (`missing value for OPTION`), then malformed value (`bad value for OPTION`). `--limit` accepts decimal 1–1000 without a leading zero. `--have` accepts 1–20 three-part numeric versions separated by commas, with no spaces. After parsing, `pick` without `--have` reports `missing --have`. An unknown first command reports `rangemeet: unknown command WORD`; invalid UTF-8 input reports `rangemeet: input is not valid UTF-8`.

## Examples

These POSIX shell examples are run from the repository directory.

```text
$ printf 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n' | rangemeet show
app >=1.2.3 <2.0.0
lib >=1.4.0 <2.0.0
tool >=1.4.0 <1.5.0
3 constraints
$ printf 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n' | rangemeet meet; printf 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n' | rangemeet pick --have 1.3.9,1.4.7,1.5.0
meet >=1.4.0 <1.5.0 of 3 constraints
pick 1.4.7
$ printf 'old <1.0.0\nmid >=1.0.0 <2.0.0\nnew >=2.0.0\nany *\n' | rangemeet clash --limit 2
old mid
old new
and 1 more pair
clashes 3
$ printf 'a ^1.x.3\n' | rangemeet check 2>&1; printf 'a >2 <1\n' | rangemeet check 2>&1
rangemeet: line 1: bad constraint ^1.x.3
rangemeet: line 1: constraint admits no version
```

## Library and development

The library `package:rangemeet/rangemeet.dart` exports `Result`, `readsStdin(List<String>)` and `run(List<String>, String)`. `readsStdin` is true only for a valid command line that reads standard input, including its option checks; help, version and invalid command lines do not read it. `run` returns the exit status, standard output and standard error as a `Result`. The executable handles stream I/O and invalid UTF-8 decoding.

Run the project checks from the repository directory:

```sh
dart format --output=none --set-exit-if-changed .
dart analyze --fatal-infos
dart test
```

See [LICENSE](LICENSE) for the MIT license.

---

Built with [BAKED](https://github.com/Gulliby-development/baked), an open-source coding agent (bench round R98).
