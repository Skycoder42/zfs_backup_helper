import 'package:args/args.dart';

void main(List<String> rawArgs) {
  final parser = ArgParser(allowTrailingOptions: false);

  final args = parser.parse(rawArgs);

  throw UnimplementedError(args.toString());
}
