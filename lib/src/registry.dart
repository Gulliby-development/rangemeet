/// Shared constants and types of rangemeet: the version, the limits, the usage text, the options of the commands, the reply, the failure and the types of versions, intervals and items.
library;

const String programVersion = '0.1.0';
const int maxLines = 40;
const int maxNameLength = 12;
const int maxNumber = 9999;
const int maxComparators = 4;
const int maxHave = 20;
const int maxClashLimit = 1000;

const String usageText =
    'usage: rangemeet check\n'
    '       rangemeet show\n'
    '       rangemeet meet\n'
    '       rangemeet clash [--limit N]\n'
    '       rangemeet pick --have LIST\n';

/// The commands in the order of the usage text and the options that each one accepts.
const Map<String, List<String>> commandOptions = {
  'check': <String>[],
  'show': <String>[],
  'meet': <String>[],
  'clash': <String>['--limit'],
  'pick': <String>['--have'],
};

/// All option names. An option that is not in this list is unknown.
const List<String> optionNames = ['--limit', '--have'];

/// The reply of a command line: the exit status, the standard output text and the standard error text.
class Result {
  const Result(this.status, this.out, this.err);

  final int status;
  final String out;
  final String err;
}

/// A failure that ends the command: status 1 for the input, 2 for the command line.
class Failure implements Exception {
  const Failure(this.status, this.message);

  final int status;
  final String message;
}

Never fail(int status, String message) => throw Failure(status, message);

/// A version: three whole numbers from 0 to 9999 (in the output of pick, any version of the list).
class Version {
  const Version(this.major, this.minor, this.patch);

  final int major;
  final int minor;
  final int patch;
}

/// The versions from [low] (included) up to [high] (excluded); a null [high] means that there is no upper end.
class Interval {
  const Interval(this.low, this.high);

  final Version low;
  final Version? high;
}

/// One constraint of the input: the number of its line, its name and the interval of versions that it admits.
class Item {
  const Item(this.line, this.name, this.interval);

  final int line;
  final String name;
  final Interval interval;
}

/// The values of the options: the candidate versions of --have (empty when not given) and the value of --limit (null when not given).
class Options {
  const Options({this.have = const <Version>[], this.limit});

  final List<Version> have;
  final int? limit;
}
