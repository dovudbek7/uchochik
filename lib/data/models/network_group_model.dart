import 'package:isar/isar.dart';
import 'package:uchochik/domain/entities/network_group.dart';

part 'network_group_model.g.dart';

@collection
class NetworkGroupModel {
  Id id = Isar.autoIncrement;
  late String name;
  String? description;
  late DateTime createdAt;
}

extension NetworkGroupModelMapper on NetworkGroupModel {
  NetworkGroup toDomain() => NetworkGroup(
        id: id,
        name: name,
        description: description,
        createdAt: createdAt,
      );
}

extension NetworkGroupMapper on NetworkGroup {
  NetworkGroupModel toModel() {
    final model = NetworkGroupModel()
      ..id = id
      ..name = name
      ..description = description
      ..createdAt = createdAt;
    return model;
  }
}
