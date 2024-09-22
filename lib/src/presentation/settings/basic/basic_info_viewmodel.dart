import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:ambush_app/src/domain/models/comp_info.dart';
import 'package:ambush_app/src/domain/usecases/get_company_info.dart';
import 'package:ambush_app/src/domain/usecases/save_company_info.dart';
import 'package:mobx/mobx.dart';

part 'basic_info_viewmodel.g.dart';

@injectable
class BasicInfoViewModel extends _BasicInfoViewModelBase
    with _$BasicInfoViewModel {
  BasicInfoViewModel(
    super._getCompanyInfo,
    super._saveCompanyInfo,
  );
}

abstract class _BasicInfoViewModelBase with Store {
  final IGetCompanyInfo _getCompanyInfo;
  final ISaveCompanyInfo _saveCompanyInfo;

  _BasicInfoViewModelBase(
    this._getCompanyInfo,
    this._saveCompanyInfo,
  ) {
    var info = _getCompanyInfo.get();
    if (info != null) {
      compNameController.text = info.name;
      compEmailController.text = info.email;
      fullNameController.text = info.ownerName;
      cnpjController.text = info.cnpj ?? '';
    }
  }

  final formKey = GlobalKey<FormState>();
  final compNameController = TextEditingController();
  final compEmailController = TextEditingController();
  final fullNameController = TextEditingController();
  final cnpjController = TextEditingController();

  CompanyInfo get _companyInfo => CompanyInfo.withoutAddress(
      compNameController.text,
      compEmailController.text,
      fullNameController.text,
      cnpjController.text,
  );

  Future save() async {
    await _saveCompanyInfo.save(_companyInfo);
  }
}
