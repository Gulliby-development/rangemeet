/// The pick command reports the greatest candidate admitted by all constraints.
library;

import '../pairs.dart';
import '../registry.dart';
import '../render.dart';
import '../versions.dart';

Result runPick(Options options, List<Item> items) {
  final selected = highestFitting(options.have, meetAll(items));
  if (selected == null) {
    return const Result(1, 'pick none\n', '');
  }
  return Result(0, 'pick ${versionText(selected)}\n', '');
}
