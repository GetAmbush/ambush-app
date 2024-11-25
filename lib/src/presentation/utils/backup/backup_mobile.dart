import 'package:ambush_app/src/presentation/utils/backup/backup_contract.dart';
import 'package:ambush_app/src/presentation/utils/backup/backup_error.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';

@injectable
class MobileBackup implements IBackup {
  final _platform = MethodChannel('flutter.dev/preferences');

  @override
  Future<void> create(String data) async {
    try {
      final result =
          await _platform.invokeMapMethod('create_backup', {'data': data});
      await Share.shareXFiles([XFile(result?['path'] as String)]);
    } catch (_) {
      throw BackupError(
          'There was an error saving your data in the file manager');
    }
  }

  @override
  Future<String?> restore() async {
    try {
      return await _platform.invokeMethod('restore_backup') as String;
    } catch (_) {
      throw BackupError(
          'There was an error restoring your data from the file manager');
    }
  }
}
