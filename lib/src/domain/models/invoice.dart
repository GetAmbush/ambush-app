import 'package:intl/intl.dart';
import 'package:ambush_app/src/domain/models/bank_info.dart';
import 'package:ambush_app/src/domain/models/client_info.dart';
import 'package:ambush_app/src/domain/models/comp_info.dart';
import 'package:ambush_app/src/domain/models/service_info.dart';

class Invoice {
  final int id;
  final int issueDate;
  final int dueDate;
  final ServiceInfo service;
  final CompanyInfo companyInfo;
  final ClientInfo clientInfo;
  final BankInfo bankInfo;
  final int createdAt;
  final int updatedAt;

  Invoice(
    this.id,
    this.issueDate,
    this.dueDate,
    this.service,
    this.companyInfo,
    this.clientInfo,
    this.bankInfo,
    this.createdAt,
    this.updatedAt,
  );

  String formattedQuantity() {
    return service.formattedQuantity();
  }

  String formattedPrice(String symbol) {
    return NumberFormat.currency(locale: 'en_US', symbol: symbol).format(service.price);
  }

  String formattedTotalPrice(String symbol) {
    final totalPrice = service.price * service.quantity;
    return NumberFormat.currency(locale: 'en_US', symbol: symbol).format(totalPrice);
  }

  String formattedAddress() {
    if (companyInfo.address == null) {
      return "no address";
    } else {
      var address = companyInfo.address!;
      return '''
${address.street}${address.extraInfo != null ? ' ${address.extraInfo}' : ''}
${address.neighbourhood}, ${address.city}
${address.state} - ${address.country}
Zip-code: ${address.zipCode}
''';
    }
  }

  Invoice copyWith({
    int? id,
    int? issueDate,
    int? dueDate,
    ServiceInfo? service,
    CompanyInfo? companyInfo,
    ClientInfo? clientInfo,
    BankInfo? bankInfo,
    int? createdAt,
    int? updatedAt,
  }) {
    return Invoice(
      id ?? this.id,
      issueDate ?? this.issueDate,
      dueDate ?? this.dueDate,
      service ?? this.service,
      companyInfo ?? this.companyInfo,
      clientInfo ?? this.clientInfo,
      bankInfo ?? this.bankInfo,
      createdAt ?? this.createdAt,
      updatedAt ?? this.updatedAt,
    );
  }
}
