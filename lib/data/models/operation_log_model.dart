import 'package:isar/isar.dart';
import 'package:uchochik/domain/entities/operation_log.dart';
import 'package:uchochik/domain/enums/operation_status.dart';

part 'operation_log_model.g.dart';

@collection
class OperationLogModel {
  Id id = Isar.autoIncrement;

  @Index()
  late int meterId;

  @Index()
  late int concentratorId;

  late String operation;

  @enumerated
  late OperationStatus status;

  String? requestHex;
  String? responseHex;
  String? errorMessage;
  late int durationMs;

  @Index()
  late DateTime timestamp;
}

extension OperationLogModelMapper on OperationLogModel {
  OperationLog toDomain() => OperationLog(
        id: id,
        meterId: meterId,
        concentratorId: concentratorId,
        operation: operation,
        status: status,
        requestHex: requestHex,
        responseHex: responseHex,
        errorMessage: errorMessage,
        durationMs: durationMs,
        timestamp: timestamp,
      );
}

extension OperationLogMapper on OperationLog {
  OperationLogModel toModel() {
    final model = OperationLogModel()
      ..id = id
      ..meterId = meterId
      ..concentratorId = concentratorId
      ..operation = operation
      ..status = status
      ..requestHex = requestHex
      ..responseHex = responseHex
      ..errorMessage = errorMessage
      ..durationMs = durationMs
      ..timestamp = timestamp;
    return model;
  }
}
