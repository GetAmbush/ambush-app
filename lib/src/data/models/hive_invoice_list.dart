import 'package:ambush_app/src/data/models/hive_bank_info.dart';
import 'package:ambush_app/src/data/models/hive_client_info.dart';
import 'package:ambush_app/src/data/models/hive_company_info.dart';
import 'package:ambush_app/src/data/models/hive_service_info.dart';
import 'package:ambush_app/src/domain/models/invoice.dart';
import 'package:hive/hive.dart';

import 'hive_invoice.dart';

part 'hive_invoice_list.g.dart';

const _keyInvoiceList = 'invoice_list';
const _keyId = 'id';
const _keyIssueDate = 'issue_date';
const _keyDueDate = 'due_date';
const _keyServiceInfo = 'service_info';
const _keyCompanyInfo = 'company_info';
const _keyBankInfo = 'bank_info';
const _keyClientInfo = 'client_info';
const _keyCreatedAt = 'created_at';
const _keyUpdatedAt = 'updated_at';

@HiveType(typeId: 6)
class HiveInvoiceList extends HiveObject {
  @HiveField(0)
  List<HiveInvoice> invoiceList;

  HiveInvoiceList(this.invoiceList);

  Map<String, dynamic> toJson() =>
      {_keyInvoiceList: invoiceList.map((value) => value.toJson()).toList()};

  factory HiveInvoiceList.fromJson(Map<String, dynamic> json) {
    final list = json[_keyInvoiceList] as List? ?? [];

    return HiveInvoiceList((list).map((elem) {
      final id = elem[_keyId] as int;
      final issueDate = elem[_keyIssueDate] as int;
      final dueDate = elem[_keyDueDate] as int;
      final createdAt = elem[_keyCreatedAt] as int;
      final updatedAt = elem[_keyUpdatedAt] as int;
      final serviceInfo = HiveServiceInfo.fromJson(
          elem[_keyServiceInfo] as Map<String, dynamic>);
      final companyInfo = HiveCompanyInfo.fromJson(
          elem[_keyCompanyInfo] as Map<String, dynamic>);
      final bankInfo =
          HiveBankInfo.fromJson(elem[_keyBankInfo] as Map<String, dynamic>);
      final clientInfo =
          HiveClientInfo.fromJson(elem[_keyClientInfo] as Map<String, dynamic>);
      return HiveInvoice(id, issueDate, dueDate, createdAt, updatedAt,
          serviceInfo, companyInfo, clientInfo, bankInfo);
    }).toList());
  }
}
