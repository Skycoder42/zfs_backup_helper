// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'managed_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ManagedSnapshot {
  String get prefix => throw _privateConstructorUsedError;
  SnapshotLabel get label => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ManagedSnapshotCopyWith<ManagedSnapshot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ManagedSnapshotCopyWith<$Res> {
  factory $ManagedSnapshotCopyWith(
          ManagedSnapshot value, $Res Function(ManagedSnapshot) then) =
      _$ManagedSnapshotCopyWithImpl<$Res>;
  $Res call({String prefix, SnapshotLabel label, DateTime timestamp});
}

/// @nodoc
class _$ManagedSnapshotCopyWithImpl<$Res>
    implements $ManagedSnapshotCopyWith<$Res> {
  _$ManagedSnapshotCopyWithImpl(this._value, this._then);

  final ManagedSnapshot _value;
  // ignore: unused_field
  final $Res Function(ManagedSnapshot) _then;

  @override
  $Res call({
    Object? prefix = freezed,
    Object? label = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_value.copyWith(
      prefix: prefix == freezed
          ? _value.prefix
          : prefix // ignore: cast_nullable_to_non_nullable
              as String,
      label: label == freezed
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as SnapshotLabel,
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$$_ManagedSnapshotCopyWith<$Res>
    implements $ManagedSnapshotCopyWith<$Res> {
  factory _$$_ManagedSnapshotCopyWith(
          _$_ManagedSnapshot value, $Res Function(_$_ManagedSnapshot) then) =
      __$$_ManagedSnapshotCopyWithImpl<$Res>;
  @override
  $Res call({String prefix, SnapshotLabel label, DateTime timestamp});
}

/// @nodoc
class __$$_ManagedSnapshotCopyWithImpl<$Res>
    extends _$ManagedSnapshotCopyWithImpl<$Res>
    implements _$$_ManagedSnapshotCopyWith<$Res> {
  __$$_ManagedSnapshotCopyWithImpl(
      _$_ManagedSnapshot _value, $Res Function(_$_ManagedSnapshot) _then)
      : super(_value, (v) => _then(v as _$_ManagedSnapshot));

  @override
  _$_ManagedSnapshot get _value => super._value as _$_ManagedSnapshot;

  @override
  $Res call({
    Object? prefix = freezed,
    Object? label = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_$_ManagedSnapshot(
      prefix: prefix == freezed
          ? _value.prefix
          : prefix // ignore: cast_nullable_to_non_nullable
              as String,
      label: label == freezed
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as SnapshotLabel,
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$_ManagedSnapshot extends _ManagedSnapshot {
  _$_ManagedSnapshot(
      {required this.prefix, required this.label, required this.timestamp})
      : assert(timestamp.isUtc, 'timestamp must be a UTC timestamp'),
        super._();

  @override
  final String prefix;
  @override
  final SnapshotLabel label;
  @override
  final DateTime timestamp;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ManagedSnapshot &&
            const DeepCollectionEquality().equals(other.prefix, prefix) &&
            const DeepCollectionEquality().equals(other.label, label) &&
            const DeepCollectionEquality().equals(other.timestamp, timestamp));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(prefix),
      const DeepCollectionEquality().hash(label),
      const DeepCollectionEquality().hash(timestamp));

  @JsonKey(ignore: true)
  @override
  _$$_ManagedSnapshotCopyWith<_$_ManagedSnapshot> get copyWith =>
      __$$_ManagedSnapshotCopyWithImpl<_$_ManagedSnapshot>(this, _$identity);
}

abstract class _ManagedSnapshot extends ManagedSnapshot {
  factory _ManagedSnapshot(
      {required final String prefix,
      required final SnapshotLabel label,
      required final DateTime timestamp}) = _$_ManagedSnapshot;
  _ManagedSnapshot._() : super._();

  @override
  String get prefix;
  @override
  SnapshotLabel get label;
  @override
  DateTime get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$_ManagedSnapshotCopyWith<_$_ManagedSnapshot> get copyWith =>
      throw _privateConstructorUsedError;
}
