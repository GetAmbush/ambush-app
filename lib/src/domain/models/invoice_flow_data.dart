import 'package:ambush_app/src/domain/models/bank_info.dart';
import 'package:ambush_app/src/domain/models/client_info.dart';
import 'package:ambush_app/src/domain/models/comp_info.dart';
import 'package:ambush_app/src/domain/models/service_info.dart';
import 'package:injectable/injectable.dart';

// Validate the saved information.
@lazySingleton
class InvoiceFlowData {
  void validateData(
    ServiceInfo? service,
    CompanyInfo? companyInfo,
    ClientInfo? clientInfo,
    BankInfo? bankInfo,
  ) {
    if (service == null) {
      throw Exception("Service info is null");
    }
    if (companyInfo == null) {
      throw Exception("Company info is null");
    } else if (companyInfo.ownerName.isEmpty) {
      throw Exception("Needs to provide the owner name");
    }
    if (clientInfo == null) {
      throw Exception("Client info is null");
    }
    if (bankInfo == null) {
      throw Exception("Bank info is null");
    }
  }
}
