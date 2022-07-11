import 'dart:io';

import 'package:args/args.dart';

class ClientCli {
  late final ArgParser _argParser;

  ArgResults? _args;

  ClientCli() {
    _argParser = ArgParser()
      ..addOption(
        'host',
        abbr: 'H',
        help: 'The name of the host to create backups for.',
        valueHelp: 'host',
        mandatory: true,
      )
      ..addMultiOption(
        'dataset',
        abbr: 'd',
        help: 'The dataset that should be backed up.',
        valueHelp: 'dataset',
      )
      ..addFlag(
        'help',
        abbr: 'h',
        negatable: false,
        help: 'Shows this usage help.',
      );
  }

  bool get isParsed => _args != null;

  String get host {
    _assertParsed();
    return _args!['host'] as String;
  }

  List<String> get datasets {
    _assertParsed();
    return _args!['dataset'] as List<String>;
  }

  void parse(List<String> args) {
    try {
      _args = _argParser.parse(args);

      if (datasets.isEmpty) {
        throw ArgParserException('At least one dataset must be given.');
      }
    } on ArgParserException catch (e) {
      if (args.contains('--help') || args.contains('-h')) {
        stdout.writeln(_argParser.usage);
        exit(0);
      } else {
        stderr
          ..writeln(e.message)
          ..writeln()
          ..writeln(_argParser.usage);
        exit(127);
      }
    }
  }

  void _assertParsed() {
    if (!isParsed) {
      throw StateError(
        'You must call parse before you can access the cli properties!',
      );
    }
  }
}
