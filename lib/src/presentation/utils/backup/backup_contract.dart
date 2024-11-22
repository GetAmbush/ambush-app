import 'dart:async';

import 'package:ambush_app/src/core/settings/const.dart';
import 'package:ambush_app/src/presentation/utils/backup/backup_error.dart';
import 'package:injectable/injectable.dart';

abstract class IBackup {
  Future<void> create(String data);
  Future<String?> restore();
}

@injectable
class UnimplementedBackup implements IBackup {
  @override
  Future<void> create(String data) => throw BackupError(platformError);

  @override
  Future<String?> restore() => throw BackupError(platformError);
}
