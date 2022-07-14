// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'backup_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BackupTask {
  Dataset get dataset => throw _privateConstructorUsedError;
  List<ManagedSnapshot> get snapshots => throw _privateConstructorUsedError;
  bool get isRoot => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BackupTaskCopyWith<BackupTask> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BackupTaskCopyWith<$Res> {
  factory $BackupTaskCopyWith(
          BackupTask value, $Res Function(BackupTask) then) =
      _$BackupTaskCopyWithImpl<$Res>;
  $Res call({Dataset dataset, List<ManagedSnapshot> snapshots, bool isRoot});

  $DatasetCopyWith<$Res> get dataset;
}

/// @nodoc
class _$BackupTaskCopyWithImpl<$Res> implements $BackupTaskCopyWith<$Res> {
  _$BackupTaskCopyWithImpl(this._value, this._then);

  final BackupTask _value;
  // ignore: unused_field
  final $Res Function(BackupTask) _then;

  @override
  $Res call({
    Object? dataset = freezed,
    Object? snapshots = freezed,
    Object? isRoot = freezed,
  }) {
    return _then(_value.copyWith(
      dataset: dataset == freezed
          ? _value.dataset
          : dataset // ignore: cast_nullable_to_non_nullable
              as Dataset,
      snapshots: snapshots == freezed
          ? _value.snapshots
          : snapshots // ignore: cast_nullable_to_non_nullable
              as List<ManagedSnapshot>,
      isRoot: isRoot == freezed
          ? _value.isRoot
          : isRoot // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $DatasetCopyWith<$Res> get dataset {
    return $DatasetCopyWith<$Res>(_value.dataset, (value) {
      return _then(_value.copyWith(dataset: value));
    });
  }
}

/// @nodoc
abstract class _$$_BackupTaskCopyWith<$Res>
    implements $BackupTaskCopyWith<$Res> {
  factory _$$_BackupTaskCopyWith(
          _$_BackupTask value, $Res Function(_$_BackupTask) then) =
      __$$_BackupTaskCopyWithImpl<$Res>;
  @override
  $Res call({Dataset dataset, List<ManagedSnapshot> snapshots, bool isRoot});

  @override
  $DatasetCopyWith<$Res> get dataset;
}

/// @nodoc
class __$$_BackupTaskCopyWithImpl<$Res> extends _$BackupTaskCopyWithImpl<$Res>
    implements _$$_BackupTaskCopyWith<$Res> {
  __$$_BackupTaskCopyWithImpl(
      _$_BackupTask _value, $Res Function(_$_BackupTask) _then)
      : super(_value, (v) => _then(v as _$_BackupTask));

  @override
  _$_BackupTask get _value => super._value as _$_BackupTask;

  @override
  $Res call({
    Object? dataset = freezed,
    Object? snapshots = freezed,
    Object? isRoot = freezed,
  }) {
    return _then(_$_BackupTask(
      dataset: dataset == freezed
          ? _value.dataset
          : dataset // ignore: cast_nullable_to_non_nullable
              as Dataset,
      snapshots: snapshots == freezed
          ? _value._snapshots
          : snapshots // ignore: cast_nullable_to_non_nullable
              as List<ManagedSnapshot>,
      isRoot: isRoot == freezed
          ? _value.isRoot
          : isRoot // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_BackupTask implements _BackupTask {
  const _$_BackupTask(
      {required this.dataset,
      required final List<ManagedSnapshot> snapshots,
      required this.isRoot})
      : _snapshots = snapshots;

  @override
  final Dataset dataset;
  final List<ManagedSnapshot> _snapshots;
  @override
  List<ManagedSnapshot> get snapshots {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_snapshots);
  }

  @override
  final bool isRoot;

  @override
  String toString() {
    return 'BackupTask(dataset: $dataset, snapshots: $snapshots, isRoot: $isRoot)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BackupTask &&
            const DeepCollectionEquality().equals(other.dataset, dataset) &&
            const DeepCollectionEquality()
                .equals(other._snapshots, _snapshots) &&
            const DeepCollectionEquality().equals(other.isRoot, isRoot));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(dataset),
      const DeepCollectionEquality().hash(_snapshots),
      const DeepCollectionEquality().hash(isRoot));

  @JsonKey(ignore: true)
  @override
  _$$_BackupTaskCopyWith<_$_BackupTask> get copyWith =>
      __$$_BackupTaskCopyWithImpl<_$_BackupTask>(this, _$identity);
}

abstract class _BackupTask implements BackupTask {
  const factory _BackupTask(
      {required final Dataset dataset,
      required final List<ManagedSnapshot> snapshots,
      required final bool isRoot}) = _$_BackupTask;

  @override
  Dataset get dataset;
  @override
  List<ManagedSnapshot> get snapshots;
  @override
  bool get isRoot;
  @override
  @JsonKey(ignore: true)
  _$$_BackupTaskCopyWith<_$_BackupTask> get copyWith =>
      throw _privateConstructorUsedError;
}
