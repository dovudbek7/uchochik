import 'package:isar/isar.dart';
import 'package:uchochik/data/models/network_group_model.dart';

class NetworkGroupDatasource {
  const NetworkGroupDatasource(this._isar);
  final Isar _isar;

  Future<List<NetworkGroupModel>> getAll() =>
      _isar.networkGroupModels.where().findAll();

  Future<NetworkGroupModel?> getById(int id) =>
      _isar.networkGroupModels.get(id);

  Future<int> save(NetworkGroupModel model) =>
      _isar.writeTxn(() => _isar.networkGroupModels.put(model));

  Future<bool> delete(int id) =>
      _isar.writeTxn(() => _isar.networkGroupModels.delete(id));

  Stream<List<NetworkGroupModel>> watchAll() =>
      _isar.networkGroupModels.where().watch(fireImmediately: true);
}
