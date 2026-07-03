import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usb_serial/usb_serial.dart';

sealed class UsbDetectionState {
  const UsbDetectionState();
}

final class UsbDetectionNone extends UsbDetectionState {
  const UsbDetectionNone();
}

final class UsbDetectionAttached extends UsbDetectionState {
  const UsbDetectionAttached({required this.device});
  final UsbDevice device;
}

class UsbDetectionCubit extends Cubit<UsbDetectionState> {
  UsbDetectionCubit() : super(const UsbDetectionNone()) {
    refresh();
    _eventSub = UsbSerial.usbEventStream?.listen((_) => refresh());
  }

  StreamSubscription<UsbEvent>? _eventSub;

  /// Re-polls attached USB devices. Public so app-resume can trigger it
  /// defensively alongside the attach/detach event stream.
  Future<void> refresh() async {
    try {
      final devices = await UsbSerial.listDevices();
      emit(devices.isEmpty
          ? const UsbDetectionNone()
          : UsbDetectionAttached(device: devices.first));
    } catch (_) {
      emit(const UsbDetectionNone());
    }
  }

  @override
  Future<void> close() {
    _eventSub?.cancel();
    return super.close();
  }
}
