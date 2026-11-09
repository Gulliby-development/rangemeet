/// Comparator parsing and interval algebra for version constraints.
library;

import 'registry.dart';
import 'versions.dart';

const Version _zero = Version(0, 0, 0);

/// Parses one comparator and converts it to its half-open version interval.
Interval? parseComparator(String text) {
  if (text.isEmpty) {
    return null;
  }

  var operator = '';
  var value = text;
  for (final candidate in const ['>=', '<=', '^', '~', '>', '<', '=']) {
    if (text.startsWith(candidate)) {
      operator = candidate;
      value = text.substring(candidate.length);
      break;
    }
  }
  if (value.isEmpty) {
    return null;
  }

  final parts = value.split('.');
  if (parts.isEmpty || parts.length > 3 || parts.any((part) => part.isEmpty)) {
    return null;
  }

  final numbers = <int>[];
  var wildcardSeen = false;
  for (final part in parts) {
    if (part == 'x' || part == 'X' || part == '*') {
      wildcardSeen = true;
    } else {
      final number = parseNumber(part);
      if (number == null || wildcardSeen) {
        return null;
      }
      numbers.add(number);
    }
  }

  final count = numbers.length;
  final major = count > 0 ? numbers[0] : 0;
  final minor = count > 1 ? numbers[1] : 0;
  final patch = count > 2 ? numbers[2] : 0;
  final version = Version(major, minor, patch);
  final next = switch (count) {
    3 => Version(major, minor, patch + 1),
    2 => Version(major, minor + 1, 0),
    1 => Version(major + 1, 0, 0),
    _ => null,
  };

  switch (operator) {
    case '':
    case '=':
      return Interval(version, next);
    case '>=':
      return Interval(version, null);
    case '>':
      return Interval(next ?? _zero, next == null ? _zero : null);
    case '<':
      return Interval(_zero, version);
    case '<=':
      return Interval(_zero, next);
    case '~':
      if (count == 0) {
        return Interval(_zero, null);
      }
      if (count == 1) {
        return Interval(version, next);
      }
      return Interval(version, Version(major, minor + 1, 0));
    case '^':
      if (count == 0) {
        return Interval(_zero, null);
      }
      final high = major > 0 || count == 1
          ? Version(major + 1, 0, 0)
          : minor > 0 || count == 2
          ? Version(0, minor + 1, 0)
          : Version(0, 0, patch + 1);
      return Interval(version, high);
  }
  return null;
}

/// Whether an interval has no values because its finite upper bound is not above its lower bound.
bool isEmpty(Interval interval) => interval.high != null && compareVersions(interval.high!, interval.low) <= 0;

/// Intersects two intervals, treating a missing high endpoint as infinity.
Interval intersect(Interval a, Interval b) {
  final low = compareVersions(a.low, b.low) >= 0 ? a.low : b.low;
  final high = a.high == null
      ? b.high
      : b.high == null
      ? a.high
      : compareVersions(a.high!, b.high!) <= 0
      ? a.high
      : b.high;
  return Interval(low, high);
}
