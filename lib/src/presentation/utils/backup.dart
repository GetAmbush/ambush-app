import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ambush_app/src/core/settings/const.dart';
import 'package:ambush_app/src/presentation/utils/backup_error.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:universal_html/html.dart' as html;

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

@injectable
class MobileBackup implements IBackup {
  @override
  Future<void> create(String data) => throw BackupError(platformError);

  @override
  Future<String?> restore() => throw BackupError(platformError);
}

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

@injectable
class WebBackup implements IBackup {
  @override
  Future<void> create(String data) async {
    final bytes = utf8.encode(data);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    html.AnchorElement(href: url)
      ..setAttribute("download", jsonFilepath)
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  @override
  Future<String?> restore() async {
    final Completer<String?> completer = Completer();
    final html.FileUploadInputElement input = html.FileUploadInputElement()
      ..accept = '.json';

    input.click();

    input.onChange.listen((e) async {
      final file = input.files?.first;
      if (file == null) {
        completer.complete(null);
        return;
      }
      final reader = html.FileReader();

      reader.onLoadEnd.listen((e) {
        final data = reader.result as String;
        completer.complete(data);
      });
      reader.readAsText(file);
    });
    return completer.future;
  }
}
