import 'dart:ui';

import 'package:custom_cursor_platform_interface/src/method_channel_custom_cursor.dart';
import 'package:flutter/foundation.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

export 'src/method_channel_custom_cursor.dart' show MethodChannelCustomCursor;

abstract class CustomCursorPlatform extends PlatformInterface {
  CustomCursorPlatform() : super(token: _token);

  static final Object _token = Object();

  static CustomCursorPlatform _instance = MethodChannelCustomCursor();

  static CustomCursorPlatform get instance => _instance;

  static set instance(CustomCursorPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Checks if a cursor with [name] is already registered with the host system.
  Future<bool> isRegistered(String name);

  /// Registers a cursor with the specified image data and hotspot under name.
  ///
  /// If a cursor has already been registered with [[name]], it will be replaced.
  Future<void> register(
    String name, {
    required Uint8List image,
    Offset hotSpot = const Offset(0, 0),
  });

  /// Show the cursor with [[name]].
  ///
  /// The cursor must have been previously registered with [[register]].
  Future<void> showCursor(String name);
}
