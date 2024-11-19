import 'package:ambush_app/src/domain/models/backup_data.dart';
import 'package:injectable/injectable.dart';
import 'package:ambush_app/src/domain/usecases/get_bank_info.dart';
import 'package:ambush_app/src/domain/usecases/get_client_info.dart';
import 'package:ambush_app/src/domain/usecases/get_company_info.dart';
import 'package:ambush_app/src/domain/usecases/get_invoice_list.dart';
import 'package:ambush_app/src/domain/usecases/get_service_info.dart';
import 'package:ambush_app/src/domain/usecases/save_bank_info.dart';
import 'package:ambush_app/src/domain/usecases/save_client_info.dart';
import 'package:ambush_app/src/domain/usecases/save_company_info.dart';
import 'package:ambush_app/src/domain/usecases/save_invoice.dart';
import 'package:ambush_app/src/domain/usecases/save_service_info.dart';

abstract class IApplicationPersistency {
  ApplicationData get();
  Future<void> save(ApplicationData backupData);
}

@Injectable(as: IApplicationPersistency)
class ApplicationPersistency implements IApplicationPersistency {
  final ISaveCompanyInfo _saveCompanyInfo;
  final IGetCompanyInfo _getCompanyInfo;
  final ISaveBankInfo _saveBankInfo;
  final IGetBankInfo _getBankInfo;
  final ISaveClientInfo _saveClientInfo;
  final IGetClientInfo _getClientInfo;
  final ISaveServiceInfo _saveServiceInfo;
  final IGetServiceInfo _getServiceInfo;
  final ISaveInvoice _saveInvoice;
  final IGetInvoiceList _getInvoiceList;

  ApplicationPersistency(
      this._saveCompanyInfo,
      this._getCompanyInfo,
      this._saveBankInfo,
      this._getBankInfo,
      this._saveClientInfo,
      this._getClientInfo,
      this._saveServiceInfo,
      this._getServiceInfo,
      this._getInvoiceList,
      this._saveInvoice);

  @override
  ApplicationData get() => ApplicationData(
      _getServiceInfo.get(),
      _getBankInfo.get(),
      _getCompanyInfo.get(),
      _getClientInfo.get(),
      _getInvoiceList.get());

  @override
  Future<void> save(ApplicationData backupData) async {
    final companyInfo = backupData.companyInfo;
    final bankInfo = backupData.bankInfo;
    final clientInfo = backupData.clientInfo;
    final serviceInfo = backupData.serviceInfo;
    final invoiceList = backupData.invoiceList;

    if (companyInfo != null) await _saveCompanyInfo.save(companyInfo);
    if (bankInfo != null) await _saveBankInfo.save(bankInfo);
    if (clientInfo != null) await _saveClientInfo.save(clientInfo);
    if (serviceInfo != null) await _saveServiceInfo.save(serviceInfo);

    if (invoiceList != null) {
      for (var invoice in invoiceList) {
        await _saveInvoice.save(invoice);
      }
    }
  }
}
