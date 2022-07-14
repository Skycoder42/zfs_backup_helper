// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'dataset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Dataset {
  String get name => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DatasetCopyWith<Dataset> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DatasetCopyWith<$Res> {
  factory $DatasetCopyWith(Dataset value, $Res Function(Dataset) then) =
      _$DatasetCopyWithImpl<$Res>;
  $Res call({String name});
}

/// @nodoc
class _$DatasetCopyWithImpl<$Res> implements $DatasetCopyWith<$Res> {
  _$DatasetCopyWithImpl(this._value, this._then);

  final Dataset _value;
  // ignore: unused_field
  final $Res Function(Dataset) _then;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_DatasetCopyWith<$Res> implements $DatasetCopyWith<$Res> {
  factory _$$_DatasetCopyWith(
          _$_Dataset value, $Res Function(_$_Dataset) then) =
      __$$_DatasetCopyWithImpl<$Res>;
  @override
  $Res call({String name});
}

/// @nodoc
class __$$_DatasetCopyWithImpl<$Res> extends _$DatasetCopyWithImpl<$Res>
    implements _$$_DatasetCopyWith<$Res> {
  __$$_DatasetCopyWithImpl(_$_Dataset _value, $Res Function(_$_Dataset) _then)
      : super(_value, (v) => _then(v as _$_Dataset));

  @override
  _$_Dataset get _value => super._value as _$_Dataset;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_$_Dataset(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Dataset extends _Dataset {
  const _$_Dataset(this.name) : super._();

  @override
  final String name;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Dataset &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
  _$$_DatasetCopyWith<_$_Dataset> get copyWith =>
      __$$_DatasetCopyWithImpl<_$_Dataset>(this, _$identity);
}

abstract class _Dataset extends Dataset {
  const factory _Dataset(final String name) = _$_Dataset;
  const _Dataset._() : super._();

  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_DatasetCopyWith<_$_Dataset> get copyWith =>
      throw _privateConstructorUsedError;
}
