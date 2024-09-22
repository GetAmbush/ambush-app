import 'package:ambush_app/src/domain/models/comp_info.dart';
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

  _AddressViewModelBase(this._getCompanyInfo, this._saveCompanyInfo) {
    var info = _getCompanyInfo.get();
    var address = info?.address;

    if(address != null) {
      streetAddressController.text = address.street;
      addressExtraController.text = address.extraInfo ?? '';
      neighbourhoodController.text = address.neighbourhood;
      cityController.text = address.city;
      stateController.text = address.state;
      countryController.text = address.country;
      zipController.text = address.zipCode;
    }
  }

  final formKey = GlobalKey<FormState>();
  final streetAddressController = TextEditingController();
  final addressExtraController = TextEditingController();
  final neighbourhoodController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final zipController = TextEditingController();

  Future save() async {
    var info = _getCompanyInfo.get()!;
    var newInfo = info.copyWith(
      address: CompanyAddress(
        streetAddressController.text,
        addressExtraController.text,
        neighbourhoodController.text,
        cityController.text,
        stateController.text,
        countryController.text,
        zipController.text,
      ),
    );
    await _saveCompanyInfo.save(newInfo);
  }
}
