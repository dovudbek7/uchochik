import 'package:isar/isar.dart';
import 'package:uchochik/data/models/concentrator_model.dart';

class ConcentratorDatasource {
  const ConcentratorDatasource(this._isar);
  final Isar _isar;

  Future<List<ConcentratorModel>> getAll() =>
      _isar.concentratorModels.where().findAll();

  Future<ConcentratorModel?> getById(int id) =>
      _isar.concentratorModels.get(id);

  Future<int> save(ConcentratorModel model) =>
      _isar.writeTxn(() => _isar.concentratorModels.put(model));

  Future<bool> delete(int id) =>
      _isar.writeTxn(() => _isar.concentratorModels.delete(id));

  Stream<List<ConcentratorModel>> watchAll() =>
      _isar.concentratorModels.where().watch(fireImmediately: true);
}
