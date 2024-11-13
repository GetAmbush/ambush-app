import 'package:hive/hive.dart';
import 'package:ambush_app/src/domain/models/bank_info.dart';
import 'package:ambush_app/src/domain/models/client_info.dart';
import 'package:ambush_app/src/domain/models/comp_info.dart';
import 'package:ambush_app/src/domain/models/invoice.dart';
import 'package:ambush_app/src/domain/models/service_info.dart';

import 'hive_bank_info.dart';
import 'hive_client_info.dart';
import 'hive_company_info.dart';
import 'hive_service_info.dart';

part 'hive_invoice.g.dart';

const _keyId = 'id';
const _keyIssueDate = 'issue_date';
const _keyDueDate = 'due_date';
const _keyCreatedAt = 'created_at';
const _keyUpdatedAt = 'updated_at';
const _keyServiceInfo = 'service_info';
const _keyBankInfo = 'bank_info';
const _keyCompanyInfo = 'company_info';
const _keyClientInfo = 'client_info';

@HiveType(typeId: 5)
class HiveInvoice extends HiveObject {
  // Invoice basic info
  @HiveField(0)
  int id;

  @HiveField(1)
  int issueDate;

  @HiveField(2)
  int dueDate;

  @HiveField(3)
  int createdAt;

  @HiveField(4)
  int updatedAt;

  // Service info
  @HiveField(5)
  HiveServiceInfo serviceInfo;

  //My info
  @HiveField(6)
  HiveCompanyInfo companyInfo;

  //Client Info
  @HiveField(7)
  HiveClientInfo clientInfo;

  //Bank Info
  @HiveField(8)
  HiveBankInfo bankInfo;

  HiveInvoice(
    this.id,
    this.issueDate,
    this.dueDate,
    this.createdAt,
    this.updatedAt,
    this.serviceInfo,
    this.companyInfo,
    this.clientInfo,
    this.bankInfo,
  );

  factory HiveInvoice.newInvoice(
    int id,
    int issueDate,
    int dueDate,
    ServiceInfo serviceInfo,
    CompanyInfo companyInfo,
    ClientInfo clientInfo,
    BankInfo bankInfo,
  ) {
    var now = DateTime.now();

    return HiveInvoice(
      id,
      issueDate,
      dueDate,
      now.millisecondsSinceEpoch,
      now.millisecondsSinceEpoch,
      HiveServiceInfo.fromServiceInfo(serviceInfo),
      HiveCompanyInfo.fromDomainModel(companyInfo),
      HiveClientInfo.from(clientInfo),
      HiveBankInfo.fromDataModel(bankInfo),
    );
  }

  factory HiveInvoice.fromInvoice(Invoice invoice) => HiveInvoice(
        invoice.id,
        invoice.issueDate,
        invoice.dueDate,
        invoice.createdAt,
        invoice.updatedAt,
        HiveServiceInfo.fromServiceInfo(invoice.service),
        HiveCompanyInfo.fromDomainModel(invoice.companyInfo),
        HiveClientInfo.from(invoice.clientInfo),
        HiveBankInfo.fromDataModel(invoice.bankInfo),
      );

  Invoice toInvoice() => Invoice(
        id,
        issueDate,
        dueDate,
        serviceInfo.toServiceInfo(),
        companyInfo.toDomainModel(),
        clientInfo.toClientInfo(),
        bankInfo.toDataModel(),
        createdAt,
        updatedAt,
      );

  Map<String, dynamic> toJson() => {
        _keyId: id,
        _keyIssueDate: issueDate,
        _keyDueDate: dueDate,
        _keyServiceInfo: serviceInfo.toJson(),
        _keyCompanyInfo: companyInfo.toJson(),
        _keyClientInfo: clientInfo.toJson(),
        _keyCreatedAt: createdAt,
        _keyUpdatedAt: updatedAt,
      };

  factory HiveInvoice.fromJson(Map<String, dynamic> json) => HiveInvoice(
      json[_keyId] as int,
      json[_keyIssueDate] as int,
      json[_keyDueDate] as int,
      json[_keyCreatedAt] as int,
      json[_keyUpdatedAt] as int,
      HiveServiceInfo.fromJson(json[_keyServiceInfo] as Map<String, dynamic>),
      HiveCompanyInfo.fromJson(json[_keyCompanyInfo] as Map<String, dynamic>),
      HiveClientInfo.fromJson(json[_keyClientInfo] as Map<String, dynamic>),
      HiveBankInfo.fromJson(json[_keyBankInfo] as Map<String, dynamic>));
}
