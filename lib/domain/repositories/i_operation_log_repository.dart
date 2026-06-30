import 'package:uchochik/domain/entities/operation_log.dart';

abstract interface class IOperationLogRepository {
  Future<List<OperationLog>> getByMeter(int meterId);
  Future<List<OperationLog>> getRecent({int limit = 100});
  Future<void> save(OperationLog log);
  Future<void> deleteOlderThan(DateTime cutoff);
}
