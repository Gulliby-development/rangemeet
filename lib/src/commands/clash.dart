/// The clash command reports pairs of constraints with no shared version.
library;

import '../pairs.dart';
import '../registry.dart';
import '../report.dart';

Result runClash(Options options, List<Item> items) {
  final output = StringBuffer();
  var count = 0;
  var displayed = 0;
  for (final (first, second) in clashingPairs(items)) {
    count++;
    if (options.limit == null || displayed < options.limit!) {
      output.writeln('${first.name} ${second.name}');
      displayed++;
    }
  }

  final omitted = count - displayed;
  if (omitted > 0) {
    output.writeln('and ${plural(omitted, 'more pair')}');
  }
  output.writeln('clashes $count');
  return Result(count > 0 ? 1 : 0, output.toString(), '');
}
