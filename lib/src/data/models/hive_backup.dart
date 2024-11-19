import 'package:ambush_app/src/data/models/hive_bank_info.dart';
import 'package:ambush_app/src/data/models/hive_client_info.dart';
import 'package:ambush_app/src/data/models/hive_company_info.dart';
import 'package:ambush_app/src/data/models/hive_invoice_list.dart';
import 'package:ambush_app/src/data/models/hive_service_info.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hive_backup.g.dart';

@HiveType(typeId: 8)
@JsonSerializable()
class HiveBackup extends HiveObject {
  @HiveField(0)
  HiveBankInfo? bankInfo;

  @HiveField(1)
  HiveClientInfo? clientInfo;

  @HiveField(2)
  HiveCompanyInfo? companyInfo;

  @HiveField(3)
  HiveInvoiceList? invoiceList;

  @HiveField(4)
  HiveServiceInfo? serviceInfo;

  HiveBackup(this.bankInfo, this.clientInfo, this.companyInfo, this.invoiceList,
      this.serviceInfo);

  factory HiveBackup.fromJson(Map<String, dynamic> json) =>
      _$HiveBackupFromJson(json);
  Map<String, dynamic> toJson() => _$HiveBackupToJson(this);
}
