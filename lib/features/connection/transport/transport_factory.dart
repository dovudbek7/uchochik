import 'package:uchochik/domain/entities/concentrator.dart';
import 'package:uchochik/domain/enums/communication_type.dart';
import 'package:uchochik/features/connection/transport/i_transport.dart';
import 'package:uchochik/features/connection/transport/serial_transport.dart';
import 'package:uchochik/features/connection/transport/tcp_transport.dart';

abstract final class TransportFactory {
  static ITransport create(Concentrator concentrator) {
    return switch (concentrator.communicationType) {
      CommunicationType.tcpIp => TcpTransport(
          host: concentrator.ipAddress ?? '',
          port: concentrator.port ?? 4059,
        ),
      CommunicationType.usbSerial => SerialTransport(
          serverLogical: 1, // default; overridden per-meter in Step 4
          serverPhysical: 17,
          clientSap: 0x10,
          baudRate: concentrator.baudRate ?? 9600,
        ),
    };
  }
}
