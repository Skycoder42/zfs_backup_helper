import 'package:riverpod/riverpod.dart';

late final loggerProvider = Provider<Logger>(
  (ref) => throw StateError('No logger provided'),
);

abstract class Logger {
  void logStderr(
    String executable,
    List<String> arguments,
    Stream<List<int>> stderr,
  );
}
