import 'rows.dart';

final rows = [
  row(['pick', '--have', '1.0.0'], '', 0, 'pick 1.0.0\n', ''),
  row(['pick', '--have', '1.0.0'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 1, 'pick none\n', ''),
  row(['pick', '--have', '1.4.0'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 0, 'pick 1.4.0\n', ''),
  row(['pick', '--have', '1.5.0'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 1, 'pick none\n', ''),
  row(['pick', '--have', '1.3.9,1.4.2,1.4.10,1.4.9'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 0, 'pick 1.4.10\n', ''),
  row(['pick', '--have', '2.0.0,1.9.0,1.4.5'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 0, 'pick 1.4.5\n', ''),
  row(['pick', '--have', '1.10.0,1.9.0'], 'a ^1\n', 0, 'pick 1.10.0\n', ''),
  row(['pick', '--have', '1.9.0,1.10.0'], 'a ^1\n', 0, 'pick 1.10.0\n', ''),
  row(['pick', '--have', '0.0.9,0.0.10'], 'a *\n', 0, 'pick 0.0.10\n', ''),
  row(['pick', '--have', '9999.9999.9999'], 'a >=9999\n', 0, 'pick 9999.9999.9999\n', ''),
  row(['pick', '--have', '0.0.0'], 'a *\nb ^0\n', 0, 'pick 0.0.0\n', ''),
  row(['pick', '--have', '3.0.0,2.0.0'], 'old <1.0.0\nmid >=1.0.0 <2.0.0\nnew >=2.0.0\nany *\n', 1, 'pick none\n', ''),
  row(['pick', '--have', '2.5.0'], 'old <1.0.0\nmid >=1.0.0 <2.0.0\nnew >=2.0.0\nany *\n', 1, 'pick none\n', ''),
  row(['pick', '--have', '1.0.0,1.1.0,1.2.0'], 'a ^1\nb ^1.1\n', 0, 'pick 1.2.0\n', ''),
  row(['pick', '--have', '1.2.3'], 'a =1.2.3\nb <1.2.3\n', 1, 'pick none\n', ''),
];

void main() => runRows(rows);
