import 'dart:async';
import 'dart:convert';
import 'package:ambush_app/src/core/settings/const.dart';
import 'package:injectable/injectable.dart';
import 'package:universal_html/html.dart' as html;

import 'backup_contract.dart';

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
