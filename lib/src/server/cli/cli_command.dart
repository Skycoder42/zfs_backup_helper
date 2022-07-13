import 'dart:async';

import 'package:args/args.dart';
import 'package:args/command_runner.dart' as cr;
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../common/api/commands/command.dart' as api;
import 'cli_result.dart';

abstract class CliCommand<TResponse, TRequest> extends cr.Command<CliResult>
    implements api.Command<TResponse, TRequest> {
  @override
  @nonVirtual
  FutureOr<CliResult> run() async {
    final request = parseOptions(argResults!);
    final response = await call(request);
    return encodeResult(response);
  }

  @protected
  TRequest parseOptions(ArgResults argResults);

  CliResult encodeResult(TResponse response) => CliResult.json(response);
}
