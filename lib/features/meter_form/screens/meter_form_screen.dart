import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:uchochik/app/theme/app_colors.dart';
import 'package:uchochik/core/di/injection.dart';
import 'package:uchochik/domain/entities/meter.dart';
import 'package:uchochik/domain/enums/auth_level.dart';
import 'package:uchochik/domain/enums/meter_type.dart';
import 'package:uchochik/domain/repositories/i_meter_repository.dart';

class MeterFormScreen extends StatefulWidget {
  /// [concentratorId] required for new meters. [meter] provided for edit mode.
  const MeterFormScreen({
    super.key,
    this.concentratorId,
    this.meter,
  }) : assert(
          concentratorId != null || meter != null,
          'Provide concentratorId for new meter or meter for edit',
        );

  final int? concentratorId;
  final Meter? meter;

  bool get isEdit => meter != null;

  @override
  State<MeterFormScreen> createState() => _MeterFormScreenState();
}

class _MeterFormScreenState extends State<MeterFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late final _serialCtrl =
      TextEditingController(text: widget.meter?.serialNumber ?? '');
  late final _accountCtrl =
      TextEditingController(text: widget.meter?.accountNumber ?? '');
  late final _logicalCtrl = TextEditingController(
      text: widget.meter?.logicalDeviceAddress.toString() ?? '1');
  late final _physicalCtrl = TextEditingController(
      text: widget.meter?.physicalAddress.toString() ?? '17');
  late final _clientCtrl = TextEditingController(
      text: widget.meter?.clientAddress.toRadixString(16).toUpperCase() ??
          '10');
  late final _passwordCtrl =
      TextEditingController(text: widget.meter?.password ?? '');
  late final _encKeyCtrl =
      TextEditingController(text: widget.meter?.encryptionKey ?? '');
  late final _authKeyCtrl =
      TextEditingController(text: widget.meter?.authenticationKey ?? '');
  late final _mfrCtrl =
      TextEditingController(text: widget.meter?.manufacturerId ?? '');
  late final _fwCtrl =
      TextEditingController(text: widget.meter?.firmwareVersion ?? '');

  late MeterType _meterType = widget.meter?.meterType ?? MeterType.electricity;
  late AuthLevel _authLevel = widget.meter?.authLevel ?? AuthLevel.none;
  bool _saving = false;

  @override
  void dispose() {
    _serialCtrl.dispose();
    _accountCtrl.dispose();
    _logicalCtrl.dispose();
    _physicalCtrl.dispose();
    _clientCtrl.dispose();
    _passwordCtrl.dispose();
    _encKeyCtrl.dispose();
    _authKeyCtrl.dispose();
    _mfrCtrl.dispose();
    _fwCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final concentratorId =
        widget.meter?.concentratorId ?? widget.concentratorId!;

    final clientHex = _clientCtrl.text.trim().replaceAll('0x', '');
    final clientAddr = int.tryParse(clientHex, radix: 16) ?? 0x10;

    final meter = Meter(
      id: widget.meter?.id ?? 0,
      concentratorId: concentratorId,
      serialNumber: _serialCtrl.text.trim(),
      accountNumber: _accountCtrl.text.trim(),
      meterType: _meterType,
      logicalDeviceAddress:
          int.tryParse(_logicalCtrl.text.trim()) ?? 1,
      physicalAddress: int.tryParse(_physicalCtrl.text.trim()) ?? 17,
      clientAddress: clientAddr,
      authLevel: _authLevel,
      password: _authLevel == AuthLevel.low && _passwordCtrl.text.isNotEmpty
          ? _passwordCtrl.text.trim()
          : null,
      encryptionKey: _encKeyCtrl.text.trim().isNotEmpty
          ? _encKeyCtrl.text.trim().toUpperCase()
          : null,
      authenticationKey: _authKeyCtrl.text.trim().isNotEmpty
          ? _authKeyCtrl.text.trim().toUpperCase()
          : null,
      manufacturerId: _mfrCtrl.text.trim().isNotEmpty
          ? _mfrCtrl.text.trim()
          : null,
      firmwareVersion: _fwCtrl.text.trim().isNotEmpty
          ? _fwCtrl.text.trim()
          : null,
      lastReadAt: widget.meter?.lastReadAt,
      installedAt: widget.meter?.installedAt,
      createdAt: widget.meter?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    try {
      await getIt<IMeterRepository>().save(meter);
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit Meter' : 'New Meter'),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
        actions: [
          if (_saving)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primary,
                  ),
                ),
              ),
            )
          else
            TextButton(
              onPressed: _save,
              child: const Text('Save',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  )),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // ── Identity ──────────────────────────────────────────────────
            _Section(label: 'IDENTITY', children: [
              _Field(
                controller: _serialCtrl,
                label: 'Serial Number',
                hint: 'e.g. KF00010023',
                validator: _required,
              ),
              const SizedBox(height: 12),
              _Field(
                controller: _accountCtrl,
                label: 'Account Number',
                hint: 'e.g. 10203040',
                validator: _required,
              ),
            ]),
            const SizedBox(height: 24),

            // ── Meter type ────────────────────────────────────────────────
            _Section(label: 'METER TYPE', children: [
              _MeterTypeSelector(
                value: _meterType,
                onChanged: (t) => setState(() => _meterType = t),
              ),
            ]),
            const SizedBox(height: 24),

            // ── DLMS addressing ───────────────────────────────────────────
            _Section(label: 'DLMS / COSEM ADDRESSING', children: [
              Row(children: [
                Expanded(
                  child: _Field(
                    controller: _logicalCtrl,
                    label: 'Logical Address',
                    hint: '1',
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (v) =>
                        int.tryParse(v ?? '') == null ? 'Integer' : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _Field(
                    controller: _physicalCtrl,
                    label: 'Physical Address',
                    hint: '17',
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (v) =>
                        int.tryParse(v ?? '') == null ? 'Integer' : null,
                  ),
                ),
              ]),
              const SizedBox(height: 12),
              _Field(
                controller: _clientCtrl,
                label: 'Client SAP (hex)',
                hint: '10',
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9a-fA-FxX]')),
                ],
                validator: (v) {
                  final clean = (v ?? '').replaceAll('0x', '');
                  return int.tryParse(clean, radix: 16) == null
                      ? 'Hex value'
                      : null;
                },
              ),
            ]),
            const SizedBox(height: 24),

            // ── Security ──────────────────────────────────────────────────
            _Section(label: 'SECURITY', children: [
              _AuthLevelSelector(
                value: _authLevel,
                onChanged: (l) => setState(() => _authLevel = l),
              ),
              if (_authLevel == AuthLevel.low) ...[
                const SizedBox(height: 12),
                _Field(
                  controller: _passwordCtrl,
                  label: 'Password',
                  hint: 'e.g. 00000000',
                  obscureText: true,
                  validator: _authLevel == AuthLevel.low ? _required : null,
                ),
              ],
              const SizedBox(height: 12),
              _Field(
                controller: _encKeyCtrl,
                label: 'Global Encryption Key (hex, optional)',
                hint: '000102030405060708090A0B0C0D0E0F',
                validator: _optionalHex16,
              ),
              const SizedBox(height: 12),
              _Field(
                controller: _authKeyCtrl,
                label: 'Authentication Key (hex, optional)',
                hint: 'D0D1D2D3D4D5D6D7D8D9DADBDCDDDEDF',
                validator: _optionalHex16,
              ),
            ]),
            const SizedBox(height: 24),

            // ── Metadata ──────────────────────────────────────────────────
            _Section(label: 'METADATA (OPTIONAL)', children: [
              _Field(
                controller: _mfrCtrl,
                label: 'Manufacturer ID',
                hint: 'e.g. KFM',
              ),
              const SizedBox(height: 12),
              _Field(
                controller: _fwCtrl,
                label: 'Firmware Version',
                hint: 'e.g. 1.0.25',
              ),
            ]),
            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: _saving ? null : _save,
              child: Text(widget.isEdit ? 'Save Changes' : 'Add Meter'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  String? _required(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Required' : null;

  String? _optionalHex16(String? v) {
    if (v == null || v.trim().isEmpty) return null;
    final clean = v.trim().replaceAll(' ', '');
    if (clean.length != 32) return '32 hex chars (16 bytes)';
    if (RegExp(r'^[0-9a-fA-F]+$').hasMatch(clean)) return null;
    return 'Hex only';
  }
}

// ── Reusable form widgets ─────────────────────────────────────────────────────

class _Section extends StatelessWidget {
  const _Section({required this.label, required this.children});
  final String label;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
              color: AppColors.onSurfaceMuted,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            )),
        const SizedBox(height: 10),
        ...children,
      ],
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.controller,
    required this.label,
    this.hint,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      obscureText: obscureText,
      style: const TextStyle(color: AppColors.onSurface, fontSize: 15),
      decoration: InputDecoration(labelText: label, hintText: hint),
    );
  }
}

class _MeterTypeSelector extends StatelessWidget {
  const _MeterTypeSelector({required this.value, required this.onChanged});
  final MeterType value;
  final void Function(MeterType) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: MeterType.values.map((t) {
        final selected = t == value;
        final isLast = t == MeterType.values.last;
        return Expanded(
          child: GestureDetector(
            onTap: () => onChanged(t),
            child: Container(
              margin: EdgeInsets.only(right: isLast ? 0 : 8),
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.primary.withValues(alpha: 0.15)
                    : AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: selected ? AppColors.primary : AppColors.border,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    _iconFor(t),
                    color: selected
                        ? AppColors.primary
                        : AppColors.onSurfaceMuted,
                    size: 22,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    t.displayName,
                    style: TextStyle(
                      color: selected
                          ? AppColors.primary
                          : AppColors.onSurfaceMuted,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  IconData _iconFor(MeterType t) => switch (t) {
        MeterType.electricity => Icons.bolt_rounded,
        MeterType.gas => Icons.local_fire_department_rounded,
        MeterType.water => Icons.water_drop_rounded,
      };
}

class _AuthLevelSelector extends StatelessWidget {
  const _AuthLevelSelector({required this.value, required this.onChanged});
  final AuthLevel value;
  final void Function(AuthLevel) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: AuthLevel.values.map((l) {
        final selected = l == value;
        return GestureDetector(
          onTap: () => onChanged(l),
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: selected
                  ? AppColors.primary.withValues(alpha: 0.12)
                  : AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: selected ? AppColors.primary : AppColors.border,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  selected
                      ? Icons.radio_button_checked_rounded
                      : Icons.radio_button_unchecked_rounded,
                  color: selected
                      ? AppColors.primary
                      : AppColors.onSurfaceMuted,
                  size: 18,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l.displayName,
                        style: TextStyle(
                          color: selected
                              ? AppColors.primary
                              : AppColors.onSurface,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        )),
                    Text(
                      _subtitle(l),
                      style: const TextStyle(
                          color: AppColors.onSurfaceMuted, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  String _subtitle(AuthLevel l) => switch (l) {
        AuthLevel.none => 'No authentication — public access',
        AuthLevel.low => 'Password-based — IEC 62056-62 level 1',
        AuthLevel.high => 'GMAC/HLS — IEC 62056-62 level 2',
      };
}
