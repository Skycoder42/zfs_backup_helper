// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Snapshot _$SnapshotFromJson(Map<String, dynamic> json) {
  return _Snapshot.fromJson(json);
}

/// @nodoc
mixin _$Snapshot {
  String get dataset => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SnapshotCopyWith<Snapshot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnapshotCopyWith<$Res> {
  factory $SnapshotCopyWith(Snapshot value, $Res Function(Snapshot) then) =
      _$SnapshotCopyWithImpl<$Res>;
  $Res call({String dataset, String name});
}

/// @nodoc
class _$SnapshotCopyWithImpl<$Res> implements $SnapshotCopyWith<$Res> {
  _$SnapshotCopyWithImpl(this._value, this._then);

  final Snapshot _value;
  // ignore: unused_field
  final $Res Function(Snapshot) _then;

  @override
  $Res call({
    Object? dataset = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      dataset: dataset == freezed
          ? _value.dataset
          : dataset // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_SnapshotCopyWith<$Res> implements $SnapshotCopyWith<$Res> {
  factory _$$_SnapshotCopyWith(
          _$_Snapshot value, $Res Function(_$_Snapshot) then) =
      __$$_SnapshotCopyWithImpl<$Res>;
  @override
  $Res call({String dataset, String name});
}

/// @nodoc
class __$$_SnapshotCopyWithImpl<$Res> extends _$SnapshotCopyWithImpl<$Res>
    implements _$$_SnapshotCopyWith<$Res> {
  __$$_SnapshotCopyWithImpl(
      _$_Snapshot _value, $Res Function(_$_Snapshot) _then)
      : super(_value, (v) => _then(v as _$_Snapshot));

  @override
  _$_Snapshot get _value => super._value as _$_Snapshot;

  @override
  $Res call({
    Object? dataset = freezed,
    Object? name = freezed,
  }) {
    return _then(_$_Snapshot(
      dataset: dataset == freezed
          ? _value.dataset
          : dataset // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Snapshot implements _Snapshot {
  const _$_Snapshot({required this.dataset, required this.name});

  factory _$_Snapshot.fromJson(Map<String, dynamic> json) =>
      _$$_SnapshotFromJson(json);

  @override
  final String dataset;
  @override
  final String name;

  @override
  String toString() {
    return 'Snapshot(dataset: $dataset, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Snapshot &&
            const DeepCollectionEquality().equals(other.dataset, dataset) &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(dataset),
      const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
  _$$_SnapshotCopyWith<_$_Snapshot> get copyWith =>
      __$$_SnapshotCopyWithImpl<_$_Snapshot>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SnapshotToJson(this);
  }
}

abstract class _Snapshot implements Snapshot {
  const factory _Snapshot(
      {required final String dataset,
      required final String name}) = _$_Snapshot;

  factory _Snapshot.fromJson(Map<String, dynamic> json) = _$_Snapshot.fromJson;

  @override
  String get dataset;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_SnapshotCopyWith<_$_Snapshot> get copyWith =>
      throw _privateConstructorUsedError;
}
