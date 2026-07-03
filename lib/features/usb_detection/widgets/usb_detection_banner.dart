import 'package:flutter/material.dart' hide ConnectionState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uchochik/app/theme/app_colors.dart';
import 'package:uchochik/core/di/injection.dart';
import 'package:uchochik/domain/entities/concentrator.dart';
import 'package:uchochik/domain/enums/communication_type.dart';
import 'package:uchochik/domain/repositories/i_concentrator_repository.dart';
import 'package:uchochik/features/connection/bloc/connection_bloc.dart';
import 'package:uchochik/features/usb_detection/cubit/usb_detection_cubit.dart';

class UsbDetectionBanner extends StatefulWidget {
  const UsbDetectionBanner({super.key});

  @override
  State<UsbDetectionBanner> createState() => _UsbDetectionBannerState();
}

class _UsbDetectionBannerState extends State<UsbDetectionBanner>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getIt<UsbDetectionCubit>().refresh();
    }
  }

  void _connect(BuildContext context, Concentrator concentrator) {
    context.read<ConnectionBloc>().add(ConnectRequested(concentrator: concentrator));
    context.push('/connect/${concentrator.id}');
  }

  void _showPicker(BuildContext context, List<Concentrator> matches) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surfaceContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Connect to',
                  style: TextStyle(
                    color: AppColors.onSurfaceMuted,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
            for (final c in matches)
              ListTile(
                leading: const Icon(Icons.usb_rounded, color: AppColors.primary),
                title: Text(c.name, style: const TextStyle(color: AppColors.onSurface)),
                subtitle: Text(c.serialPortDevice ?? '—',
                    style: const TextStyle(
                        color: AppColors.onSurfaceMuted, fontFamily: 'monospace')),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _connect(context, c);
                },
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsbDetectionCubit, UsbDetectionState>(
      bloc: getIt<UsbDetectionCubit>(),
      builder: (context, usbState) {
        if (usbState is! UsbDetectionAttached) return const SizedBox.shrink();

        final connState = context.watch<ConnectionBloc>().state;
        if (connState is ConnectionActive || connState is ConnectionConnecting) {
          return const SizedBox.shrink();
        }

        return StreamBuilder<List<Concentrator>>(
          stream: getIt<IConcentratorRepository>().watchAll(),
          builder: (context, snapshot) {
            final matches = (snapshot.data ?? [])
                .where((c) => c.communicationType == CommunicationType.usbSerial)
                .toList();

            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: _BannerCard(
                matches: matches,
                onTap: matches.isEmpty
                    ? null
                    : () {
                        if (matches.length == 1) {
                          _connect(context, matches.first);
                        } else {
                          _showPicker(context, matches);
                        }
                      },
              ),
            );
          },
        );
      },
    );
  }
}

class _BannerCard extends StatelessWidget {
  const _BannerCard({required this.matches, required this.onTap});
  final List<Concentrator> matches;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final subtitle = switch (matches.length) {
      0 => 'No saved device for this probe yet',
      1 => 'Tap to connect to ${matches.first.name}',
      _ => 'Tap to choose a device',
    };

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.online.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.online.withValues(alpha: 0.25)),
          ),
          child: Row(
            children: [
              const Icon(Icons.usb_rounded, color: AppColors.online, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'USB device connected',
                      style: TextStyle(
                          color: AppColors.onSurface,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Text(subtitle,
                        style: const TextStyle(
                            color: AppColors.onSurfaceMuted, fontSize: 12)),
                  ],
                ),
              ),
              if (onTap != null)
                const Icon(Icons.chevron_right_rounded,
                    color: AppColors.onSurfaceMuted, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
