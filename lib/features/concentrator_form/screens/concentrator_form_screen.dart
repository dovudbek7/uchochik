import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:uchochik/app/theme/app_colors.dart';
import 'package:uchochik/core/di/injection.dart';
import 'package:uchochik/domain/entities/concentrator.dart';
import 'package:uchochik/domain/enums/communication_type.dart';
import 'package:uchochik/domain/repositories/i_concentrator_repository.dart';

class ConcentratorFormScreen extends StatefulWidget {
  const ConcentratorFormScreen({super.key});

  @override
  State<ConcentratorFormScreen> createState() => _ConcentratorFormScreenState();
}

class _ConcentratorFormScreenState extends State<ConcentratorFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _serialCtrl = TextEditingController();
  final _ipCtrl = TextEditingController();
  final _portCtrl = TextEditingController(text: '4059');
  final _serialPortCtrl = TextEditingController(text: '/dev/ttyUSB0');
  final _baudCtrl = TextEditingController(text: '9600');

  CommunicationType _commType = CommunicationType.tcpIp;
  bool _saving = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _serialCtrl.dispose();
    _ipCtrl.dispose();
    _portCtrl.dispose();
    _serialPortCtrl.dispose();
    _baudCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final concentrator = Concentrator(
      id: 0, // Isar assigns on insert
      name: _nameCtrl.text.trim(),
      serialNumber: _serialCtrl.text.trim(),
      communicationType: _commType,
      ipAddress: _commType == CommunicationType.tcpIp ? _ipCtrl.text.trim() : null,
      port: _commType == CommunicationType.tcpIp
          ? int.tryParse(_portCtrl.text.trim())
          : null,
      serialPortDevice: _commType == CommunicationType.usbSerial
          ? _serialPortCtrl.text.trim()
          : null,
      baudRate: _commType == CommunicationType.usbSerial
          ? int.tryParse(_baudCtrl.text.trim())
          : null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    try {
      await getIt<IConcentratorRepository>().save(concentrator);
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
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
        title: const Text('New Concentrator'),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _Section(label: 'IDENTITY', children: [
              _Field(
                controller: _nameCtrl,
                label: 'Name',
                hint: 'e.g. Substation North-1',
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              _Field(
                controller: _serialCtrl,
                label: 'Serial Number',
                hint: 'e.g. KF20230001',
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
            ]),
            const SizedBox(height: 24),
            _Section(label: 'CONNECTION TYPE', children: [
              _CommTypeSelector(
                value: _commType,
                onChanged: (t) => setState(() => _commType = t),
              ),
            ]),
            const SizedBox(height: 24),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _commType == CommunicationType.tcpIp
                  ? _TcpFields(ipCtrl: _ipCtrl, portCtrl: _portCtrl)
                  : _SerialFields(
                      portCtrl: _serialPortCtrl,
                      baudCtrl: _baudCtrl,
                    ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: AppColors.onPrimary),
                    )
                  : const Text('Save Concentrator'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({super.key, required this.label, required this.children});
  final String label;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.onSurfaceMuted,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
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
  });
  final TextEditingController controller;
  final String label;
  final String? hint;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      style: const TextStyle(color: AppColors.onSurface, fontSize: 15),
      decoration: InputDecoration(labelText: label, hintText: hint),
    );
  }
}

class _CommTypeSelector extends StatelessWidget {
  const _CommTypeSelector({required this.value, required this.onChanged});
  final CommunicationType value;
  final void Function(CommunicationType) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: CommunicationType.values.map((t) {
        final selected = t == value;
        return Expanded(
          child: GestureDetector(
            onTap: () => onChanged(t),
            child: Container(
              margin: EdgeInsets.only(right: t == CommunicationType.tcpIp ? 8 : 0),
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
                    t == CommunicationType.tcpIp
                        ? Icons.router_rounded
                        : Icons.usb_rounded,
                    color: selected ? AppColors.primary : AppColors.onSurfaceMuted,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    t.displayName,
                    style: TextStyle(
                      color:
                          selected ? AppColors.primary : AppColors.onSurfaceMuted,
                      fontSize: 12,
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
}

class _TcpFields extends StatelessWidget {
  const _TcpFields({required this.ipCtrl, required this.portCtrl});
  final TextEditingController ipCtrl;
  final TextEditingController portCtrl;

  @override
  Widget build(BuildContext context) {
    return _Section(
      key: const ValueKey('tcp'),
      label: 'TCP / IP',
      children: [
        _Field(
          controller: ipCtrl,
          label: 'IP Address',
          hint: '192.168.1.100',
          keyboardType: TextInputType.number,
          validator: (v) {
            if (v == null || v.trim().isEmpty) return 'Required';
            final parts = v.trim().split('.');
            if (parts.length != 4) return 'Invalid IP';
            return null;
          },
        ),
        const SizedBox(height: 12),
        _Field(
          controller: portCtrl,
          label: 'Port',
          hint: '4059',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (v) {
            final p = int.tryParse(v ?? '');
            if (p == null || p < 1 || p > 65535) return 'Port: 1–65535';
            return null;
          },
        ),
      ],
    );
  }
}

class _SerialFields extends StatelessWidget {
  const _SerialFields({required this.portCtrl, required this.baudCtrl});
  final TextEditingController portCtrl;
  final TextEditingController baudCtrl;

  @override
  Widget build(BuildContext context) {
    return _Section(
      key: const ValueKey('serial'),
      label: 'USB SERIAL',
      children: [
        _Field(
          controller: portCtrl,
          label: 'Port Device',
          hint: '/dev/ttyUSB0',
          validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'Required' : null,
        ),
        const SizedBox(height: 12),
        _Field(
          controller: baudCtrl,
          label: 'Baud Rate',
          hint: '9600',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (v) =>
              int.tryParse(v ?? '') == null ? 'Invalid baud rate' : null,
        ),
      ],
    );
  }
}
