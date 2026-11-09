/// Parses command-line options, validates input and dispatches rangemeet commands.
library;

import 'commands/check.dart';
import 'commands/clash.dart';
import 'commands/meet.dart';
import 'commands/pick.dart';
import 'commands/show.dart';
import 'input.dart';
import 'registry.dart';
import 'versions.dart';

class _ParsedCommand {
  const _ParsedCommand(this.command, this.options);

  final String command;
  final Options options;
}

bool readsStdin(List<String> args) {
  try {
    _parseCommand(args);
    return true;
  } on Failure {
    return false;
  }
}

Result run(List<String> args, String text) {
  if (args.isEmpty) {
    return const Result(2, '', usageText);
  }
  if (args[0] == 'help' || args[0] == '-h' || args[0] == '--help') {
    return const Result(0, usageText, '');
  }
  if (args[0] == '--version') {
    return const Result(0, 'rangemeet $programVersion\n', '');
  }

  try {
    final parsed = _parseCommand(args);
    final items = readItems(text);
    final command = parsed.command;
    final options = parsed.options;
    switch (command) {
      case 'check':
        return runCheck(options, items);
      case 'show':
        return runShow(options, items);
      case 'meet':
        return runMeet(options, items);
      case 'clash':
        return runClash(options, items);
      case 'pick':
        return runPick(options, items);
      default:
        throw StateError('Unreachable command: $command');
    }
  } on Failure catch (failure) {
    return Result(failure.status, '', 'rangemeet: ${failure.message}\n');
  }
}

_ParsedCommand _parseCommand(List<String> args) {
  if (args.isEmpty) {
    fail(2, usageText.trimRight());
  }

  final command = args[0];
  final acceptedOptions = commandOptions[command];
  if (acceptedOptions == null) {
    fail(2, 'unknown command $command');
  }

  int? limit;
  List<Version> have = const <Version>[];
  final seen = <String>{};
  var index = 1;
  while (index < args.length) {
    final word = args[index];
    if (word.isEmpty || word == '-' || !word.startsWith('-')) {
      fail(2, 'unexpected argument $word');
    }
    if (!optionNames.contains(word)) {
      fail(2, 'unknown option $word');
    }
    if (!acceptedOptions.contains(word)) {
      fail(2, 'option $word is not valid for $command');
    }
    if (seen.contains(word)) {
      fail(2, 'given twice: $word');
    }
    seen.add(word);
    if (index + 1 >= args.length) {
      fail(2, 'missing value for $word');
    }

    final value = args[index + 1];
    if (word == '--limit') {
      final parsedLimit = parseNumber(value);
      if (parsedLimit == null || parsedLimit == 0 || parsedLimit > maxClashLimit) {
        fail(2, 'bad value for $word');
      }
      limit = parsedLimit;
    } else {
      final candidates = value.split(',');
      if (candidates.length > maxHave) {
        fail(2, 'bad value for $word');
      }
      final parsedCandidates = <Version>[];
      for (final candidate in candidates) {
        final version = parseVersion(candidate);
        if (version == null) {
          fail(2, 'bad value for $word');
        }
        parsedCandidates.add(version);
      }
      have = parsedCandidates;
    }
    index += 2;
  }

  if (command == 'pick' && !seen.contains('--have')) {
    fail(2, 'missing --have');
  }
  return _ParsedCommand(command, Options(have: have, limit: limit));
}
