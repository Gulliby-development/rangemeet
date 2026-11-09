import 'rows.dart';

final rows = [
  row([], '', 2, '', 'usage: rangemeet check\n       rangemeet show\n       rangemeet meet\n       rangemeet clash [--limit N]\n       rangemeet pick --have LIST\n'),
  row(['frob'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 2, '', 'rangemeet: unknown command frob\n'),
  row(['check'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 0, 'ok 3 constraints\n', ''),
  row(['show', 'x'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 2, '', 'rangemeet: unexpected argument x\n'),
  row(['meet', '--limit', '1'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 2, '', 'rangemeet: option --limit is not valid for meet\n'),
  row(['pick'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 2, '', 'rangemeet: missing --have\n'),
  row(['check'], 'App ^1\n', 1, '', 'rangemeet: line 1: bad name App\n'),
  row(['show'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 0, 'app >=1.2.3 <2.0.0\nlib >=1.4.0 <2.0.0\ntool >=1.4.0 <1.5.0\n3 constraints\n', ''),
  row(['meet'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 0, 'meet >=1.4.0 <1.5.0 of 3 constraints\n', ''),
  row(['clash'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 0, 'clashes 0\n', ''),
  row(['pick', '--have', '1.5.0,2.0.0'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 1, 'pick none\n', ''),
];

void main() => runRows(rows);
