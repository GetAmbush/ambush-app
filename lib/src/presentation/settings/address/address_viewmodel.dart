import 'package:ambush_app/src/domain/usecases/get_company_info.dart';
import 'package:ambush_app/src/domain/usecases/save_company_info.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'address_viewmodel.g.dart';

@injectable
class AddressViewModel extends _AddressViewModelBase with _$AddressViewModel {
  AddressViewModel(
    super.getCompanyInfo,
    super.saveCompanyInfo,
  );
}

abstract class _AddressViewModelBase with Store {
  final IGetCompanyInfo _getCompanyInfo;
  final ISaveCompanyInfo _saveCompanyInfo;

  _AddressViewModelBase(this._getCompanyInfo, this._saveCompanyInfo) {}

  final formKey = GlobalKey<FormState>();
  final streetAddressController = TextEditingController();
  final addressExtraController = TextEditingController();
  final neighbourhoodController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final zipController = TextEditingController();

  @observable
  bool switchValue = true;

  @action
  void onSwitchClicked(bool value) {
    switchValue = value;
  }

}
