import 'package:freezed_annotation/freezed_annotation.dart';

part 'dataset.freezed.dart';

@freezed
class Dataset with _$Dataset {
  const Dataset._();

  // ignore: sort_unnamed_constructors_first
  const factory Dataset(String name) = _Dataset;

  @override
  String toString() => name;
}
