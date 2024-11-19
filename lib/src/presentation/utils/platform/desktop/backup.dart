import 'dart:convert';
import 'dart:io';

import 'package:ambush_app/src/core/settings/const.dart';
import 'package:ambush_app/src/domain/models/application_data.dart';
import 'package:ambush_app/src/presentation/utils/application_persistency.dart';
import 'package:ambush_app/src/presentation/utils/backup_error.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

abstract class IBackup {
  Future<void> save();
  Future<void> get();
}

@Injectable(as: IBackup)
class Backup implements IBackup {
  final IApplicationPersistency _backupPersistency;

  Backup(this._backupPersistency);

  @override
  Future<void> save() async {
    final backupData = _backupPersistency.get();

    final json = backupData.toJson();

    try {
      final jsonString = jsonEncode(json);
      final result = await FilePicker.platform.saveFile(
          allowedExtensions: ['json'],
          type: FileType.custom,
          fileName: jsonFilepath);
      final path = result;
      if (path == null) return;
      final file = File(path);
      file.writeAsString(jsonString);
    } catch (_) {
      throw BackupError('There was an error parsing your backup data');
    }
  }

  @override
  Future<void> get() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    final path = result?.files.first.path;

    if (path == null) return;

    final file = File(path);
    final jsonString = await file.readAsString();

    try {
      final json = jsonDecode(jsonString);
      final backupData = ApplicationData.fromJson(json);
      _backupPersistency.save(backupData);
    } catch (_) {
      throw BackupError('There was an error parsing your backup data');
    }
  }
}
