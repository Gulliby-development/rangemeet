/// The show command renders each accepted constraint in input order.
library;

import '../registry.dart';
import '../render.dart';
import '../report.dart';

Result runShow(Options options, List<Item> items) {
  final output = StringBuffer();
  for (final item in items) {
    output.writeln('${item.name} ${intervalText(item.interval)}');
  }
  output.writeln(plural(items.length, 'constraint'));
  return Result(0, output.toString(), '');
}
