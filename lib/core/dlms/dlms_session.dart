import 'package:uchochik/core/dlms/dlms_apdu.dart';
import 'package:uchochik/core/dlms/dlms_data.dart';
import 'package:uchochik/core/dlms/dlms_get.dart';
import 'package:uchochik/domain/entities/meter.dart';
import 'package:uchochik/features/connection/transport/i_transport.dart';

class DlmsSession {
  DlmsSession({required this.transport, required this.meter});

  final ITransport transport;
  final Meter meter;

  bool _associated = false;
  bool get isAssociated => _associated;

  // ── Association ────────────────────────────────────────────────────────────

  Future<void> associate() async {
    final aarq = DlmsApdu.buildAarq(
      authLevel: meter.authLevel,
      password: meter.password,
    );
    final response = await transport.request(aarq);
    DlmsApdu.parseAare(response); // throws DlmsAssociationException on failure
    _associated = true;
  }

  Future<void> release() async {
    if (!_associated) return;
    try {
      final rlrq = DlmsApdu.buildRlrq();
      await transport.request(rlrq);
    } catch (_) {
      // Best-effort release
    } finally {
      _associated = false;
    }
  }

  // ── Attribute read ─────────────────────────────────────────────────────────

  Future<DlmsData> getAttribute({
    required int classId,
    required List<int> obis,
    int attributeId = 2,
  }) async {
    if (!_associated) await associate();
    final req = DlmsGet.buildRequest(
      classId: classId,
      obis: obis,
      attributeId: attributeId,
    );
    final resp = await transport.request(req);
    return DlmsGet.parseResponse(resp);
  }

  Future<ObisReading> readRegister({
    required int classId,
    required List<int> obis,
    int attributeId = 2,
  }) async {
    final data = await getAttribute(
      classId: classId,
      obis: obis,
      attributeId: attributeId,
    );
    return ObisReading(
      classId: classId,
      obis: obis,
      attributeId: attributeId,
      data: data,
      readAt: DateTime.now(),
    );
  }

  // ── Convenience: read a predefined register list ───────────────────────────

  Future<List<ObisReading>> readAll(List<ObisDescriptor> descriptors) async {
    if (!_associated) await associate();
    final results = <ObisReading>[];
    for (final d in descriptors) {
      try {
        final reading = await readRegister(
          classId: d.classId,
          obis: d.obis,
          attributeId: d.attributeId,
        );
        results.add(reading);
      } catch (_) {
        // Skip failed registers — partial reads still valid
      }
    }
    return results;
  }
}

/// Descriptor for a single COSEM attribute to read.
class ObisDescriptor {
  const ObisDescriptor({
    required this.classId,
    required this.obis,
    this.attributeId = 2,
    required this.label,
    this.unit,
  });

  final int classId;
  final List<int> obis; // 6 bytes
  final int attributeId;
  final String label;
  final String? unit;
}

// ── Standard electricity register descriptors ─────────────────────────────────

abstract final class ElectricityRegisters {
  static const clockDescriptor = ObisDescriptor(
    classId: 8,
    obis: [0, 0, 1, 0, 0, 255],
    attributeId: 2,
    label: 'Clock',
  );

  static const activeEnergyImport = ObisDescriptor(
    classId: 3,
    obis: [1, 0, 1, 8, 0, 255],
    label: 'Active Energy Import',
    unit: 'kWh',
  );

  static const activeEnergyExport = ObisDescriptor(
    classId: 3,
    obis: [1, 0, 2, 8, 0, 255],
    label: 'Active Energy Export',
    unit: 'kWh',
  );

  static const reactiveEnergyImport = ObisDescriptor(
    classId: 3,
    obis: [1, 0, 3, 8, 0, 255],
    label: 'Reactive Energy Import',
    unit: 'kVArh',
  );

  static const reactiveEnergyExport = ObisDescriptor(
    classId: 3,
    obis: [1, 0, 4, 8, 0, 255],
    label: 'Reactive Energy Export',
    unit: 'kVArh',
  );

  static const activePowerTotal = ObisDescriptor(
    classId: 3,
    obis: [1, 0, 1, 7, 0, 255],
    label: 'Active Power Total',
    unit: 'kW',
  );

  static const voltageL1 = ObisDescriptor(
    classId: 3,
    obis: [1, 0, 32, 7, 0, 255],
    label: 'Voltage L1',
    unit: 'V',
  );

  static const voltageL2 = ObisDescriptor(
    classId: 3,
    obis: [1, 0, 52, 7, 0, 255],
    label: 'Voltage L2',
    unit: 'V',
  );

  static const voltageL3 = ObisDescriptor(
    classId: 3,
    obis: [1, 0, 72, 7, 0, 255],
    label: 'Voltage L3',
    unit: 'V',
  );

  static const currentL1 = ObisDescriptor(
    classId: 3,
    obis: [1, 0, 31, 7, 0, 255],
    label: 'Current L1',
    unit: 'A',
  );

  static const currentL2 = ObisDescriptor(
    classId: 3,
    obis: [1, 0, 51, 7, 0, 255],
    label: 'Current L2',
    unit: 'A',
  );

  static const currentL3 = ObisDescriptor(
    classId: 3,
    obis: [1, 0, 71, 7, 0, 255],
    label: 'Current L3',
    unit: 'A',
  );

  static const frequency = ObisDescriptor(
    classId: 3,
    obis: [1, 0, 14, 7, 0, 255],
    label: 'Frequency',
    unit: 'Hz',
  );

  static const serialNumber = ObisDescriptor(
    classId: 1,
    obis: [0, 0, 96, 1, 0, 255],
    label: 'Serial Number',
  );

  static const List<ObisDescriptor> standardReadout = [
    clockDescriptor,
    serialNumber,
    activeEnergyImport,
    activeEnergyExport,
    reactiveEnergyImport,
    reactiveEnergyExport,
    activePowerTotal,
    voltageL1,
    voltageL2,
    voltageL3,
    currentL1,
    currentL2,
    currentL3,
    frequency,
  ];
}
