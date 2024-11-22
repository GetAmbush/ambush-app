import 'package:ambush_app/src/data/models/hive_bank_info.dart';
import 'package:ambush_app/src/data/models/hive_client_info.dart';
import 'package:ambush_app/src/data/models/hive_company_info.dart';
import 'package:ambush_app/src/data/models/hive_invoice.dart';
import 'package:ambush_app/src/data/models/hive_service_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'application_data.g.dart';

@JsonSerializable()
class ApplicationData {
  HiveClientInfo? clientInfo;

  HiveServiceInfo? serviceInfo;

  HiveBankInfo? bankInfo;

  HiveCompanyInfo? companyInfo;

  List<HiveInvoice> invoiceList;

  ApplicationData(this.clientInfo, this.serviceInfo, this.bankInfo,
      this.companyInfo, this.invoiceList);

  factory ApplicationData.fromJson(Map<String, dynamic> json) =>
      _$ApplicationDataFromJson(json);
  Map<String, dynamic> toJson() => _$ApplicationDataToJson(this);
}
