import 'package:custom_cursor_platform_interface/custom_cursor_platform_interface.dart';
import 'package:flutter/services.dart';

export 'package:custom_cursor_platform_interface/custom_cursor_platform_interface.dart'
    show CustomCursorPlatform;

class CustomCursor extends MouseCursor {
  const CustomCursor(this.name);

  final String name;

  @override
  MouseCursorSession createSession(int device) =>
      _CustomCursorSession(this, device);

  @override
  String get debugDescription => throw UnimplementedError();
}

class _CustomCursorSession extends MouseCursorSession {
  _CustomCursorSession(CustomCursor super.cursor, super.device);

  @override
  CustomCursor get cursor => super.cursor as CustomCursor;

  @override
  Future<void> activate() {
    return CustomCursorPlatform.instance.showCursor(cursor.name);
  }

  @override
  void dispose() {}
}
