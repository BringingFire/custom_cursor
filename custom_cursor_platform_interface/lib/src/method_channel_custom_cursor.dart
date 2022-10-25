import 'package:flutter/services.dart';

import '../custom_cursor_platform_interface.dart';

const MethodChannel _channel = MethodChannel('com.bringingfire.custom_cursor');

class MethodChannelCustomCursor extends CustomCursorPlatform {
  static void registerWith() {
    CustomCursorPlatform.instance = MethodChannelCustomCursor();
  }

  @override
  Future<bool> isRegistered(String name) async {
    final result = await _channel.invokeMethod<bool>('isRegistered', name);
    if (result == null) {
      throw Exception();
    }
    return result;
  }

  @override
  Future<void> register(
    String name, {
    required Uint8List image,
    Offset hotSpot = const Offset(0, 0),
  }) {
    return _channel.invokeMethod<void>('register', {
      'name': name,
      'image': image,
      'hotSpot': {
        'x': hotSpot.dx,
        'y': hotSpot.dy,
      }
    });
  }

  @override
  Future<void> showCursor(String name) {
    return _channel.invokeMethod('showCursor', name);
  }
}
