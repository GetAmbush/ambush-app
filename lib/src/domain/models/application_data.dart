import 'package:ambush_app/src/domain/models/bank_info.dart';
import 'package:ambush_app/src/domain/models/client_info.dart';
import 'package:ambush_app/src/domain/models/comp_info.dart';
import 'package:ambush_app/src/domain/models/invoice.dart';
import 'package:ambush_app/src/domain/models/service_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'application_data.g.dart';

@JsonSerializable()
class ApplicationData {
  ServiceInfo? serviceInfo;
  BankInfo? bankInfo;
  CompanyInfo? companyInfo;
  ClientInfo? clientInfo;
  List<Invoice>? invoiceList;

  ApplicationData(this.serviceInfo, this.bankInfo, this.companyInfo,
      this.clientInfo, this.invoiceList);

  factory ApplicationData.fromJson(Map<String, dynamic> json) =>
      _$ApplicationDataFromJson(json);
  Map<String, dynamic> toJson() => _$ApplicationDataToJson(this);
}
