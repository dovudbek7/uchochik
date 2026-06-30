import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uchochik/domain/enums/communication_type.dart';

part 'concentrator.freezed.dart';

@freezed
class Concentrator with _$Concentrator {
  const factory Concentrator({
    required int id,
    required String name,
    String? description,
    required String serialNumber,
    required CommunicationType communicationType,
    // TCP/IP fields
    String? ipAddress,
    int? port,
    // USB Serial fields
    String? serialPortDevice,
    int? baudRate,
    // Hierarchy
    int? networkGroupId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Concentrator;
}
