import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:invoice_app/src/domain/models/currency.dart';
import 'package:invoice_app/src/domain/usecases/get_service_info.dart';
import 'package:invoice_app/src/domain/usecases/save_service_info.dart';
import 'package:invoice_app/src/domain/models/service_info.dart';
import 'package:mobx/mobx.dart';

part 'service_info_viewmodel.g.dart';

@injectable
class ServiceInfoViewModel extends _ServiceInfoViewModelBase
    with _$ServiceInfoViewModel {
  ServiceInfoViewModel(super._getServiceInfo, super._saveServiceInfo);
}

abstract class _ServiceInfoViewModelBase with Store {
  final IGetServiceInfo _getServiceInfo;
  final ISaveServiceInfo _saveServiceInfo;

  _ServiceInfoViewModelBase(this._getServiceInfo, this._saveServiceInfo) {
    var initialInfo = _getServiceInfo.get();
    if (initialInfo != null) {
      selectedCurrency = initialInfo.currency;
      currencyController.text = initialInfo.currency.cc;
      descriptionController.text = initialInfo.description;
      quantityController.text = initialInfo.quantity.toString();
      priceController.text = initialInfo.price.toString();
    }
  }

  Currency? selectedCurrency;
  final formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final quantityController = TextEditingController();
  final currencyController = TextEditingController();
  final priceController = TextEditingController();

  @observable
  bool switchValue = true;

  @action
  void onSwitchClicked(bool value) {
    switchValue = value;
  }

  void setSelectedCurrency(Currency selected) {
    selectedCurrency = selected;
    currencyController.text = selected.cc;
  }

  Future saveInfo() async {
    var quantity = double.tryParse(quantityController.text);
    var price = double.tryParse(priceController.text);

    if (quantity == null || price == null || selectedCurrency == null) {
      //Treat error
      return;
    }

    var info = ServiceInfo(
      descriptionController.text,
      quantity,
      selectedCurrency!,
      price,
    );

    await _saveServiceInfo.save(info);
  }
}