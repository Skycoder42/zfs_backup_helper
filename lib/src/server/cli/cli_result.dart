import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'cli_result.freezed.dart';

@freezed
class CliResult with _$CliResult {
  const CliResult._();

  const factory CliResult.json(dynamic jsonData) = _JsonCliResult;
  const factory CliResult.lines(List<String> lines) = _LinesCliResult;
  const factory CliResult.stream(Stream<String> stream) = _StreamCliResult;

  Future<void> printTo(IOSink ioSink) => when(
        json: (dynamic jsonData) {
          ioSink.write(json.encode(jsonData));
          return ioSink.flush();
        },
        lines: (lines) {
          ioSink.writeAll(lines, '\n');
          return ioSink.flush();
        },
        stream: (stream) =>
            ioSink.addStream(stream.transform(ioSink.encoding.encoder)),
      );
}
