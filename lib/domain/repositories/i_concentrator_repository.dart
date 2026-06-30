import 'package:uchochik/domain/entities/concentrator.dart';

abstract interface class IConcentratorRepository {
  Future<List<Concentrator>> getAll();
  Future<Concentrator?> getById(int id);
  Future<void> save(Concentrator concentrator);
  Future<void> delete(int id);
  Stream<List<Concentrator>> watchAll();
}
