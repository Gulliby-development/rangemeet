/// Reads and validates named constraints from the input text.
library;

import 'constraint.dart';
import 'registry.dart';

List<Item> readItems(String text) {
  if (text.isEmpty) {
    return <Item>[];
  }

  final lines = text.split('\n');
  if (text.endsWith('\n')) {
    lines.removeLast();
  }
  if (lines.length > maxLines) {
    fail(1, 'input is too long (max $maxLines lines)');
  }

  final items = <Item>[];
  final names = <String>{};
  for (var index = 0; index < lines.length; index++) {
    var line = lines[index];
    if (line.endsWith('\r')) {
      line = line.substring(0, line.length - 1);
    }
    final words = line.replaceFirst(RegExp(r'^[ \t]+'), '').replaceFirst(RegExp(r'[ \t]+$'), '').split(RegExp(r'[ \t]+'));
    if (words.length == 1 && words[0].isEmpty) {
      continue;
    }
    if (words[0].startsWith('#')) {
      continue;
    }

    final lineNumber = index + 1;
    Never lineFailure(String reason) => fail(1, 'line $lineNumber: $reason');

    if (words.length == 1) {
      lineFailure('expected NAME CONSTRAINT');
    }
    if (words.length > maxComparators + 1) {
      lineFailure('too many comparators (max $maxComparators)');
    }

    final name = words[0];
    if (name.length > maxNameLength || !RegExp(r'^[a-z][a-z0-9-]*$').hasMatch(name)) {
      lineFailure('bad name $name');
    }

    final intervals = <Interval>[];
    for (final word in words.skip(1)) {
      final interval = parseComparator(word);
      if (interval == null) {
        lineFailure('bad constraint $word');
      }
      intervals.add(interval);
    }

    var combined = intervals.first;
    for (final interval in intervals.skip(1)) {
      combined = intersect(combined, interval);
    }
    if (isEmpty(combined)) {
      lineFailure('constraint admits no version');
    }
    if (names.contains(name)) {
      lineFailure('duplicate name $name');
    }
    names.add(name);
    items.add(Item(lineNumber, name, combined));
  }
  return items;
}
