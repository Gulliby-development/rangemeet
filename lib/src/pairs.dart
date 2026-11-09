/// Pair enumeration and candidate selection for version constraints.
library;

import 'constraint.dart';
import 'registry.dart';
import 'versions.dart';

/// Yields disjoint item pairs once each, in input order.
Iterable<(Item, Item)> clashingPairs(List<Item> items) sync* {
  for (var i = 0; i < items.length; i++) {
    for (var j = i + 1; j < items.length; j++) {
      final first = items[i];
      final second = items[j];
      if (isEmpty(intersect(first.interval, second.interval))) {
        yield (first, second);
      }
    }
  }
}

/// Returns the greatest candidate admitted by [interval], or null when none fits.
Version? highestFitting(List<Version> candidates, Interval interval) {
  if (isEmpty(interval)) {
    return null;
  }

  Version? highest;
  for (final candidate in candidates) {
    if (compareVersions(candidate, interval.low) < 0 || (interval.high != null && compareVersions(candidate, interval.high!) >= 0)) {
      continue;
    }
    if (highest == null || compareVersions(candidate, highest) > 0) {
      highest = candidate;
    }
  }
  return highest;
}
