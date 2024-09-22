import 'package:injectable/injectable.dart';
import 'package:ambush_app/src/data/repositories/pdf_widgets.dart';
import 'package:ambush_app/src/domain/models/invoice.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

abstract class IPdfTemplateRepo {
  pw.Document getDocument(Invoice invoice);
}

@Injectable(as: IPdfTemplateRepo)
class PdfTemplateRepo implements IPdfTemplateRepo {
  final PdfWidgets _pdfWidgets = PdfWidgets();

  @override
  pw.Document getDocument(Invoice invoice) {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              _getFirstRow(invoice),
              pw.SizedBox(height: 16),
              _getSecondRow(invoice),
              pw.SizedBox(height: 50),
              _getServiceRow(invoice),
              pw.SizedBox(height: 16),
              _getTotalAmountRow(invoice),
              pw.SizedBox(height: 30),
              pw.Divider(color: PdfColors.grey400, thickness: 1),
              pw.SizedBox(height: 30),
              _getBankRow(invoice),
              if (invoice.bankInfo.intermediary != null) ...[
                pw.SizedBox(height: 4),
                _getIntermediaryBankRow(invoice),
              ],
            ],
          );
        },
      ),
    ); // Page

    return pdf;
  }

  pw.Widget _getFirstRow(Invoice invoice) => pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Flexible(
            child: _pdfWidgets.getTitle(invoice),
          ),
          pw.Flexible(
            child: _pdfWidgets.getCompanyBlock(
              "From",
              invoice.companyInfo.name,
              invoice.formattedAddress(),
              invoice.companyInfo.email,
            ),
          ),
        ],
      );

  pw.Widget _getSecondRow(Invoice invoice) => pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Flexible(
            child: _pdfWidgets.getDatesBlock(invoice),
          ),
          pw.Flexible(
            child: _pdfWidgets.getCompanyBlock(
              "Invoice For",
              invoice.clientInfo.name,
              invoice.clientInfo.address,
              "",
            ),
          ),
        ],
      );

  pw.Widget _getTotalAmountRow(Invoice invoice) => pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.end,
        children: [
          pw.Text(
            "Amount Due: ",
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(width: 20),
          pw.Text(
            invoice.formattedTotalPrice(invoice.service.currency.symbol),
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ],
      );

  pw.Widget _getServiceRow(Invoice invoice) => pw.Table(
        border: const pw.TableBorder(
          horizontalInside: pw.BorderSide(
            color: PdfColors.grey400,
            width: .5,
          ),
          verticalInside: pw.BorderSide(
            color: PdfColors.grey400,
            width: .5,
          ),
        ),
        children: [
          pw.TableRow(
            children: [
              _pdfWidgets.getServiceLabel("Service Description"),
              _pdfWidgets.getServiceLabel("Quantity"),
              _pdfWidgets.getServiceLabel("Unit Price"),
              _pdfWidgets.getServiceLabel("Amount"),
            ],
          ),
          pw.TableRow(
            children: [
              _pdfWidgets.getServiceText(
                invoice.service.description,
              ),
              _pdfWidgets.getServiceText(
                invoice.formattedQuantity(),
              ),
              _pdfWidgets.getServiceText(
                invoice.formattedPrice(invoice.service.currency.symbol),
              ),
              _pdfWidgets.getServiceText(
                invoice.formattedTotalPrice(invoice.service.currency.symbol),
              ),
            ],
          ),
        ],
      );

  pw.Widget _getBankRow(Invoice invoice) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          pw.Text(
            "Pay to banking details below:",
            style: pw.TextStyle(
              fontSize: 8,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 4),
          _pdfWidgets.getBankRow(
              "Contractor's full name:", invoice.companyInfo.ownerName),
          if (invoice.companyInfo.cnpj != null &&
              invoice.companyInfo.cnpj!.isNotEmpty)
            _pdfWidgets.getBankRow("CNPJ:", invoice.companyInfo.cnpj!),
          _pdfWidgets.getBankRow(
              "Beneficiary name:", invoice.bankInfo.beneficiaryName),
          _pdfWidgets.getBankRow(
              "Beneficiary Account Number (IBAN):", invoice.bankInfo.main.iban),
          _pdfWidgets.getBankRow("SWIFT Code:", invoice.bankInfo.main.swift),
          _pdfWidgets.getBankRow("Bank Name:", invoice.bankInfo.main.bankName),
          _pdfWidgets.getBankRow(
              "Bank Address:", invoice.bankInfo.main.bankAddress),
        ],
      );

  pw.Widget _getIntermediaryBankRow(Invoice invoice) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          pw.Text(
            "Intermediary bank details:",
            style: const pw.TextStyle(fontSize: 8),
          ),
          pw.SizedBox(height: 4),
          _pdfWidgets.getBankRow(
              "Account Number:", invoice.bankInfo.intermediary!.iban),
          _pdfWidgets.getBankRow(
              "SWIFT Code:", invoice.bankInfo.intermediary!.swift),
          _pdfWidgets.getBankRow(
              "Bank Name:", invoice.bankInfo.intermediary!.bankName),
          _pdfWidgets.getBankRow(
              "Bank Address:", invoice.bankInfo.intermediary!.bankAddress),
        ],
      );
}
