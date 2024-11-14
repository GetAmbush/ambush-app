import 'package:ambush_app/src/core/di/di.dart';
import 'package:ambush_app/src/core/settings/const.dart';
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
              "Now we need to know where your company is located. Please provide the business address of your company, not the company that hired you",
          buttonText: screenConfig.ctaText,
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
                const SizedBox(height: marginBetweenFields),
                InputField(
                  label: "Apt, suite, etc (optional)",
                  helperText: "Ex: apt 32",
                  textInputAction: TextInputAction.next,
                  controller: _viewModel.addressExtraController,
                ),
                const SizedBox(height: marginBetweenFields),
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
                const SizedBox(height: marginBetweenFields),
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
                const SizedBox(height: marginBetweenFields),
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
                const SizedBox(height: marginBetweenFields),
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
                const SizedBox(height: marginBetweenFields),
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
    if(_viewModel.formKey.currentState!.validate()) {
      await _viewModel.save();
      if (flow != null) {
        flow!.onNextPress();
      }
    }
  }

}
