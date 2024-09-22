import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ambush_app/src/core/di/di.dart';
import 'package:ambush_app/src/core/settings/const.dart';
import 'package:ambush_app/src/core/utils/field_validators.dart';
import 'package:ambush_app/src/designsystem/inputfield.dart';
import 'package:ambush_app/src/presentation/settings/info_navigation_flow.dart';

import '../base_settings_page.dart';
import 'basic_info_viewmodel.dart';

@RoutePage()
class BasicInfoPage extends StatelessWidget {
  BasicInfoPage({super.key, this.flow, required this.screenConfig});

  final BasicInfoViewModel _viewModel = getIt();
  final BasicInfoPageConfig screenConfig;
  final InfoNavigationFlow? flow;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return BaseSettingsPage(
        title: "Contractor Information",
        infoText: "With your information as a contractor, fill the details below",
        buttonText: screenConfig.ctaText,
        onButtonPressed: () async {
          await onNextStepClick();
        },
        form: Form(
          key: _viewModel.formKey,
          child: Column(
            children: [
              InputField(
                label: "Full Name",
                helperText: "Your full name",
                textInputAction: TextInputAction.next,
                controller: _viewModel.fullNameController,
                validator: (String? value) {
                  var validation = requiredFieldValidator(value);
                  if(validation != null) {
                    return validation;
                  }

                  if(value!.toLowerCase().contains("ambush")) {
                    return "This should be your company name";
                  }

                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: marginBetweenFields),
              InputField(
                label: "Tax ID or CNPJ",
                helperText: "Contractor's company Tax ID or CNPJ number",
                textInputAction: TextInputAction.next,
                controller: _viewModel.cnpjController,
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
                label: "Company name",
                helperText: "Contractor's company name",
                textInputAction: TextInputAction.next,
                controller: _viewModel.compNameController,
                validator: (String? value) {
                  var validation = requiredFieldValidator(value);
                  if(validation != null) {
                    return validation;
                  }

                  if(value!.toLowerCase().contains("ambush")) {
                    return "This should be your company name";
                  }

                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: marginBetweenFields),
              InputField(
                label: "Company email",
                helperText: "Enter your company email",
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  var emailValidator = requiredEmailValidator(value);
                  if(emailValidator != null) {
                    return emailValidator;
                  }

                  if(value!.toLowerCase().contains("ap@ambush")) {
                    return "This should be your company email";
                  }

                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _viewModel.compEmailController,
              ),
            ],
          ),
        ),
      );
    });
  }

  Future onNextStepClick() async {
    if (_viewModel.formKey.currentState!.validate()) {
      await _viewModel.save();
      if (flow != null) {
        flow!.onNextPress();
      }
    }
  }
}
