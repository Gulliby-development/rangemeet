import 'rows.dart';

final rows = [
  row(['check'], 'a 1.2.3.4\n', 1, '', 'rangemeet: line 1: bad constraint 1.2.3.4\n'),
  row(['check'], 'a ^\n', 1, '', 'rangemeet: line 1: bad constraint ^\n'),
  row(['check'], 'a >=\n', 1, '', 'rangemeet: line 1: bad constraint >=\n'),
  row(['check'], 'a ^x.1\n', 1, '', 'rangemeet: line 1: bad constraint ^x.1\n'),
  row(['check'], 'a 1.x.3\n', 1, '', 'rangemeet: line 1: bad constraint 1.x.3\n'),
  row(['check'], 'a 10000\n', 1, '', 'rangemeet: line 1: bad constraint 10000\n'),
  row(['check'], 'a =>1\n', 1, '', 'rangemeet: line 1: bad constraint =>1\n'),
  row(['check'], 'a 1.\n', 1, '', 'rangemeet: line 1: bad constraint 1.\n'),
  row(['check'], 'a 1.2.3+b\n', 1, '', 'rangemeet: line 1: bad constraint 1.2.3+b\n'),
  row(['check'], 'a ~>1.2\n', 1, '', 'rangemeet: line 1: bad constraint ~>1.2\n'),
  row(['check'], 'a ^ 1\n', 1, '', 'rangemeet: line 1: bad constraint ^\n'),
  row(['check'], 'a >2.0.0 <1.0.0\n', 1, '', 'rangemeet: line 1: constraint admits no version\n'),
  row(['check'], 'a >*\n', 1, '', 'rangemeet: line 1: constraint admits no version\n'),
  row(['check'], 'a <0.0.0\n', 1, '', 'rangemeet: line 1: constraint admits no version\n'),
  row(['check'], 'a ^1 ^2\n', 1, '', 'rangemeet: line 1: constraint admits no version\n'),
  row(['check'], 'a >9999.9999.9999 <9999\n', 1, '', 'rangemeet: line 1: constraint admits no version\n'),
  row(['check'], 'a x\nb *\nc X.X.X\nd 1.*\ne 1.x.*\n', 0, 'ok 5 constraints\n', ''),
  row(['check'], 'a ^0.0.0 ~0 <=0.0.0 >=0.0.0 \n', 0, 'ok 1 constraint\n', ''),
];

void main() => runRows(rows);
