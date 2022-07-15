import 'dart:async';
import 'dart:convert';
import 'package:logging/logging.dart';
import 'package:riverpod/riverpod.dart';
import '../../common/process_logger.dart';

late final clientProcessLoggerProvider = Provider<ProcessLogger>(
  (ref) => ClientProcessLogger(),
);

class ClientProcessLogger implements ProcessLogger {
  @override
  void logStderr(
    String commandLine,
    Stream<List<int>> stderr,
  ) {
    final processLogger = Logger(commandLine);
    stderr.transform(utf8.decoder).transform(const LineSplitter()).listen(
          (line) => processLogger.severe(line),
          cancelOnError: false,
        );
  }
}
