import 'rows.dart';

final rows = [
  row(['check', '--limit', '5'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 2, '', 'rangemeet: option --limit is not valid for check\n'),
  row(['clash', '--have', '1.0.0'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 2, '', 'rangemeet: option --have is not valid for clash\n'),
  row(['check', '--nope'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 2, '', 'rangemeet: unknown option --nope\n'),
  row(['clash', '5'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 2, '', 'rangemeet: unexpected argument 5\n'),
  row(['clash', '--limit', '1', '--limit', '2'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 2, '', 'rangemeet: given twice: --limit\n'),
  row(['pick', '--have', '1.0.0', '--have', 'bad'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 2, '', 'rangemeet: given twice: --have\n'),
  row(['clash', '--limit'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 2, '', 'rangemeet: missing value for --limit\n'),
  row(['pick', '--have'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 2, '', 'rangemeet: missing value for --have\n'),
  row(['clash', '--limit', '--limit'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 2, '', 'rangemeet: bad value for --limit\n'),
  row(['pick', '--have', '--have'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 2, '', 'rangemeet: bad value for --have\n'),
  row(['clash', '--limit', 'x'], 'frob\n', 2, '', 'rangemeet: bad value for --limit\n'),
  row(['clash', '--limit', '1'], 'old <1.0.0\nmid >=1.0.0 <2.0.0\nnew >=2.0.0\nany *\n', 1, 'old mid\nand 2 more pairs\nclashes 3\n', ''),
  row(['clash', '--limit', '2'], 'old <1.0.0\nmid >=1.0.0 <2.0.0\nnew >=2.0.0\nany *\n', 1, 'old mid\nold new\nand 1 more pair\nclashes 3\n', ''),
  row(['clash', '--limit', '3'], 'old <1.0.0\nmid >=1.0.0 <2.0.0\nnew >=2.0.0\nany *\n', 1, 'old mid\nold new\nmid new\nclashes 3\n', ''),
  row(['pick', '--have', '1.4.1,1.9.0,2.0.0'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 0, 'pick 1.4.1\n', ''),
  row(['pick', '--have', '0.9.0,3.0.0'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 1, 'pick none\n', ''),
];

void main() => runRows(rows);
