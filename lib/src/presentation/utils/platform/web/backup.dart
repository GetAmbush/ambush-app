import 'dart:async';
import 'dart:convert';

import 'package:ambush_app/src/core/settings/const.dart';
import 'package:ambush_app/src/domain/models/application_data.dart';
import 'package:ambush_app/src/presentation/utils/backup_error.dart';
import 'package:ambush_app/src/presentation/utils/application_persistency.dart';
import 'package:injectable/injectable.dart';
import 'package:universal_html/html.dart' as html;

abstract class IBackup {
  Future<void> create();
  Future<void> restore();
}

@Injectable(as: IBackup)
class Backup implements IBackup {
  final IApplicationPersistency _backupPersistency;

  Backup(this._backupPersistency);

  @override
  Future<void> create() async {
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
    } catch (_) {
      throw BackupError('There was an error parsing your backup data');
    }
  }

  @override
  Future<void> restore() async {
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
          final backupData = ApplicationData.fromJson(json);
          _backupPersistency.save(backupData);
        } catch (_) {
          throw BackupError('There was an error parsing your backup data');
          ;
        }
      });
      reader.readAsText(file);
    });
  }
}
