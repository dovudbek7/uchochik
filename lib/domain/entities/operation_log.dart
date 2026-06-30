import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uchochik/domain/enums/operation_status.dart';

part 'operation_log.freezed.dart';

@freezed
class OperationLog with _$OperationLog {
  const factory OperationLog({
    required int id,
    required int meterId,
    required int concentratorId,
    required String operation, // e.g. "READ_ENERGY", "SET_CLOCK", "CONNECT"
    required OperationStatus status,
    String? requestHex,
    String? responseHex,
    String? errorMessage,
    required int durationMs,
    required DateTime timestamp,
  }) = _OperationLog;
}
