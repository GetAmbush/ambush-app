import 'package:injectable/injectable.dart';
import 'package:ambush_app/src/domain/models/invoice.dart';
import 'package:ambush_app/src/domain/usecases/generate_invoice.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:universal_html/html.dart' as web_file;
import 'dart:io' show Platform;
import 'package:file_picker/file_picker.dart';

abstract class IShareInvoice {
  Future<void> share(Invoice invoice);
}

@Injectable(as: IShareInvoice)
class ShareInvoice implements IShareInvoice {
  final IGenerateInvoiceUseCase _generateInvoiceUseCase;

  ShareInvoice(this._generateInvoiceUseCase);

  @override
  Future<void> share(Invoice invoice) async {
    var pdf = _generateInvoiceUseCase.createPdf(invoice);

    if (kIsWeb) {
      final bytes = await pdf.save();
      var blob = web_file.Blob([bytes], 'application/pdf', 'native');
      web_file.AnchorElement(
        href: web_file.Url.createObjectUrlFromBlob(blob).toString(),
      )
        ..setAttribute("download", "invoice_${invoice.id}.pdf")
        ..click();
    } else if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      final filePath = await FilePicker.platform.saveFile(
        dialogTitle: "Save invoice",
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        fileName: "invoice_${invoice.id}.pdf",
      );
      if (filePath != null) {
        final _ = await _generateInvoiceUseCase.savePdf(invoice, pdf, filePath);
      }
    } else {
      final file = await _generateInvoiceUseCase.savePdf(invoice, pdf, null);
      await Share.shareXFiles([XFile(file.path)]);
    }
  }
}
