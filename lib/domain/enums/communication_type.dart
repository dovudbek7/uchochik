enum CommunicationType {
  tcpIp,
  usbSerial;

  String get displayName => switch (this) {
        CommunicationType.tcpIp => 'TCP/IP',
        CommunicationType.usbSerial => 'USB Serial (OTG)',
      };
}
