import 'package:uchochik/data/local/datasources/concentrator_datasource.dart';
import 'package:uchochik/data/models/concentrator_model.dart';
import 'package:uchochik/domain/entities/concentrator.dart';
import 'package:uchochik/domain/repositories/i_concentrator_repository.dart';

class ConcentratorRepositoryImpl implements IConcentratorRepository {
  const ConcentratorRepositoryImpl(this._datasource);
  final ConcentratorDatasource _datasource;

  @override
  Future<List<Concentrator>> getAll() async {
    final models = await _datasource.getAll();
    return models.map((m) => m.toDomain()).toList();
  }

  @override
  Future<Concentrator?> getById(int id) async {
    final model = await _datasource.getById(id);
    return model?.toDomain();
  }

  @override
  Future<void> save(Concentrator concentrator) async {
    await _datasource.save(concentrator.toModel());
  }

  @override
  Future<void> delete(int id) async {
    await _datasource.delete(id);
  }

  @override
  Stream<List<Concentrator>> watchAll() =>
      _datasource.watchAll().map((list) => list.map((m) => m.toDomain()).toList());
}
