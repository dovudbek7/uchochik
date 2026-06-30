/// DLMS/COSEM protocol constants per IEC 62056-46/47/62.
abstract final class DlmsConstants {
  // ── Client addresses (SAPs) ───────────────────────────────────────────────
  static const int clientManagementSap = 0x10; // 16  — management client
  static const int clientPublicSap = 0x10;
  static const int clientReadWriteSap = 0x03;

  // ── HDLC frame delimiters ─────────────────────────────────────────────────
  static const int hdlcFlag = 0x7E;
  static const int hdlcFormatType = 0xA0;

  // ── APDU tags ────────────────────────────────────────────────────────────
  static const int aarqTag = 0x60;
  static const int aarerTag = 0x61;
  static const int getRqTag = 0xC0;
  static const int getRsTag = 0xC4;
  static const int setRqTag = 0xC1;
  static const int setRsTag = 0xC5;
  static const int actionRqTag = 0xC3;
  static const int actionRsTag = 0xC7;

  // ── OBIS codes (IEC 62056-61 class codes) ────────────────────────────────
  /// Active energy import total (kWh)
  static const List<int> obisEnergyImport = [1, 0, 1, 8, 0, 255];

  /// Active energy export total (kWh)
  static const List<int> obisEnergyExport = [1, 0, 2, 8, 0, 255];

  /// Instantaneous voltage L1 (V)
  static const List<int> obisVoltageL1 = [1, 0, 32, 7, 0, 255];

  /// Instantaneous current L1 (A)
  static const List<int> obisCurrentL1 = [1, 0, 31, 7, 0, 255];

  /// Clock object
  static const List<int> obisClock = [0, 0, 1, 0, 0, 255];

  /// Meter serial number
  static const List<int> obisSerialNumber = [0, 0, 96, 1, 0, 255];

  /// Firmware version
  static const List<int> obisFirmwareVersion = [1, 0, 0, 2, 0, 255];

  // ── Transport defaults ────────────────────────────────────────────────────
  static const int defaultTcpPort = 4059; // IEC 62056 standard port
  static const int defaultSocketTimeoutMs = 10000;
  static const int defaultSerialBaudRate = 9600;
  static const int maxFrameSize = 1024;
}
