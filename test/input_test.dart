import 'rows.dart';

final rows = [
  row(['check'], '', 0, 'ok 0 constraints\n', ''),
  row(['check'], '  \t \n\t\n', 0, 'ok 0 constraints\n', ''),
  row(['check'], '  # note\na ^1\n', 0, 'ok 1 constraint\n', ''),
  row(['check'], 'a ^1', 0, 'ok 1 constraint\n', ''),
  row(['check'], 'a ^1\r\r\n', 1, '', 'rangemeet: line 1: bad constraint ^1\r\n'),
  row(['check'], '  a \t ^1   ~1.2  \n', 0, 'ok 1 constraint\n', ''),
  row(['check'], 'a\n', 1, '', 'rangemeet: line 1: expected NAME CONSTRAINT\n'),
  row(['check'], 'a ^1 ^1 ^1 ^1\n', 0, 'ok 1 constraint\n', ''),
  row(['check'], 'a ^1 ^1 ^1 ^1 ^1\n', 1, '', 'rangemeet: line 1: too many comparators (max 4)\n'),
  row(['check'], 'A ^1\n', 1, '', 'rangemeet: line 1: bad name A\n'),
  row(['check'], 'abcdefghijkl ^1\n', 0, 'ok 1 constraint\n', ''),
  row(['check'], 'abcdefghijklm ^1\n', 1, '', 'rangemeet: line 1: bad name abcdefghijklm\n'),
  row(['check'], 'a ^1\na ^2\n', 1, '', 'rangemeet: line 2: duplicate name a\n'),
  row(['check'], 'a ^1\nb ^2\na ^3\n', 1, '', 'rangemeet: line 3: duplicate name a\n'),
  row(['check'], 'a ^1 ^^\n', 1, '', 'rangemeet: line 1: bad constraint ^^\n'),
  row(['check'], 'a ^1 >=2\n', 1, '', 'rangemeet: line 1: constraint admits no version\n'),
  row(['check'], '# c\n\na ^1\nb ^x.1\n', 1, '', 'rangemeet: line 4: bad constraint ^x.1\n'),
  row(['check'], 'a ^1\nb ??\nc ^x.1\n', 1, '', 'rangemeet: line 2: bad constraint ??\n'),
  row(['show'], 'a ^1\nb\n', 1, '', 'rangemeet: line 2: expected NAME CONSTRAINT\n'),
  row(['meet'], 'a ^1\nb 1.x.3\n', 1, '', 'rangemeet: line 2: bad constraint 1.x.3\n'),
];

void main() => runRows(rows);
