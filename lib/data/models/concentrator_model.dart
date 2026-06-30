import 'package:isar/isar.dart';
import 'package:uchochik/data/models/meter_model.dart';
import 'package:uchochik/domain/entities/concentrator.dart';
import 'package:uchochik/domain/enums/communication_type.dart';

part 'concentrator_model.g.dart';

@collection
class ConcentratorModel {
  Id id = Isar.autoIncrement;
  late String name;
  String? description;
  late String serialNumber;

  @enumerated
  late CommunicationType communicationType;

  String? ipAddress;
  int? port;
  String? serialPortDevice;
  int? baudRate;
  int? networkGroupId;
  late DateTime createdAt;
  late DateTime updatedAt;

  final meters = IsarLinks<MeterModel>();
}

extension ConcentratorModelMapper on ConcentratorModel {
  Concentrator toDomain() => Concentrator(
        id: id,
        name: name,
        description: description,
        serialNumber: serialNumber,
        communicationType: communicationType,
        ipAddress: ipAddress,
        port: port,
        serialPortDevice: serialPortDevice,
        baudRate: baudRate,
        networkGroupId: networkGroupId,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

extension ConcentratorMapper on Concentrator {
  ConcentratorModel toModel() {
    final model = ConcentratorModel()
      ..id = id
      ..name = name
      ..description = description
      ..serialNumber = serialNumber
      ..communicationType = communicationType
      ..ipAddress = ipAddress
      ..port = port
      ..serialPortDevice = serialPortDevice
      ..baudRate = baudRate
      ..networkGroupId = networkGroupId
      ..createdAt = createdAt
      ..updatedAt = updatedAt;
    return model;
  }
}
