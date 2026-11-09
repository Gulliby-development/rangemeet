import 'rows.dart';

final rows = [
  row(['meet'], 'a ^1\nb ^2\n', 1, 'meet empty of 2 constraints\n', ''),
  row(['meet'], 'a <2.0.0\nb >=2.0.0\n', 1, 'meet empty of 2 constraints\n', ''),
  row(['meet'], 'a <=2.0.0\nb >=2.0.0\n', 0, 'meet =2.0.0 of 2 constraints\n', ''),
  row(['meet'], 'a <=2.0.0\nb >2.0.0\n', 1, 'meet empty of 2 constraints\n', ''),
  row(['meet'], 'a ^0.0.3\nb ^0.0.4\n', 1, 'meet empty of 2 constraints\n', ''),
  row(['meet'], 'a ^0.2\nb ^0.3\n', 1, 'meet empty of 2 constraints\n', ''),
  row(['clash'], 'a <2.0.0\nb >=2.0.0\n', 1, 'a b\nclashes 1\n', ''),
  row(['clash'], 'a <=2.0.0\nb >=2.0.0\n', 0, 'clashes 0\n', ''),
  row(['clash'], 'a <=2.0.0\nb >2.0.0\n', 1, 'a b\nclashes 1\n', ''),
  row(['clash'], 'a ^0.0.3\nb ^0.0.4\n', 1, 'a b\nclashes 1\n', ''),
  row(['clash'], 'a ^0.2\nb ^0.3\n', 1, 'a b\nclashes 1\n', ''),
  row(['pick', '--have', '1.9.9,2.0.0'], 'a <2.0.0\n', 0, 'pick 1.9.9\n', ''),
  row(['pick', '--have', '1.9.9,2.0.0'], 'a <=2.0.0\n', 0, 'pick 2.0.0\n', ''),
  row(['pick', '--have', '1.9.9,2.0.0'], 'a >1.9.9\n', 0, 'pick 2.0.0\n', ''),
  row(['pick', '--have', '1.9.9,2.0.0'], 'a >=2.0.0\nb <=2.0.0\n', 0, 'pick 2.0.0\n', ''),
  row(['pick', '--have', '0.0.0'], 'a ^0.0.0\n', 0, 'pick 0.0.0\n', ''),
  row(['pick', '--have', '0.0.1'], 'a ^0.0.0\n', 1, 'pick none\n', ''),
];

void main() => runRows(rows);
