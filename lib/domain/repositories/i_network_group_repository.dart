import 'package:uchochik/domain/entities/network_group.dart';

abstract interface class INetworkGroupRepository {
  Future<List<NetworkGroup>> getAll();
  Future<NetworkGroup?> getById(int id);
  Future<void> save(NetworkGroup group);
  Future<void> delete(int id);
  Stream<List<NetworkGroup>> watchAll();
}
