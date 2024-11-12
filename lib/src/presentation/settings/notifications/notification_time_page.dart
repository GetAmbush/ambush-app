import 'package:ambush_app/src/core/di/di.dart';
import 'package:ambush_app/src/core/settings/const.dart';
import 'package:ambush_app/src/presentation/settings/base_settings_page.dart';
import 'package:ambush_app/src/presentation/settings/info_navigation_flow.dart';
import 'package:ambush_app/src/presentation/settings/notifications/notification_time_viewmodel.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../designsystem/inputfield.dart';

@RoutePage()
class NotificationTimePage extends StatelessWidget {
  NotificationTimePage(
      {super.key, required this.flow, required this.screenConfig});

  final NotificationTimeViewModel _viewModel = getIt();
  final _formKey = GlobalKey<FormState>();
  final BasicInfoPageConfig screenConfig;
  final InfoNavigationFlow? flow;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return BaseSettingsPage(
          title: "Notification time",
          infoText:
              "You can set a time to receive monthly notifications to send your invoice",
          buttonText: screenConfig.ctaText,
          onButtonPressed: () {},
          form: Form(
              key: _formKey,
              child: Column(
                children: [
                  InputField(
                    label: "Day",
                    helperText:
                        "The day of the month you want to receive the notification",
                    controller: _viewModel.dayController,
                  ),
                  const SizedBox(
                    height: marginBetweenFields,
                  ),
                  InputField(
                    label: "Hour",
                    helperText:
                        "The hour of the day you want to receive the notification",
                    controller: _viewModel.hourController,
                  ),
                  const SizedBox(
                    height: marginBetweenFields,
                  ),
                  InputField(
                    label: "Minute",
                    helperText:
                        "The exact minute you want to receive the notification",
                    controller: _viewModel.minuteController,
                  ),
                ],
              )));
    });
  }
}
