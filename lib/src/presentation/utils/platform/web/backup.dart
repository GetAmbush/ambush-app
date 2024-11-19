import 'dart:async';
import 'dart:convert';

import 'package:ambush_app/src/core/settings/const.dart';
import 'package:ambush_app/src/domain/models/backup_data.dart';
import 'package:ambush_app/src/presentation/utils/backup_persistency.dart';
import 'package:injectable/injectable.dart';
import 'package:universal_html/html.dart' as html;

abstract class IBackup {
  Future<bool> save();
  Future<bool> recover();
}

@Injectable(as: IBackup)
class Backup implements IBackup {
  final IBackupPersistency _backupPersistency;

  Backup(this._backupPersistency);

  @override
  Future<bool> save() async {
    final backupData = _backupPersistency.get();

    try {
      final json = backupData.toJson();
      final jsonString = jsonEncode(json);
      final bytes = utf8.encode(jsonString);
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);

      html.AnchorElement(href: url)
        ..setAttribute("download", jsonFilepath)
        ..click();
      html.Url.revokeObjectUrl(url);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> recover() async {
    final Completer<bool> completer = Completer();
    final html.FileUploadInputElement input = html.FileUploadInputElement()
      ..accept = '.json';

    input.click();

    input.onChange.listen((e) async {
      final file = input.files!.first;
      final reader = html.FileReader();

      reader.onLoadEnd.listen((e) {
        try {
          final jsonString = reader.result as String;
          final json = jsonDecode(jsonString) as Map<String, dynamic>;
          final backupData = BackupData.fromJson(json);
          _backupPersistency.save(backupData);
          completer.complete(true);
        } catch (_) {
          completer.complete(false);
        }
      });
      reader.readAsText(file);
    });

    return completer.future;
  }
}
