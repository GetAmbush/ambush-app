import 'dart:io' show Platform;

export 'platform/file_service_stub.dart' // Default or fallback
    if (Platform.kIsWeb) 'web/file_service_web.dart'
    if (Platform.isMacOS) 'desktop/file_service_macos.dart';
