import 'package:ambush_app/src/data/models/hive_bank_info.dart';
import 'package:ambush_app/src/data/models/hive_client_info.dart';
import 'package:ambush_app/src/data/models/hive_company_info.dart';
import 'package:ambush_app/src/data/models/hive_invoice.dart';
import 'package:ambush_app/src/data/models/hive_invoice_list.dart';
import 'package:ambush_app/src/data/models/hive_service_info.dart';
import 'package:hive/hive.dart';

part 'hive_application_data.g.dart';

@HiveType(typeId: 8)
class HiveApplicationData extends HiveObject {
  @HiveField(0)
  HiveClientInfo? clientInfo;

  @HiveField(1)
  HiveServiceInfo? serviceInfo;

  @HiveField(2)
  HiveBankInfo? bankInfo;

  @HiveField(3)
  HiveCompanyInfo? companyInfo;

  @HiveField(4)
  List<HiveInvoice> invoiceList;

  HiveApplicationData(this.clientInfo, this.serviceInfo, this.bankInfo,
      this.companyInfo, this.invoiceList);
}
