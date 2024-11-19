import 'dart:convert';
import 'dart:io';

import 'package:ambush_app/src/core/settings/const.dart';
import 'package:ambush_app/src/domain/models/backup_data.dart';
import 'package:ambush_app/src/presentation/utils/backup_persistency.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

abstract class IBackup {
  Future<bool> save();
  Future<bool> get();
}

@Injectable(as: IBackup)
class Backup implements IBackup {
  final IBackupPersistency _backupPersistency;

  Backup(this._backupPersistency);

  @override
  Future<bool> save() async {
    final backupData = _backupPersistency.get();

    final json = backupData.toJson();

    try {
      final jsonString = jsonEncode(json);
      final result = await FilePicker.platform.saveFile(
          allowedExtensions: ['json'],
          type: FileType.custom,
          fileName: jsonFilepath);
      final path = result;
      if (path == null) return false;
      final file = File(path);
      file.writeAsString(jsonString);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> get() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    final path = result?.files.first.path;

    if (path == null) return false;

    final file = File(path);
    final jsonString = await file.readAsString();

    try {
      final json = jsonDecode(jsonString);
      final backupData = BackupData.fromJson(json);
      _backupPersistency.save(backupData);
      return true;
    } catch (_) {
      return false;
    }
  }
}
