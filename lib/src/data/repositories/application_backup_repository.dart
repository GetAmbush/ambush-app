import 'dart:convert';

import 'package:ambush_app/src/core/settings/const.dart';
import 'package:ambush_app/src/data/datasource/local_datasource.dart';
import 'package:ambush_app/src/data/models/hive_application_data.dart';
import 'package:ambush_app/src/data/models/hive_invoice.dart';
import 'package:ambush_app/src/presentation/utils/backup_error.dart';
import 'package:injectable/injectable.dart';

abstract class IApplicationBackupRepository {
  String get();
  Future<void> restore(String backup);
}

@Injectable(as: IApplicationBackupRepository)
class ApplicationBackupRepository implements IApplicationBackupRepository {
  final ILocalDataSource _localDataSource;

  ApplicationBackupRepository(this._localDataSource);

  @override
  String get() {
    final applicationData = ApplicationData(
        _localDataSource.getClientInfo(),
        _localDataSource.getServiceInfo(),
        _localDataSource.getBankInfo(),
        _localDataSource.getCompanyInfo(),
        _localDataSource
            .getInvoiceList()
            .map((e) => HiveInvoice.fromInvoice(e))
            .toList());
    try {
      final backup = jsonEncode(applicationData);
      return backup;
    } catch (_) {
      throw BackupError(formatErrorMessage);
    }
  }

  @override
  Future<void> restore(String backup) async {
    try {
      final Map<String, dynamic> json = jsonDecode(backup);
      final applicationData = ApplicationData.fromJson(json);
      final clientInfo = applicationData.clientInfo;
      final serviceInfo = applicationData.serviceInfo;
      final bankInfo = applicationData.bankInfo;
      final companyInfo = applicationData.companyInfo;
      final invoiceList = applicationData.invoiceList;

      await _localDataSource.clearDB();

      if (clientInfo != null) {
        await _localDataSource.saveClientInfo(clientInfo);
      }
      if (serviceInfo != null) {
        await _localDataSource.saveServiceInfo(serviceInfo);
      }
      if (bankInfo != null) {
        await _localDataSource.saveBankInfo(bankInfo);
      }
      if (companyInfo != null) {
        await _localDataSource.saveCompanyInfo(companyInfo);
      }
      for (var invoice in invoiceList) {
        _localDataSource.saveInvoice(invoice.toInvoice());
      }
    } catch (_) {
      throw BackupError(formatErrorMessage);
    }
  }
}
