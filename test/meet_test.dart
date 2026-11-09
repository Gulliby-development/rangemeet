import 'rows.dart';

final rows = [
  row(['meet'], '', 0, 'meet * of 0 constraints\n', ''),
  row(['meet'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 0, 'meet >=1.4.0 <1.5.0 of 3 constraints\n', ''),
  row(['meet'], 'a *\n', 0, 'meet * of 1 constraint\n', ''),
  row(['meet'], 'a ^1.2.3\n', 0, 'meet >=1.2.3 <2.0.0 of 1 constraint\n', ''),
  row(['meet'], 'a =1.2.3\n', 0, 'meet =1.2.3 of 1 constraint\n', ''),
  row(['meet'], 'a ^1\nb ^1.5\nc ~1.6\n', 0, 'meet >=1.6.0 <1.7.0 of 3 constraints\n', ''),
  row(['meet'], 'a ^1\nb ^2\n', 1, 'meet empty of 2 constraints\n', ''),
  row(['meet'], 'a >=1\nb <1\n', 1, 'meet empty of 2 constraints\n', ''),
  row(['meet'], 'a >=1.0.0\nb <=1.9.9\n', 0, 'meet >=1.0.0 <1.9.10 of 2 constraints\n', ''),
  row(['meet'], 'a ^0.2\nb ^0.2.5\nc =0.2.7\n', 0, 'meet =0.2.7 of 3 constraints\n', ''),
  row(['meet'], 'a 1.x\nb 1.2.x\nc 1.2.3 >=1.2.3\n', 0, 'meet =1.2.3 of 3 constraints\n', ''),
  row(['meet'], 'a *\nb x\nc ~*\n', 0, 'meet * of 3 constraints\n', ''),
  row(['meet'], 'a <2\nb >=1.5\nc ^1.4\n', 0, 'meet >=1.5.0 <2.0.0 of 3 constraints\n', ''),
  row(['meet'], 'a >1.2.3\nb <1.2.5\n', 0, 'meet =1.2.4 of 2 constraints\n', ''),
  row(['meet'], 'a >1.2.3\nb <1.2.4\n', 1, 'meet empty of 2 constraints\n', ''),
  row(['meet'], '# c\n\napp ^1.2\n\n# d\nlib ~1.2.9\n', 0, 'meet >=1.2.9 <1.3.0 of 2 constraints\n', ''),
  row(['meet'], 'app ^1.2\r\nlib ~1.2.9\r\n', 0, 'meet >=1.2.9 <1.3.0 of 2 constraints\n', ''),
  row(['meet'], 'a <0.0.1\nb >=0.0.0\n', 0, 'meet =0.0.0 of 2 constraints\n', ''),
];

void main() => runRows(rows);
