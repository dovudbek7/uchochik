import 'package:isar/isar.dart';
import 'package:uchochik/data/models/operation_log_model.dart';

class OperationLogDatasource {
  const OperationLogDatasource(this._isar);
  final Isar _isar;

  Future<List<OperationLogModel>> getByMeter(int meterId) => _isar
      .operationLogModels
      .filter()
      .meterIdEqualTo(meterId)
      .sortByTimestampDesc()
      .findAll();

  Future<List<OperationLogModel>> getRecent({int limit = 100}) => _isar
      .operationLogModels
      .where()
      .sortByTimestampDesc()
      .limit(limit)
      .findAll();

  Future<int> save(OperationLogModel model) =>
      _isar.writeTxn(() => _isar.operationLogModels.put(model));

  Future<void> deleteOlderThan(DateTime cutoff) async {
    final old = await _isar.operationLogModels
        .filter()
        .timestampLessThan(cutoff)
        .findAll();
    await _isar.writeTxn(
      () => _isar.operationLogModels.deleteAll(old.map((e) => e.id).toList()),
    );
  }
}
