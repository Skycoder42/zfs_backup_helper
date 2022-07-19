import 'package:riverpod/riverpod.dart';

final processLoggerProvider = Provider<ProcessLogger>(
  (ref) => throw StateError('No logger provided'),
);

abstract class ProcessLogger {
  void logStderr(
    String commandLine,
    Stream<List<int>> stderr,
  );
}
