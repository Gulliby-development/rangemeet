import 'rows.dart';

final rows = [
  row(['clash'], '', 0, 'clashes 0\n', ''),
  row(['clash'], 'a ^1\n', 0, 'clashes 0\n', ''),
  row(['clash'], 'app ^1.2.3\nlib >=1.4.0 <2.0.0\ntool ~1.4\n', 0, 'clashes 0\n', ''),
  row(['clash'], 'old <1.0.0\nmid >=1.0.0 <2.0.0\nnew >=2.0.0\nany *\n', 1, 'old mid\nold new\nmid new\nclashes 3\n', ''),
  row(['clash'], 'a ^1\nb ^2\nc ^3\n', 1, 'a b\na c\nb c\nclashes 3\n', ''),
  row(['clash'], 'a ^1\nb ^2\nc ^1.5\nd ^3\ne ^2.5\n', 1, 'a b\na d\na e\nb c\nb d\nc d\nc e\nd e\nclashes 8\n', ''),
  row(['clash'], 'a ^1\nb ~1.5\nc <1.2\n', 1, 'b c\nclashes 1\n', ''),
  row(['clash'], 'a *\nb *\nc *\n', 0, 'clashes 0\n', ''),
  row(['clash', '--limit', '1'], 'a ^1\nb ^2\nc ^3\n', 1, 'a b\nand 2 more pairs\nclashes 3\n', ''),
  row(['clash', '--limit', '2'], 'a ^1\nb ^2\nc ^3\n', 1, 'a b\na c\nand 1 more pair\nclashes 3\n', ''),
  row(['clash', '--limit', '3'], 'a ^1\nb ^2\nc ^3\n', 1, 'a b\na c\nb c\nclashes 3\n', ''),
  row(['clash', '--limit', '1'], 'a ^1\n', 0, 'clashes 0\n', ''),
  row(['clash', '--limit', '1000'], 'a ^1\nb ^2\nc ^3\nd ^4\n', 1, 'a b\na c\na d\nb c\nb d\nc d\nclashes 6\n', ''),
  row(['clash', '--limit', '1'], 'a ^1\nb ^2\nc ^3\nd ^4\n', 1, 'a b\nand 5 more pairs\nclashes 6\n', ''),
];

void main() => runRows(rows);
