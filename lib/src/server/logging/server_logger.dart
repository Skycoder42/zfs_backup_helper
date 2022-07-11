import '../../common/logging/logger.dart';

class ServerLogger implements Logger {
  @override
  void logStderr(
    String executable,
    List<String> arguments,
    Stream<List<int>> stderr,
  ) {
    // TODO: implement logStderr
  }
}
