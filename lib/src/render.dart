/// Canonical interval rendering and aggregate intersection.
library;

import 'constraint.dart';
import 'registry.dart';
import 'versions.dart';

const Version _zero = Version(0, 0, 0);

/// Renders a nonempty interval in its shortest canonical form.
///
/// Callers must check [isEmpty] before rendering an interval.
String intervalText(Interval interval) {
  final low = interval.low;
  final high = interval.high;
  if (compareVersions(low, _zero) == 0 && high == null) {
    return '*';
  }
  if (high != null && high.major == low.major && high.minor == low.minor && high.patch == low.patch + 1) {
    return '=${versionText(low)}';
  }
  if (high == null) {
    return '>=${versionText(low)}';
  }
  if (compareVersions(low, _zero) == 0) {
    return '<${versionText(high)}';
  }
  return '>=${versionText(low)} <${versionText(high)}';
}

/// Intersects every item interval, starting with the universal interval.
Interval meetAll(List<Item> items) {
  var result = const Interval(_zero, null);
  for (final item in items) {
    result = intersect(result, item.interval);
  }
  return result;
}
