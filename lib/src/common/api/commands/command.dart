import 'dart:async';

abstract class Command<TResponse, TRequest> {
  Command._();

  FutureOr<TResponse> call(TRequest request);
}
