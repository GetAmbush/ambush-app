import 'package:ambush_app/src/data/models/hive_bank_info.dart';
import 'package:ambush_app/src/data/models/hive_client_info.dart';
import 'package:ambush_app/src/data/models/hive_company_info.dart';
import 'package:ambush_app/src/data/models/hive_invoice.dart';
import 'package:ambush_app/src/data/models/hive_service_info.dart';
<<<<<<< HEAD
<<<<<<< HEAD
=======
import 'package:hive/hive.dart';
>>>>>>> 7254d6d (unit tests)
=======
>>>>>>> 5de88e6 (removed hive dependency from application data)
import 'package:json_annotation/json_annotation.dart';

part 'hive_application_data.g.dart';

<<<<<<< HEAD
<<<<<<< HEAD
@JsonSerializable()
class ApplicationData {
=======
@HiveType(typeId: 8)
@JsonSerializable()
class HiveApplicationData extends HiveObject {
  @HiveField(0)
>>>>>>> 7254d6d (unit tests)
=======
@JsonSerializable()
class ApplicationData {
>>>>>>> 5de88e6 (removed hive dependency from application data)
  HiveClientInfo? clientInfo;

  HiveServiceInfo? serviceInfo;

  HiveBankInfo? bankInfo;

  HiveCompanyInfo? companyInfo;

  List<HiveInvoice> invoiceList;

  ApplicationData(this.clientInfo, this.serviceInfo, this.bankInfo,
      this.companyInfo, this.invoiceList);

<<<<<<< HEAD
<<<<<<< HEAD
  factory ApplicationData.fromJson(Map<String, dynamic> json) =>
      _$ApplicationDataFromJson(json);
  Map<String, dynamic> toJson() => _$ApplicationDataToJson(this);
=======
  factory HiveApplicationData.fromJson(Map<String, dynamic> json) =>
      _$HiveApplicationDataFromJson(json);
  Map<String, dynamic> toJson() => _$HiveApplicationDataToJson(this);
>>>>>>> 7254d6d (unit tests)
=======
  factory ApplicationData.fromJson(Map<String, dynamic> json) =>
      _$ApplicationDataFromJson(json);
  Map<String, dynamic> toJson() => _$ApplicationDataToJson(this);
>>>>>>> 5de88e6 (removed hive dependency from application data)
}
