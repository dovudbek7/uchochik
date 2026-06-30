import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uchochik/domain/enums/auth_level.dart';
import 'package:uchochik/domain/enums/meter_type.dart';

part 'meter.freezed.dart';

@freezed
class Meter with _$Meter {
  const factory Meter({
    required int id,
    required int concentratorId,
    required String serialNumber,
    required String accountNumber,
    required MeterType meterType,
    // DLMS/COSEM server addressing
    required int logicalDeviceAddress, // upper HDLC address (e.g. 1)
    required int physicalAddress, // lower HDLC address (e.g. 17)
    required int clientAddress, // client SAP — management: 0x10, public: 0x10
    // DLMS security
    required AuthLevel authLevel,
    String? password, // low-level auth; AES-256 encrypted at rest
    String? encryptionKey, // 16-byte HEX; AES-256 encrypted at rest
    String? authenticationKey, // 16-byte HEX; AES-256 encrypted at rest
    // Metadata
    String? manufacturerId,
    String? firmwareVersion,
    DateTime? lastReadAt,
    DateTime? installedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Meter;
}
