import 'dart:io';

import 'package:args/args.dart';
import 'package:riverpod/riverpod.dart';

late final clientCliProvider = Provider.family(
  (ref, List<String> args) => ClientCli()..parse(args),
);

class ClientCli {
  late final ArgParser _argParser;

  ArgResults? _args;

  ClientCli() {
    _argParser = ArgParser()
      ..addSeparator('Required options:')
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
      ..addSeparator('Optional options:')
      ..addFlag(
        'root',
        help: 'Pass the "--root" option to the zfs_backup_server tool. '
            'This will enable the server to try to automatically promote to '
            'run as root for required commands.',
      )
      ..addOption(
        'backup-directory',
        abbr: 'b',
        defaultsTo: '/var/local/zfs_backup_client/backups',
        help: 'The directory where backups should be stored. '
            'A directory for each host is created within that directory.',
        valueHelp: 'directory',
      )
      ..addSeparator('Other:')
      ..addFlag(
        'help',
        abbr: 'h',
        negatable: false,
        help: 'Shows this usage help.',
      );
  }

  bool get isParsed => _args != null;

  String get host => _assertArgs['host'] as String;

  List<String> get datasets => _assertArgs['dataset'] as List<String>;

  bool get root => _assertArgs['root'] as bool;

  Directory get backupDirectory =>
      Directory(_assertArgs['backup-directory'] as String);

  void parse(List<String> rawArgs) {
    try {
      final args = _args = _argParser.parse(rawArgs);

      if (args['help'] as bool) {
        _printHelp();
      }

      if (datasets.isEmpty) {
        throw ArgParserException('At least one dataset must be given.');
      }
    } on ArgParserException catch (e) {
      if (rawArgs.contains('--help') || rawArgs.contains('-h')) {
        _printHelp();
      } else {
        stderr
          ..writeln(e.message)
          ..writeln()
          ..writeln(_argParser.usage);
        exit(127);
      }
    }
  }

  void _printHelp() {
    stdout.writeln(_argParser.usage);
    exit(0);
  }

  ArgResults get _assertArgs {
    final args = _args;
    if (args == null) {
      throw StateError(
        'You must call parse before you can access the cli properties!',
      );
    }
    return args;
  }
}
