// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'operation_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OperationLog {
  int get id => throw _privateConstructorUsedError;
  int get meterId => throw _privateConstructorUsedError;
  int get concentratorId => throw _privateConstructorUsedError;
  String get operation =>
      throw _privateConstructorUsedError; // e.g. "READ_ENERGY", "SET_CLOCK", "CONNECT"
  OperationStatus get status => throw _privateConstructorUsedError;
  String? get requestHex => throw _privateConstructorUsedError;
  String? get responseHex => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  int get durationMs => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OperationLogCopyWith<OperationLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OperationLogCopyWith<$Res> {
  factory $OperationLogCopyWith(
          OperationLog value, $Res Function(OperationLog) then) =
      _$OperationLogCopyWithImpl<$Res, OperationLog>;
  @useResult
  $Res call(
      {int id,
      int meterId,
      int concentratorId,
      String operation,
      OperationStatus status,
      String? requestHex,
      String? responseHex,
      String? errorMessage,
      int durationMs,
      DateTime timestamp});
}

/// @nodoc
class _$OperationLogCopyWithImpl<$Res, $Val extends OperationLog>
    implements $OperationLogCopyWith<$Res> {
  _$OperationLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? meterId = null,
    Object? concentratorId = null,
    Object? operation = null,
    Object? status = null,
    Object? requestHex = freezed,
    Object? responseHex = freezed,
    Object? errorMessage = freezed,
    Object? durationMs = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      meterId: null == meterId
          ? _value.meterId
          : meterId // ignore: cast_nullable_to_non_nullable
              as int,
      concentratorId: null == concentratorId
          ? _value.concentratorId
          : concentratorId // ignore: cast_nullable_to_non_nullable
              as int,
      operation: null == operation
          ? _value.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OperationStatus,
      requestHex: freezed == requestHex
          ? _value.requestHex
          : requestHex // ignore: cast_nullable_to_non_nullable
              as String?,
      responseHex: freezed == responseHex
          ? _value.responseHex
          : responseHex // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      durationMs: null == durationMs
          ? _value.durationMs
          : durationMs // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OperationLogImplCopyWith<$Res>
    implements $OperationLogCopyWith<$Res> {
  factory _$$OperationLogImplCopyWith(
          _$OperationLogImpl value, $Res Function(_$OperationLogImpl) then) =
      __$$OperationLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int meterId,
      int concentratorId,
      String operation,
      OperationStatus status,
      String? requestHex,
      String? responseHex,
      String? errorMessage,
      int durationMs,
      DateTime timestamp});
}

/// @nodoc
class __$$OperationLogImplCopyWithImpl<$Res>
    extends _$OperationLogCopyWithImpl<$Res, _$OperationLogImpl>
    implements _$$OperationLogImplCopyWith<$Res> {
  __$$OperationLogImplCopyWithImpl(
      _$OperationLogImpl _value, $Res Function(_$OperationLogImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? meterId = null,
    Object? concentratorId = null,
    Object? operation = null,
    Object? status = null,
    Object? requestHex = freezed,
    Object? responseHex = freezed,
    Object? errorMessage = freezed,
    Object? durationMs = null,
    Object? timestamp = null,
  }) {
    return _then(_$OperationLogImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      meterId: null == meterId
          ? _value.meterId
          : meterId // ignore: cast_nullable_to_non_nullable
              as int,
      concentratorId: null == concentratorId
          ? _value.concentratorId
          : concentratorId // ignore: cast_nullable_to_non_nullable
              as int,
      operation: null == operation
          ? _value.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OperationStatus,
      requestHex: freezed == requestHex
          ? _value.requestHex
          : requestHex // ignore: cast_nullable_to_non_nullable
              as String?,
      responseHex: freezed == responseHex
          ? _value.responseHex
          : responseHex // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      durationMs: null == durationMs
          ? _value.durationMs
          : durationMs // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$OperationLogImpl implements _OperationLog {
  const _$OperationLogImpl(
      {required this.id,
      required this.meterId,
      required this.concentratorId,
      required this.operation,
      required this.status,
      this.requestHex,
      this.responseHex,
      this.errorMessage,
      required this.durationMs,
      required this.timestamp});

  @override
  final int id;
  @override
  final int meterId;
  @override
  final int concentratorId;
  @override
  final String operation;
// e.g. "READ_ENERGY", "SET_CLOCK", "CONNECT"
  @override
  final OperationStatus status;
  @override
  final String? requestHex;
  @override
  final String? responseHex;
  @override
  final String? errorMessage;
  @override
  final int durationMs;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'OperationLog(id: $id, meterId: $meterId, concentratorId: $concentratorId, operation: $operation, status: $status, requestHex: $requestHex, responseHex: $responseHex, errorMessage: $errorMessage, durationMs: $durationMs, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OperationLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.meterId, meterId) || other.meterId == meterId) &&
            (identical(other.concentratorId, concentratorId) ||
                other.concentratorId == concentratorId) &&
            (identical(other.operation, operation) ||
                other.operation == operation) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.requestHex, requestHex) ||
                other.requestHex == requestHex) &&
            (identical(other.responseHex, responseHex) ||
                other.responseHex == responseHex) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.durationMs, durationMs) ||
                other.durationMs == durationMs) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      meterId,
      concentratorId,
      operation,
      status,
      requestHex,
      responseHex,
      errorMessage,
      durationMs,
      timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OperationLogImplCopyWith<_$OperationLogImpl> get copyWith =>
      __$$OperationLogImplCopyWithImpl<_$OperationLogImpl>(this, _$identity);
}

abstract class _OperationLog implements OperationLog {
  const factory _OperationLog(
      {required final int id,
      required final int meterId,
      required final int concentratorId,
      required final String operation,
      required final OperationStatus status,
      final String? requestHex,
      final String? responseHex,
      final String? errorMessage,
      required final int durationMs,
      required final DateTime timestamp}) = _$OperationLogImpl;

  @override
  int get id;
  @override
  int get meterId;
  @override
  int get concentratorId;
  @override
  String get operation;
  @override // e.g. "READ_ENERGY", "SET_CLOCK", "CONNECT"
  OperationStatus get status;
  @override
  String? get requestHex;
  @override
  String? get responseHex;
  @override
  String? get errorMessage;
  @override
  int get durationMs;
  @override
  DateTime get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$OperationLogImplCopyWith<_$OperationLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
