abstract class Logger {
  void logStderr(
    String executable,
    List<String> arguments,
    Stream<List<int>> stderr,
  );
}
