/// The meet command reports the aggregate interval of all constraints.
library;

import '../constraint.dart';
import '../registry.dart';
import '../render.dart';
import '../report.dart';

Result runMeet(Options options, List<Item> items) {
  final interval = meetAll(items);
  final count = plural(items.length, 'constraint');
  if (isEmpty(interval)) {
    return Result(1, 'meet empty of $count\n', '');
  }
  return Result(0, 'meet ${intervalText(interval)} of $count\n', '');
}
