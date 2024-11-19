import 'package:ambush_app/src/domain/models/bank_info.dart';
import 'package:ambush_app/src/domain/models/client_info.dart';
import 'package:ambush_app/src/domain/models/comp_info.dart';
import 'package:ambush_app/src/domain/models/invoice.dart';
import 'package:ambush_app/src/domain/models/service_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'backup_data.g.dart';

@JsonSerializable()
class BackupData {
  ServiceInfo? serviceInfo;
  BankInfo? bankInfo;
  CompanyInfo? companyInfo;
  ClientInfo? clientInfo;
  List<Invoice>? invoiceList;

  BackupData(this.serviceInfo, this.bankInfo, this.companyInfo, this.clientInfo,
      this.invoiceList);

  factory BackupData.fromJson(Map<String, dynamic> json) =>
      _$BackupDataFromJson(json);
  Map<String, dynamic> toJson() => _$BackupDataToJson(this);
}
