// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'cli_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CliResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(dynamic jsonData) json,
    required TResult Function(List<String> lines) lines,
    required TResult Function(Stream<String> stream) stream,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(dynamic jsonData)? json,
    TResult Function(List<String> lines)? lines,
    TResult Function(Stream<String> stream)? stream,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(dynamic jsonData)? json,
    TResult Function(List<String> lines)? lines,
    TResult Function(Stream<String> stream)? stream,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_JsonCliResult value) json,
    required TResult Function(_LinesCliResult value) lines,
    required TResult Function(_StreamCliResult value) stream,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_JsonCliResult value)? json,
    TResult Function(_LinesCliResult value)? lines,
    TResult Function(_StreamCliResult value)? stream,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_JsonCliResult value)? json,
    TResult Function(_LinesCliResult value)? lines,
    TResult Function(_StreamCliResult value)? stream,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CliResultCopyWith<$Res> {
  factory $CliResultCopyWith(CliResult value, $Res Function(CliResult) then) =
      _$CliResultCopyWithImpl<$Res>;
}

/// @nodoc
class _$CliResultCopyWithImpl<$Res> implements $CliResultCopyWith<$Res> {
  _$CliResultCopyWithImpl(this._value, this._then);

  final CliResult _value;
  // ignore: unused_field
  final $Res Function(CliResult) _then;
}

/// @nodoc
abstract class _$$_JsonCliResultCopyWith<$Res> {
  factory _$$_JsonCliResultCopyWith(
          _$_JsonCliResult value, $Res Function(_$_JsonCliResult) then) =
      __$$_JsonCliResultCopyWithImpl<$Res>;
  $Res call({dynamic jsonData});
}

/// @nodoc
class __$$_JsonCliResultCopyWithImpl<$Res> extends _$CliResultCopyWithImpl<$Res>
    implements _$$_JsonCliResultCopyWith<$Res> {
  __$$_JsonCliResultCopyWithImpl(
      _$_JsonCliResult _value, $Res Function(_$_JsonCliResult) _then)
      : super(_value, (v) => _then(v as _$_JsonCliResult));

  @override
  _$_JsonCliResult get _value => super._value as _$_JsonCliResult;

  @override
  $Res call({
    Object? jsonData = freezed,
  }) {
    return _then(_$_JsonCliResult(
      jsonData == freezed
          ? _value.jsonData
          : jsonData // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$_JsonCliResult extends _JsonCliResult {
  const _$_JsonCliResult(this.jsonData) : super._();

  @override
  final dynamic jsonData;

  @override
  String toString() {
    return 'CliResult.json(jsonData: $jsonData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_JsonCliResult &&
            const DeepCollectionEquality().equals(other.jsonData, jsonData));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(jsonData));

  @JsonKey(ignore: true)
  @override
  _$$_JsonCliResultCopyWith<_$_JsonCliResult> get copyWith =>
      __$$_JsonCliResultCopyWithImpl<_$_JsonCliResult>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(dynamic jsonData) json,
    required TResult Function(List<String> lines) lines,
    required TResult Function(Stream<String> stream) stream,
  }) {
    return json(jsonData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(dynamic jsonData)? json,
    TResult Function(List<String> lines)? lines,
    TResult Function(Stream<String> stream)? stream,
  }) {
    return json?.call(jsonData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(dynamic jsonData)? json,
    TResult Function(List<String> lines)? lines,
    TResult Function(Stream<String> stream)? stream,
    required TResult orElse(),
  }) {
    if (json != null) {
      return json(jsonData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_JsonCliResult value) json,
    required TResult Function(_LinesCliResult value) lines,
    required TResult Function(_StreamCliResult value) stream,
  }) {
    return json(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_JsonCliResult value)? json,
    TResult Function(_LinesCliResult value)? lines,
    TResult Function(_StreamCliResult value)? stream,
  }) {
    return json?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_JsonCliResult value)? json,
    TResult Function(_LinesCliResult value)? lines,
    TResult Function(_StreamCliResult value)? stream,
    required TResult orElse(),
  }) {
    if (json != null) {
      return json(this);
    }
    return orElse();
  }
}

abstract class _JsonCliResult extends CliResult {
  const factory _JsonCliResult(final dynamic jsonData) = _$_JsonCliResult;
  const _JsonCliResult._() : super._();

  dynamic get jsonData;
  @JsonKey(ignore: true)
  _$$_JsonCliResultCopyWith<_$_JsonCliResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_LinesCliResultCopyWith<$Res> {
  factory _$$_LinesCliResultCopyWith(
          _$_LinesCliResult value, $Res Function(_$_LinesCliResult) then) =
      __$$_LinesCliResultCopyWithImpl<$Res>;
  $Res call({List<String> lines});
}

/// @nodoc
class __$$_LinesCliResultCopyWithImpl<$Res>
    extends _$CliResultCopyWithImpl<$Res>
    implements _$$_LinesCliResultCopyWith<$Res> {
  __$$_LinesCliResultCopyWithImpl(
      _$_LinesCliResult _value, $Res Function(_$_LinesCliResult) _then)
      : super(_value, (v) => _then(v as _$_LinesCliResult));

  @override
  _$_LinesCliResult get _value => super._value as _$_LinesCliResult;

  @override
  $Res call({
    Object? lines = freezed,
  }) {
    return _then(_$_LinesCliResult(
      lines == freezed
          ? _value._lines
          : lines // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_LinesCliResult extends _LinesCliResult {
  const _$_LinesCliResult(final List<String> lines)
      : _lines = lines,
        super._();

  final List<String> _lines;
  @override
  List<String> get lines {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lines);
  }

  @override
  String toString() {
    return 'CliResult.lines(lines: $lines)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LinesCliResult &&
            const DeepCollectionEquality().equals(other._lines, _lines));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_lines));

  @JsonKey(ignore: true)
  @override
  _$$_LinesCliResultCopyWith<_$_LinesCliResult> get copyWith =>
      __$$_LinesCliResultCopyWithImpl<_$_LinesCliResult>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(dynamic jsonData) json,
    required TResult Function(List<String> lines) lines,
    required TResult Function(Stream<String> stream) stream,
  }) {
    return lines(this.lines);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(dynamic jsonData)? json,
    TResult Function(List<String> lines)? lines,
    TResult Function(Stream<String> stream)? stream,
  }) {
    return lines?.call(this.lines);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(dynamic jsonData)? json,
    TResult Function(List<String> lines)? lines,
    TResult Function(Stream<String> stream)? stream,
    required TResult orElse(),
  }) {
    if (lines != null) {
      return lines(this.lines);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_JsonCliResult value) json,
    required TResult Function(_LinesCliResult value) lines,
    required TResult Function(_StreamCliResult value) stream,
  }) {
    return lines(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_JsonCliResult value)? json,
    TResult Function(_LinesCliResult value)? lines,
    TResult Function(_StreamCliResult value)? stream,
  }) {
    return lines?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_JsonCliResult value)? json,
    TResult Function(_LinesCliResult value)? lines,
    TResult Function(_StreamCliResult value)? stream,
    required TResult orElse(),
  }) {
    if (lines != null) {
      return lines(this);
    }
    return orElse();
  }
}

abstract class _LinesCliResult extends CliResult {
  const factory _LinesCliResult(final List<String> lines) = _$_LinesCliResult;
  const _LinesCliResult._() : super._();

  List<String> get lines;
  @JsonKey(ignore: true)
  _$$_LinesCliResultCopyWith<_$_LinesCliResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_StreamCliResultCopyWith<$Res> {
  factory _$$_StreamCliResultCopyWith(
          _$_StreamCliResult value, $Res Function(_$_StreamCliResult) then) =
      __$$_StreamCliResultCopyWithImpl<$Res>;
  $Res call({Stream<String> stream});
}

/// @nodoc
class __$$_StreamCliResultCopyWithImpl<$Res>
    extends _$CliResultCopyWithImpl<$Res>
    implements _$$_StreamCliResultCopyWith<$Res> {
  __$$_StreamCliResultCopyWithImpl(
      _$_StreamCliResult _value, $Res Function(_$_StreamCliResult) _then)
      : super(_value, (v) => _then(v as _$_StreamCliResult));

  @override
  _$_StreamCliResult get _value => super._value as _$_StreamCliResult;

  @override
  $Res call({
    Object? stream = freezed,
  }) {
    return _then(_$_StreamCliResult(
      stream == freezed
          ? _value.stream
          : stream // ignore: cast_nullable_to_non_nullable
              as Stream<String>,
    ));
  }
}

/// @nodoc

class _$_StreamCliResult extends _StreamCliResult {
  const _$_StreamCliResult(this.stream) : super._();

  @override
  final Stream<String> stream;

  @override
  String toString() {
    return 'CliResult.stream(stream: $stream)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StreamCliResult &&
            const DeepCollectionEquality().equals(other.stream, stream));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(stream));

  @JsonKey(ignore: true)
  @override
  _$$_StreamCliResultCopyWith<_$_StreamCliResult> get copyWith =>
      __$$_StreamCliResultCopyWithImpl<_$_StreamCliResult>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(dynamic jsonData) json,
    required TResult Function(List<String> lines) lines,
    required TResult Function(Stream<String> stream) stream,
  }) {
    return stream(this.stream);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(dynamic jsonData)? json,
    TResult Function(List<String> lines)? lines,
    TResult Function(Stream<String> stream)? stream,
  }) {
    return stream?.call(this.stream);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(dynamic jsonData)? json,
    TResult Function(List<String> lines)? lines,
    TResult Function(Stream<String> stream)? stream,
    required TResult orElse(),
  }) {
    if (stream != null) {
      return stream(this.stream);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_JsonCliResult value) json,
    required TResult Function(_LinesCliResult value) lines,
    required TResult Function(_StreamCliResult value) stream,
  }) {
    return stream(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_JsonCliResult value)? json,
    TResult Function(_LinesCliResult value)? lines,
    TResult Function(_StreamCliResult value)? stream,
  }) {
    return stream?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_JsonCliResult value)? json,
    TResult Function(_LinesCliResult value)? lines,
    TResult Function(_StreamCliResult value)? stream,
    required TResult orElse(),
  }) {
    if (stream != null) {
      return stream(this);
    }
    return orElse();
  }
}

abstract class _StreamCliResult extends CliResult {
  const factory _StreamCliResult(final Stream<String> stream) =
      _$_StreamCliResult;
  const _StreamCliResult._() : super._();

  Stream<String> get stream;
  @JsonKey(ignore: true)
  _$$_StreamCliResultCopyWith<_$_StreamCliResult> get copyWith =>
      throw _privateConstructorUsedError;
}
