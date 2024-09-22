import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ambush_app/src/core/di/di.dart';
import 'package:ambush_app/src/core/settings/const.dart';
import 'package:ambush_app/src/core/utils/field_validators.dart';
import 'package:ambush_app/src/designsystem/inputfield.dart';
import 'package:ambush_app/src/presentation/settings/info_navigation_flow.dart';

import '../base_settings_page.dart';
import 'client_info_viewmodel.dart';

@RoutePage()
class ClientInfoPage extends StatelessWidget {
  ClientInfoPage({super.key, required this.flow, required this.screenConfig});

  final ClientInfoViewModel _viewModel = getIt();
  final _formKey = GlobalKey<FormState>();
  final BasicInfoPageConfig screenConfig;
  final InfoNavigationFlow? flow;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return BaseSettingsPage(
          title: "Client information",
          infoText: "Fill the information using the client's company data",
          key: _formKey,
          onButtonPressed: () async {
            await _onNextStepClick();
          },
          buttonText: screenConfig.ctaText,
          form: Form(
            key: _formKey,
            child: Column(
              children: [
                InputField(
                  label: "Client name",
                  helperText: "The name of the client's company",
                  controller: _viewModel.nameController,
                  textInputAction: TextInputAction.next,
                  validator: requiredFieldValidator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: marginBetweenFields),
                InputField(
                  label: "Client address",
                  helperText: "The full address of the client's company",
                  controller: _viewModel.addressController,
                  textInputAction: TextInputAction.done,
                  maxLines: null,
                  minLines: null,
                  validator: requiredFieldValidator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future _onNextStepClick() async {
    if (_formKey.currentState!.validate()) {
      await _viewModel.saveInfo();
      if (flow != null) {
        flow!.onNextPress();
      }
    }
  }
}
