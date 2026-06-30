import 'package:isar/isar.dart';
import 'package:uchochik/domain/entities/meter.dart';
import 'package:uchochik/domain/enums/auth_level.dart';
import 'package:uchochik/domain/enums/meter_type.dart';

part 'meter_model.g.dart';

@collection
class MeterModel {
  Id id = Isar.autoIncrement;
  late int concentratorId;

  @Index()
  late String serialNumber;

  @Index()
  late String accountNumber;

  @enumerated
  late MeterType meterType;

  // DLMS/COSEM addressing
  late int logicalDeviceAddress;
  late int physicalAddress;
  late int clientAddress;

  @enumerated
  late AuthLevel authLevel;

  // Sensitive fields — stored AES-256 encrypted via IsarService
  String? password;
  String? encryptionKey;
  String? authenticationKey;

  String? manufacturerId;
  String? firmwareVersion;
  DateTime? lastReadAt;
  DateTime? installedAt;
  late DateTime createdAt;
  late DateTime updatedAt;
}

extension MeterModelMapper on MeterModel {
  Meter toDomain() => Meter(
        id: id,
        concentratorId: concentratorId,
        serialNumber: serialNumber,
        accountNumber: accountNumber,
        meterType: meterType,
        logicalDeviceAddress: logicalDeviceAddress,
        physicalAddress: physicalAddress,
        clientAddress: clientAddress,
        authLevel: authLevel,
        password: password,
        encryptionKey: encryptionKey,
        authenticationKey: authenticationKey,
        manufacturerId: manufacturerId,
        firmwareVersion: firmwareVersion,
        lastReadAt: lastReadAt,
        installedAt: installedAt,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

extension MeterMapper on Meter {
  MeterModel toModel() {
    final model = MeterModel()
      ..id = id
      ..concentratorId = concentratorId
      ..serialNumber = serialNumber
      ..accountNumber = accountNumber
      ..meterType = meterType
      ..logicalDeviceAddress = logicalDeviceAddress
      ..physicalAddress = physicalAddress
      ..clientAddress = clientAddress
      ..authLevel = authLevel
      ..password = password
      ..encryptionKey = encryptionKey
      ..authenticationKey = authenticationKey
      ..manufacturerId = manufacturerId
      ..firmwareVersion = firmwareVersion
      ..lastReadAt = lastReadAt
      ..installedAt = installedAt
      ..createdAt = createdAt
      ..updatedAt = updatedAt;
    return model;
  }
}
