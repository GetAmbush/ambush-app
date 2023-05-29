import 'package:invoice_app/src/core/domain/data_models/bank_info.dart';
import 'package:invoice_app/src/core/domain/data_models/client_info.dart';
import 'package:invoice_app/src/core/domain/data_models/comp_info.dart';
import 'package:invoice_app/src/core/domain/data_models/service_info.dart';

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
}