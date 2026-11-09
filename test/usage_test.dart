import 'rows.dart';

final rows = [
  row([], '', 2, '', 'usage: rangemeet check\n       rangemeet show\n       rangemeet meet\n       rangemeet clash [--limit N]\n       rangemeet pick --have LIST\n'),
  row(['help'], '', 0, 'usage: rangemeet check\n       rangemeet show\n       rangemeet meet\n       rangemeet clash [--limit N]\n       rangemeet pick --have LIST\n', ''),
  row(['-h'], '', 0, 'usage: rangemeet check\n       rangemeet show\n       rangemeet meet\n       rangemeet clash [--limit N]\n       rangemeet pick --have LIST\n', ''),
  row(['--help', 'frob'], 'ignored\n', 0, 'usage: rangemeet check\n       rangemeet show\n       rangemeet meet\n       rangemeet clash [--limit N]\n       rangemeet pick --have LIST\n', ''),
  row(['--version'], '', 0, 'rangemeet 0.1.0\n', ''),
  row(['frob'], '', 2, '', 'rangemeet: unknown command frob\n'),
  row([''], '', 2, '', 'rangemeet: unknown command \n'),
  row(['Check'], '', 2, '', 'rangemeet: unknown command Check\n'),
];

void main() => runRows(rows);
