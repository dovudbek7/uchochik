import 'package:isar/isar.dart';
import 'package:uchochik/data/models/meter_model.dart';

class MeterDatasource {
  const MeterDatasource(this._isar);
  final Isar _isar;

  Future<List<MeterModel>> getAll() => _isar.meterModels.where().findAll();

  Future<List<MeterModel>> getByConcentrator(int concentratorId) => _isar
      .meterModels
      .filter()
      .concentratorIdEqualTo(concentratorId)
      .findAll();

  Future<MeterModel?> getById(int id) => _isar.meterModels.get(id);

  Future<int> save(MeterModel model) =>
      _isar.writeTxn(() => _isar.meterModels.put(model));

  Future<bool> delete(int id) =>
      _isar.writeTxn(() => _isar.meterModels.delete(id));

  Stream<List<MeterModel>> watchByConcentrator(int concentratorId) => _isar
      .meterModels
      .filter()
      .concentratorIdEqualTo(concentratorId)
      .watch(fireImmediately: true);
}
