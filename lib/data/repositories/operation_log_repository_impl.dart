import 'package:uchochik/data/local/datasources/operation_log_datasource.dart';
import 'package:uchochik/data/models/operation_log_model.dart';
import 'package:uchochik/domain/entities/operation_log.dart';
import 'package:uchochik/domain/repositories/i_operation_log_repository.dart';

class OperationLogRepositoryImpl implements IOperationLogRepository {
  const OperationLogRepositoryImpl(this._ds);
  final OperationLogDatasource _ds;

  @override
  Future<List<OperationLog>> getByMeter(int meterId) async {
    final models = await _ds.getByMeter(meterId);
    return models.map((m) => m.toDomain()).toList();
  }

  @override
  Future<List<OperationLog>> getRecent({int limit = 100}) async {
    final models = await _ds.getRecent(limit: limit);
    return models.map((m) => m.toDomain()).toList();
  }

  @override
  Future<void> save(OperationLog log) =>
      _ds.save(log.toModel());

  @override
  Future<void> deleteOlderThan(DateTime cutoff) =>
      _ds.deleteOlderThan(cutoff);
}
