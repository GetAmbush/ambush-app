import 'dart:convert';
import 'dart:io';

import 'package:ambush_app/src/core/settings/const.dart';
import 'package:ambush_app/src/data/models/hive_backup.dart';
import 'package:ambush_app/src/domain/usecases/get_backup.dart';
import 'package:ambush_app/src/domain/usecases/save_backup.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:json_hive_generator/json_hive_generator.dart';

abstract class IBackup {
  Future<bool> save();
  Future<bool> recover();
}

@Injectable(as: IBackup)
class Backup implements IBackup {
  final ISaveBackup _saveBackup;
  final IGetBackup _getBackup;

  Backup(this._saveBackup, this._getBackup);

  @override
  Future<bool> save() async {
    final backup = _getBackup.get();
    final json = backup?.toJson();
    if (json == null) return false;
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
  }

  @override
  Future<bool> recover() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    final path = result?.files.first.path;
    if (path == null) return false;
    final file = File(path);
    final jsonString = await file.readAsString();
    final json = jsonDecode(jsonString);
    final backup = HiveBackup.fromJson(json);
    _saveBackup.save(backup);
    return true;
  }
}
