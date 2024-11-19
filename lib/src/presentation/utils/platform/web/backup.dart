import 'dart:async';
import 'dart:convert';

import 'package:ambush_app/src/core/settings/const.dart';
import 'package:ambush_app/src/data/models/hive_backup.dart';
import 'package:ambush_app/src/domain/usecases/get_backup.dart';
import 'package:ambush_app/src/domain/usecases/save_backup.dart';
import 'package:injectable/injectable.dart';
import 'dart:html' as html;

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

    try {
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
          final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
          final backup = HiveBackup.fromJson(jsonData);
          _saveBackup.save(backup);
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
