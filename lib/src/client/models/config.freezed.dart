// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Config {
  String get host => throw _privateConstructorUsedError;
  bool get autoRoot => throw _privateConstructorUsedError;
  Directory get backupDir => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ConfigCopyWith<Config> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigCopyWith<$Res> {
  factory $ConfigCopyWith(Config value, $Res Function(Config) then) =
      _$ConfigCopyWithImpl<$Res>;
  $Res call({String host, bool autoRoot, Directory backupDir});
}

/// @nodoc
class _$ConfigCopyWithImpl<$Res> implements $ConfigCopyWith<$Res> {
  _$ConfigCopyWithImpl(this._value, this._then);

  final Config _value;
  // ignore: unused_field
  final $Res Function(Config) _then;

  @override
  $Res call({
    Object? host = freezed,
    Object? autoRoot = freezed,
    Object? backupDir = freezed,
  }) {
    return _then(_value.copyWith(
      host: host == freezed
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String,
      autoRoot: autoRoot == freezed
          ? _value.autoRoot
          : autoRoot // ignore: cast_nullable_to_non_nullable
              as bool,
      backupDir: backupDir == freezed
          ? _value.backupDir
          : backupDir // ignore: cast_nullable_to_non_nullable
              as Directory,
    ));
  }
}

/// @nodoc
abstract class _$$_ConfigCopyWith<$Res> implements $ConfigCopyWith<$Res> {
  factory _$$_ConfigCopyWith(_$_Config value, $Res Function(_$_Config) then) =
      __$$_ConfigCopyWithImpl<$Res>;
  @override
  $Res call({String host, bool autoRoot, Directory backupDir});
}

/// @nodoc
class __$$_ConfigCopyWithImpl<$Res> extends _$ConfigCopyWithImpl<$Res>
    implements _$$_ConfigCopyWith<$Res> {
  __$$_ConfigCopyWithImpl(_$_Config _value, $Res Function(_$_Config) _then)
      : super(_value, (v) => _then(v as _$_Config));

  @override
  _$_Config get _value => super._value as _$_Config;

  @override
  $Res call({
    Object? host = freezed,
    Object? autoRoot = freezed,
    Object? backupDir = freezed,
  }) {
    return _then(_$_Config(
      host: host == freezed
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String,
      autoRoot: autoRoot == freezed
          ? _value.autoRoot
          : autoRoot // ignore: cast_nullable_to_non_nullable
              as bool,
      backupDir: backupDir == freezed
          ? _value.backupDir
          : backupDir // ignore: cast_nullable_to_non_nullable
              as Directory,
    ));
  }
}

/// @nodoc

class _$_Config implements _Config {
  const _$_Config(
      {required this.host, required this.autoRoot, required this.backupDir});

  @override
  final String host;
  @override
  final bool autoRoot;
  @override
  final Directory backupDir;

  @override
  String toString() {
    return 'Config(host: $host, autoRoot: $autoRoot, backupDir: $backupDir)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Config &&
            const DeepCollectionEquality().equals(other.host, host) &&
            const DeepCollectionEquality().equals(other.autoRoot, autoRoot) &&
            const DeepCollectionEquality().equals(other.backupDir, backupDir));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(host),
      const DeepCollectionEquality().hash(autoRoot),
      const DeepCollectionEquality().hash(backupDir));

  @JsonKey(ignore: true)
  @override
  _$$_ConfigCopyWith<_$_Config> get copyWith =>
      __$$_ConfigCopyWithImpl<_$_Config>(this, _$identity);
}

abstract class _Config implements Config {
  const factory _Config(
      {required final String host,
      required final bool autoRoot,
      required final Directory backupDir}) = _$_Config;

  @override
  String get host;
  @override
  bool get autoRoot;
  @override
  Directory get backupDir;
  @override
  @JsonKey(ignore: true)
  _$$_ConfigCopyWith<_$_Config> get copyWith =>
      throw _privateConstructorUsedError;
}
