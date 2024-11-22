import 'dart:io';

import 'package:ambush_app/src/core/di/di.dart';
import 'package:ambush_app/src/presentation/utils/backup/backup_contract.dart';
import 'package:ambush_app/src/presentation/utils/backup/backup_desktop.dart';
import 'package:ambush_app/src/presentation/utils/backup/backup_web.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

abstract class IBackupFactory {
  IBackup create();
}

@Injectable(as: IBackupFactory)
class BackupFactory implements IBackupFactory {
  @override
  IBackup create() {
    if (kIsWeb) {
      return getIt<WebBackup>();
    } else if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
      return getIt<DesktopBackup>();
    } else {
      return getIt<UnimplementedBackup>();
    }
  }
}
