import 'package:riverpod/riverpod.dart';

late final loggerProvider = Provider<Logger>(
  (ref) => throw StateError('No logger provided'),
);

abstract class Logger {
  void logException(Object exception, StackTrace stackStrace);

  void logStderr(
    String commandLine,
    Stream<List<int>> stderr,
  );
}
