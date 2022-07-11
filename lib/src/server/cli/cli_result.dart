import 'package:freezed_annotation/freezed_annotation.dart';

part 'cli_result.freezed.dart';

@freezed
class CliResult with _$CliResult {
  const factory CliResult.json(dynamic jsonData) = _JsonCliResult;
  const factory CliResult.lines(List<String> lines) = _LinesCliResult;
  const factory CliResult.stream(Stream<String> stream) = _StreamCliResult;
}
