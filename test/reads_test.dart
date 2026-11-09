import 'rows.dart';

final rows = [
  row([], '', 0, '', ''),
  row(['--version'], '', 0, '', ''),
  row(['frob'], '', 0, '', ''),
  row(['check'], '', 1, '', ''),
  row(['show'], '', 1, '', ''),
  row(['meet'], '', 1, '', ''),
  row(['clash'], '', 1, '', ''),
  row(['pick', '--have', '1.0.0'], '', 1, '', ''),
  row(['clash', '--limit', '5'], '', 1, '', ''),
  row(['clash', '--limit', '0'], '', 0, '', ''),
  row(['show', '--limit', '5'], '', 0, '', ''),
  row(['check', 'extra'], '', 0, '', ''),
];

void main() => runReads(rows);
