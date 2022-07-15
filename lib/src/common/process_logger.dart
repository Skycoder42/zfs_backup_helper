import 'package:riverpod/riverpod.dart';

late final processLoggerProvider = Provider<ProcessLogger>(
  (ref) => throw StateError('No logger provided'),
);

abstract class ProcessLogger {
  void logStderr(
    String commandLine,
    Stream<List<int>> stderr,
  );
}
