import 'package:uchochik/data/local/datasources/network_group_datasource.dart';
import 'package:uchochik/data/models/network_group_model.dart'; // mapper extensions
import 'package:uchochik/domain/entities/network_group.dart';
import 'package:uchochik/domain/repositories/i_network_group_repository.dart';

class NetworkGroupRepositoryImpl implements INetworkGroupRepository {
  const NetworkGroupRepositoryImpl(this._datasource);
  final NetworkGroupDatasource _datasource;

  @override
  Future<List<NetworkGroup>> getAll() async {
    final models = await _datasource.getAll();
    return models.map((m) => m.toDomain()).toList();
  }

  @override
  Future<NetworkGroup?> getById(int id) async {
    final model = await _datasource.getById(id);
    return model?.toDomain();
  }

  @override
  Future<void> save(NetworkGroup group) async {
    await _datasource.save(group.toModel());
  }

  @override
  Future<void> delete(int id) async {
    await _datasource.delete(id);
  }

  @override
  Stream<List<NetworkGroup>> watchAll() =>
      _datasource.watchAll().map((list) => list.map((m) => m.toDomain()).toList());
}
