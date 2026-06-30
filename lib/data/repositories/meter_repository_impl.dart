import 'package:uchochik/data/local/datasources/meter_datasource.dart';
import 'package:uchochik/data/models/meter_model.dart';
import 'package:uchochik/domain/entities/meter.dart';
import 'package:uchochik/domain/repositories/i_meter_repository.dart';

class MeterRepositoryImpl implements IMeterRepository {
  const MeterRepositoryImpl(this._datasource);
  final MeterDatasource _datasource;

  @override
  Future<List<Meter>> getAll() async {
    final models = await _datasource.getAll();
    return models.map((m) => m.toDomain()).toList();
  }

  @override
  Future<List<Meter>> getByConcentrator(int concentratorId) async {
    final models = await _datasource.getByConcentrator(concentratorId);
    return models.map((m) => m.toDomain()).toList();
  }

  @override
  Future<Meter?> getById(int id) async {
    final model = await _datasource.getById(id);
    return model?.toDomain();
  }

  @override
  Future<void> save(Meter meter) async {
    await _datasource.save(meter.toModel());
  }

  @override
  Future<void> delete(int id) async {
    await _datasource.delete(id);
  }

  @override
  Stream<List<Meter>> watchByConcentrator(int concentratorId) => _datasource
      .watchByConcentrator(concentratorId)
      .map((list) => list.map((m) => m.toDomain()).toList());
}
