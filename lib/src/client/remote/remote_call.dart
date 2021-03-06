import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:riverpod/riverpod.dart';

import '../../common/env.dart';
import '../../common/managed_process.dart';
import '../models/config.dart';

final remoteCallProvider = Provider.family(
  (ref, Config config) => RemoteCall(
    ref.watch(managedProcessProvider),
    config,
  ),
);

class RemoteCall {
  final ManagedProcess _managedProcess;
  final Config _config;
  final _logger = Logger('$RemoteCall');

  RemoteCall(this._managedProcess, this._config);

  Stream<String> runRemoteLines(
    String command,
    Map<String, Object?> arguments, {
    Encoding encoding = utf8,
  }) =>
      runRemote(command, arguments)
          .transform(encoding.decoder)
          .transform(const LineSplitter());

  Stream<List<int>> runRemote(
    String command,
    Map<String, Object?> arguments,
  ) {
    final commandLine = _buildCommandLine(command, arguments);
    if (isLocalDebugMode) {
      _logger.finer(
        'Running zfs_backup_server in debug mode '
        'with command line: $commandLine',
      );
      return _managedProcess.runRaw(
        'dart',
        [
          ...Platform.executableArguments.where(
            (argument) =>
                argument.startsWith('-D') || argument.startsWith('--define='),
          ),
          'run',
          'bin/zfs_backup_server.dart',
          ...commandLine,
        ],
      );
    } else {
      _logger.finer(
        'Running zfs_backup_server via SSH on host "${_config.host}" '
        'with command line: $commandLine',
      );
      return _managedProcess.runRaw(
        'ssh',
        [
          _config.host,
          '--',
          'zfs_backup_server',
          ...commandLine,
        ],
      );
    }
  }

  List<String> _buildCommandLine(
    String command,
    Map<String, Object?> arguments,
  ) =>
      [
        if (_config.autoRoot) '--root',
        command,
        for (final entry in arguments.entries) ...[
          '--${entry.key}',
          if (entry.value != null) entry.value.toString(),
        ],
      ];
}
