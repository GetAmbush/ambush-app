import 'package:ambush_app/src/data/models/hive_bank_info.dart';
import 'package:ambush_app/src/data/models/hive_client_info.dart';
import 'package:ambush_app/src/data/models/hive_company_info.dart';
import 'package:ambush_app/src/data/models/hive_invoice.dart';
import 'package:ambush_app/src/data/models/hive_service_info.dart';
<<<<<<< HEAD
=======
import 'package:hive/hive.dart';
>>>>>>> 7254d6d (unit tests)
import 'package:json_annotation/json_annotation.dart';

part 'hive_application_data.g.dart';

<<<<<<< HEAD
@JsonSerializable()
class ApplicationData {
=======
@HiveType(typeId: 8)
@JsonSerializable()
class HiveApplicationData extends HiveObject {
  @HiveField(0)
>>>>>>> 7254d6d (unit tests)
  HiveClientInfo? clientInfo;

  HiveServiceInfo? serviceInfo;

  HiveBankInfo? bankInfo;

  HiveCompanyInfo? companyInfo;

  List<HiveInvoice> invoiceList;

  ApplicationData(this.clientInfo, this.serviceInfo, this.bankInfo,
      this.companyInfo, this.invoiceList);

<<<<<<< HEAD
  factory ApplicationData.fromJson(Map<String, dynamic> json) =>
      _$ApplicationDataFromJson(json);
  Map<String, dynamic> toJson() => _$ApplicationDataToJson(this);
=======
  factory HiveApplicationData.fromJson(Map<String, dynamic> json) =>
      _$HiveApplicationDataFromJson(json);
  Map<String, dynamic> toJson() => _$HiveApplicationDataToJson(this);
>>>>>>> 7254d6d (unit tests)
}
