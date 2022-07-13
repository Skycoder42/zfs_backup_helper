// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'list_snapshots_command.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ListSnapshotRequest {
  String get rootDataset => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ListSnapshotRequestCopyWith<ListSnapshotRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListSnapshotRequestCopyWith<$Res> {
  factory $ListSnapshotRequestCopyWith(
          ListSnapshotRequest value, $Res Function(ListSnapshotRequest) then) =
      _$ListSnapshotRequestCopyWithImpl<$Res>;
  $Res call({String rootDataset});
}

/// @nodoc
class _$ListSnapshotRequestCopyWithImpl<$Res>
    implements $ListSnapshotRequestCopyWith<$Res> {
  _$ListSnapshotRequestCopyWithImpl(this._value, this._then);

  final ListSnapshotRequest _value;
  // ignore: unused_field
  final $Res Function(ListSnapshotRequest) _then;

  @override
  $Res call({
    Object? rootDataset = freezed,
  }) {
    return _then(_value.copyWith(
      rootDataset: rootDataset == freezed
          ? _value.rootDataset
          : rootDataset // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_ListSnapshotRequestCopyWith<$Res>
    implements $ListSnapshotRequestCopyWith<$Res> {
  factory _$$_ListSnapshotRequestCopyWith(_$_ListSnapshotRequest value,
          $Res Function(_$_ListSnapshotRequest) then) =
      __$$_ListSnapshotRequestCopyWithImpl<$Res>;
  @override
  $Res call({String rootDataset});
}

/// @nodoc
class __$$_ListSnapshotRequestCopyWithImpl<$Res>
    extends _$ListSnapshotRequestCopyWithImpl<$Res>
    implements _$$_ListSnapshotRequestCopyWith<$Res> {
  __$$_ListSnapshotRequestCopyWithImpl(_$_ListSnapshotRequest _value,
      $Res Function(_$_ListSnapshotRequest) _then)
      : super(_value, (v) => _then(v as _$_ListSnapshotRequest));

  @override
  _$_ListSnapshotRequest get _value => super._value as _$_ListSnapshotRequest;

  @override
  $Res call({
    Object? rootDataset = freezed,
  }) {
    return _then(_$_ListSnapshotRequest(
      rootDataset: rootDataset == freezed
          ? _value.rootDataset
          : rootDataset // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ListSnapshotRequest implements _ListSnapshotRequest {
  const _$_ListSnapshotRequest({required this.rootDataset});

  @override
  final String rootDataset;

  @override
  String toString() {
    return 'ListSnapshotRequest(rootDataset: $rootDataset)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ListSnapshotRequest &&
            const DeepCollectionEquality()
                .equals(other.rootDataset, rootDataset));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(rootDataset));

  @JsonKey(ignore: true)
  @override
  _$$_ListSnapshotRequestCopyWith<_$_ListSnapshotRequest> get copyWith =>
      __$$_ListSnapshotRequestCopyWithImpl<_$_ListSnapshotRequest>(
          this, _$identity);
}

abstract class _ListSnapshotRequest implements ListSnapshotRequest {
  const factory _ListSnapshotRequest({required final String rootDataset}) =
      _$_ListSnapshotRequest;

  @override
  String get rootDataset;
  @override
  @JsonKey(ignore: true)
  _$$_ListSnapshotRequestCopyWith<_$_ListSnapshotRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
