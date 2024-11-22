import 'dart:io';

import 'package:ambush_app/src/core/settings/const.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

import 'backup_contract.dart';

@injectable
class DesktopBackup implements IBackup {
  @override
  Future<void> create(String data) async {
    final result = await FilePicker.platform.saveFile(
        allowedExtensions: ['json'],
        type: FileType.custom,
        fileName: jsonFilepath);
    final path = result;
    if (path == null) return;
    final file = File(path);
    file.writeAsString(data);
  }

  @override
  Future<String?> restore() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    final path = result?.files.first.path;

    if (path == null) return null;

    final file = File(path);
    final data = await file.readAsString();
    return data;
  }
}
