import 'package:freezed_annotation/freezed_annotation.dart';

import '../../common/env.dart';
import '../../common/managed_process.dart';

abstract class RemoteCommand {
  final ManagedProcess _managedProcess;
  final String hostName;

  RemoteCommand(this._managedProcess, this.hostName);

  @protected
  Future<TData> runRemoteJson<TData extends Object, TJson>(
    List<String> arguments, {
    required TData Function(TJson) decoder,
  }) {
    if (isLocalDebugMode) {
      return _managedProcess.runJson(
        decoder: decoder,
        'dart',
        [
          'run',
          'bin/zfs_backup_server.dart',
          ...arguments,
        ],
      );
    } else {
      return _managedProcess.runJson(
        decoder: decoder,
        'ssh',
        [
          'zfs_backup_server',
          '--',
          hostName,
          ...arguments,
        ],
      );
    }
  }
}
