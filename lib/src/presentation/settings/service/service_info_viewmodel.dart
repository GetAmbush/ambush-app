import 'package:ambush_app/src/domain/models/ambush_info.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:ambush_app/src/domain/usecases/get_service_info.dart';
import 'package:ambush_app/src/domain/usecases/save_service_info.dart';
import 'package:ambush_app/src/domain/models/service_info.dart';
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
      currencyController.text = initialInfo.currency.cc;
      descriptionController.text = initialInfo.description;
      quantityController.text = initialInfo.formattedQuantity();
      priceController.updateValue(initialInfo.price);
    }
  }

  final descriptionController = TextEditingController();
  final quantityController = TextEditingController();
  final currencyController = TextEditingController();
  final priceController = MoneyMaskedTextController(leftSymbol: '\$');

  @observable
  bool switchValue = true;

  @action
  void onSwitchClicked(bool value) {
    switchValue = value;
  }

  ServiceInfo? get _serviceInfo {
    double.tryParse(quantityController.text);

    var quantity = double.tryParse(quantityController.text);

    if (quantity == null) {
      return null;
    }

    var price = priceController.numberValue;

    if (quantity == 0.0 || price == 0.0) {
      //Treat error
      return null;
    }

    return ServiceInfo(
      descriptionController.text,
      quantity,
      defaultCurrency,
      price,
    );
  }

  Future saveInfo() async {
    if (_serviceInfo == null) {
      return;
    }
    await _saveServiceInfo.save(_serviceInfo!);
  }
}
