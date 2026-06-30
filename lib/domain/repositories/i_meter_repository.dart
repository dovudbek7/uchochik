import 'package:uchochik/domain/entities/meter.dart';

abstract interface class IMeterRepository {
  Future<List<Meter>> getAll();
  Future<List<Meter>> getByConcentrator(int concentratorId);
  Future<Meter?> getById(int id);
  Future<void> save(Meter meter);
  Future<void> delete(int id);
  Stream<List<Meter>> watchByConcentrator(int concentratorId);
}
