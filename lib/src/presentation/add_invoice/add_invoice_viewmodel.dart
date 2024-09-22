import 'package:ambush_app/src/domain/usecases/get_bank_info.dart';
import 'package:ambush_app/src/domain/usecases/get_client_info.dart';
import 'package:ambush_app/src/domain/usecases/get_company_info.dart';
import 'package:ambush_app/src/domain/usecases/get_service_info.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:ambush_app/src/domain/models/invoice.dart';
import 'package:ambush_app/src/domain/usecases/get_next_id.dart';
import 'package:ambush_app/src/domain/usecases/save_invoice.dart';
import 'package:ambush_app/src/presentation/utils/share_invoice.dart';
import 'package:mobx/mobx.dart';

part 'add_invoice_viewmodel.g.dart';

@injectable
class AddInvoiceViewModel extends _AddInvoiceViewModelBase
    with _$AddInvoiceViewModel {
  AddInvoiceViewModel(
    super._saveInvoice,
    super._getNextId,
    super._shareInvoice,
    super._getClientInfo,
    super._getBankInfo,
    super._getCompanyInfo,
    super._getServiceInfo,
  );
}

abstract class _AddInvoiceViewModelBase with Store {
  final ISaveInvoice _saveInvoice;
  final IGetNextId _getNextId;
  final IShareInvoice _shareInvoice;
  final IGetClientInfo _getClientInfo;
  final IGetBankInfo _getBankInfo;
  final IGetCompanyInfo _getCompanyInfo;
  final IGetServiceInfo _getServiceInfo;

  _AddInvoiceViewModelBase(
    this._saveInvoice,
    this._getNextId,
    this._shareInvoice,
    this._getClientInfo,
    this._getBankInfo,
    this._getCompanyInfo,
    this._getServiceInfo,
  ) {
    var nextId = _getNextId.get();
    if (nextId != null) {
      idController.text = nextId.toString();
    }
  }

  final formKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final issueDateController = TextEditingController();
  final dueDateController = TextEditingController();

  DateTime? _issueDate;
  DateTime? _dueDate;

  void updateIssueDate(DateTime date) {
    _issueDate = date;
    issueDateController.text = _formatDate(date);
  }

  void updateDueDate(DateTime date) {
    _dueDate = date;
    dueDateController.text = _formatDate(date);
  }

  void updateDueDateWithNet15(DateTime date) {
    _dueDate = date.add(const Duration(days: 15));
    dueDateController.text = _formatDate(_dueDate!);
  }

  bool validateForm() => formKey.currentState!.validate();

  Invoice? getInvoice() {
    if (!_validateDates()) {
      return null;
    }

    var now = DateTime.now();
    return Invoice(
      int.parse(idController.text),
      _issueDate!.millisecondsSinceEpoch,
      _dueDate!.millisecondsSinceEpoch,
      _getServiceInfo.get()!,
      _getCompanyInfo.get()!,
      _getClientInfo.get(),
      _getBankInfo.get()!,
      now.millisecondsSinceEpoch,
      now.millisecondsSinceEpoch,
    );
  }

  Future<bool> saveInvoice(Invoice invoice) async {
    await _saveInvoice.save(invoice);
    await _shareInvoice.share(invoice);
    return true;
  }

  String _formatDate(DateTime date) => DateFormat('MM/dd/yyyy').format(date);

  bool _validateDates() {
    if (_issueDate == null || _dueDate == null) {
      return false;
    }

    if (!isDueDateValid()) {
      return false;
    }

    return true;
  }

  bool isDueDateValid() =>
      _dueDate!.isAfter(_issueDate!) || _dueDate!.isAtSameMomentAs(_issueDate!);
}
