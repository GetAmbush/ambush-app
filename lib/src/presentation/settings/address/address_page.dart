import 'package:ambush_app/src/core/di/di.dart';
import 'package:ambush_app/src/core/utils/field_validators.dart';
import 'package:ambush_app/src/designsystem/inputfield.dart';
import 'package:ambush_app/src/presentation/settings/address/address_viewmodel.dart';
import 'package:ambush_app/src/presentation/settings/base_settings_page.dart';
import 'package:ambush_app/src/presentation/settings/info_navigation_flow.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

@RoutePage()
class AddressPage extends StatelessWidget {
  AddressPage({super.key, required this.screenConfig, this.flow});

  final AddressViewModel _viewModel = getIt();
  final BasicInfoPageConfig screenConfig;
  final InfoNavigationFlow? flow;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return BaseSettingsPage(
          title: "Company Address",
          infoText:
              "With your information as a contractor, fill the details below",
          buttonText: screenConfig.ctaText,
          saveSwitch: screenConfig.showSaveSwitch
              ? SaveSwitch(
                  value: _viewModel.switchValue,
                  onChanged: _viewModel.onSwitchClicked,
                )
              : null,
          onButtonPressed: () async {
            await onNextStepClick();
          },
          form: Form(
            key: _viewModel.formKey,
            child: Column(
              children: [
                InputField(
                  label: "Street Address",
                  helperText: "Street name and number",
                  textInputAction: TextInputAction.next,
                  controller: _viewModel.streetAddressController,
                  validator: (String? value) {
                    var validation = requiredFieldValidator(value);
                    if(validation != null) {
                      return validation;
                    }

                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                InputField(
                  label: "Apt, suite, etc (optional)",
                  helperText: "Ex: apt 32",
                  textInputAction: TextInputAction.next,
                  controller: _viewModel.addressExtraController,
                ),
                InputField(
                  label: "Neighbourhood",
                  textInputAction: TextInputAction.next,
                  controller: _viewModel.neighbourhoodController,
                  validator: (String? value) {
                    var validation = requiredFieldValidator(value);
                    if(validation != null) {
                      return validation;
                    }

                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                InputField(
                  label: "City",
                  textInputAction: TextInputAction.next,
                  controller: _viewModel.cityController,
                  validator: (String? value) {
                    var validation = requiredFieldValidator(value);
                    if(validation != null) {
                      return validation;
                    }

                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                InputField(
                  label: "State",
                  textInputAction: TextInputAction.next,
                  controller: _viewModel.stateController,
                  validator: (String? value) {
                    var validation = requiredFieldValidator(value);
                    if(validation != null) {
                      return validation;
                    }

                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                InputField(
                  label: "Country",
                  textInputAction: TextInputAction.next,
                  controller: _viewModel.countryController,
                  validator: (String? value) {
                    var validation = requiredFieldValidator(value);
                    if(validation != null) {
                      return validation;
                    }

                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                InputField(
                  label: "Zip code",
                  hintText: "Ex: 90110090",
                  textInputAction: TextInputAction.next,
                  controller: _viewModel.zipController,
                  validator: (String? value) {
                    var validation = requiredFieldValidator(value);
                    if(validation != null) {
                      return validation;
                    }

                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future onNextStepClick() async {
    //TODO
    // if (_viewModel.formKey.currentState!.validate()) {
    //   final companyInfo = _viewModel.companyInfo;
    //   if (_viewModel.switchValue || screenConfig.alwaysSave) {
    //     await _viewModel.save(companyInfo);
    //   }
    //
    //   if (flow != null) {
    //     if (flow is AddInvoiceNavigationFlow) {
    //       (flow as AddInvoiceNavigationFlow).invoiceFlowData.companyInfo =
    //           companyInfo;
    //     }
    //
    //     flow!.onNextPress();
    //   }
    // }
  }

}