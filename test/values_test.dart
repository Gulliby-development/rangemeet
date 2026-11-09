import 'rows.dart';

final rows = [
  row(['clash', '--limit', '0'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 2, '', 'rangemeet: bad value for --limit\n'),
  row(['clash', '--limit', '1001'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 2, '', 'rangemeet: bad value for --limit\n'),
  row(['clash', '--limit', '1.5'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 2, '', 'rangemeet: bad value for --limit\n'),
  row(['clash', '--limit', '\u0663'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 2, '', 'rangemeet: bad value for --limit\n'),
  row(['pick', '--have', ''], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 2, '', 'rangemeet: bad value for --have\n'),
  row(['pick', '--have', ','], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 2, '', 'rangemeet: bad value for --have\n'),
  row(['pick', '--have', '1.2.3.4'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 2, '', 'rangemeet: bad value for --have\n'),
  row(['pick', '--have', '1.2.x'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 2, '', 'rangemeet: bad value for --have\n'),
  row(['pick', '--have', '01.2.3'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 2, '', 'rangemeet: bad value for --have\n'),
  row(['pick', '--have', 'a.b.c'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 2, '', 'rangemeet: bad value for --have\n'),
  row(['pick', '--have', '^1.2.3'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 2, '', 'rangemeet: bad value for --have\n'),
  row(['pick', '--have', '1.2.3 '], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 2, '', 'rangemeet: bad value for --have\n'),
];

void main() => runRows(rows);
