import 'dart:io';

import 'package:ambush_app/src/core/di/di.dart';
import 'package:ambush_app/src/presentation/utils/backup.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

abstract class IBackupFactory {
  IBackup create();
}

@Injectable(as: IBackupFactory)
class BackupFactory implements IBackupFactory {
  @override
  IBackup create() {
    if (Platform.isIOS || Platform.isAndroid) {
      return getIt<MobileBackup>();
    }
    if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
      return getIt<DesktopBackup>();
    }
    if (kIsWeb) {
      return getIt<WebBackup>();
    } else {
      return getIt<UnimplementedBackup>();
    }
  }
}
