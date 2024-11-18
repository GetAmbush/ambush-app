import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ambush_app/src/core/di/di.dart';
import 'package:ambush_app/src/core/settings/const.dart';
import 'package:ambush_app/src/core/utils/field_validators.dart';
import 'package:ambush_app/src/designsystem/inputfield.dart';
import 'package:ambush_app/src/presentation/settings/info_navigation_flow.dart';
import '../base_settings_page.dart';
import 'service_info_viewmodel.dart';

@RoutePage()
class ServiceInfoPage extends StatelessWidget {
  ServiceInfoPage({
    super.key,
    this.flow,
    required this.screenConfig,
  });

  final ServiceInfoViewModel _viewModel = getIt();
  final _formKey = GlobalKey<FormState>();
  final BasicInfoPageConfig screenConfig;
  final InfoNavigationFlow? flow;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return BaseSettingsPage(
          title: "Service information",
          infoText:
              "Describe the service your company provides. We want to know the details of what you and your company offer. Remember, this is about the service your company delivers.",
          onButtonPressed: () async {
            await _onNextClick();
          },
          buttonText: screenConfig.ctaText,
          form: Form(
            key: _formKey,
            child: Column(
              children: [
                InputField(
                  label: "Job description",
                  hintText: "e.g. Software Development",
                  helperText: "Enter the job description",
                  controller: _viewModel.descriptionController,
                  validator: requiredFieldValidator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: marginBetweenFields),
                InputField(
                  label: "Quantity",
                  hintText: "e.g. 1.00",
                  helperText: "One month worked represents 1.0",
                  controller: _viewModel.quantityController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null) {
                      return 'Required field';
                    }

                    if (double.tryParse(value) == 0.0) {
                      return 'Quantity needs to be more than 0';
                    }

                    if (double.tryParse(value) == null) {
                      return 'Quantity needs to have the format 0.00';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: marginBetweenFields),
                InputField(
                  label: "Unit price",
                  helperText:
                      "Enter the value of a unit of work charged on the invoice",
                  hintText: "e.g. 5000.00",
                  controller: _viewModel.priceController,
                  validator: (value) {
                    if (value == null || value.isEmpty || value == '\$0,00') {
                      return "Mandatory field";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: marginBetweenFields),
              ],
            ),
          ),
        );
      },
    );
  }

  Future _onNextClick() async {
    if (_formKey.currentState!.validate()) {
      await _viewModel.saveInfo();

      if (flow != null) {
        flow!.onNextPress();
      }
    }
  }
}
