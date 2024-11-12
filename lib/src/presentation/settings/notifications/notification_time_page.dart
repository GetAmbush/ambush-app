import 'package:ambush_app/src/core/di/di.dart';
import 'package:ambush_app/src/core/settings/const.dart';
import 'package:ambush_app/src/presentation/settings/base_settings_page.dart';
import 'package:ambush_app/src/presentation/settings/info_navigation_flow.dart';
import 'package:ambush_app/src/presentation/settings/notifications/notification_time_viewmodel.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../designsystem/inputfield.dart';

@RoutePage()
class NotificationTimePage extends StatelessWidget {
  NotificationTimePage(
      {super.key, required this.flow, required this.screenConfig});

  final NotificationTimeViewModel _viewModel = getIt();
  final _formKey = GlobalKey<FormState>();
  final BasicInfoPageConfig screenConfig;
  final InfoNavigationFlow? flow;

  Future<void> _showDayPicker(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select a day"),
          content: Observer(
            builder: (context) => NumberPicker(
              minValue: 1,
              maxValue: 30,
              value: _viewModel.day ?? 1,
              onChanged: _viewModel.didSelectDay,
            ),
          ),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showHourPicker(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select an hour"),
          content: Observer(
            builder: (context) => NumberPicker(
              minValue: 0,
              maxValue: 23,
              value: _viewModel.hour ?? 0,
              onChanged: _viewModel.didSelectHour,
            ),
          ),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMinutePicker(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select a minute"),
          content: Observer(
            builder: (context) => NumberPicker(
              minValue: 0,
              maxValue: 59,
              value: _viewModel.minute ?? 1,
              onChanged: _viewModel.didSelectMinute,
            ),
          ),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return BaseSettingsPage(
          title: "Notification time",
          infoText:
              "You can set a time to receive monthly notifications to send your invoice",
          buttonText: screenConfig.ctaText,
          onButtonPressed: () {
            _viewModel.saveInfo();
          },
          form: Form(
              key: _formKey,
              child: Column(
                children: [
                  InputField(
                    label: "Day",
                    onTap: () => _showDayPicker(context),
                    helperText:
                        "The day of the month you want to receive the notification",
                    controller: _viewModel.dayController,
                  ),
                  const SizedBox(
                    height: marginBetweenFields,
                  ),
                  InputField(
                    label: "Hour",
                    onTap: () => _showHourPicker(context),
                    helperText:
                        "The hour of the day you want to receive the notification",
                    controller: _viewModel.hourController,
                  ),
                  const SizedBox(
                    height: marginBetweenFields,
                  ),
                  InputField(
                    label: "Minute",
                    onTap: () => _showMinutePicker(context),
                    helperText:
                        "The exact minute you want to receive the notification",
                    controller: _viewModel.minuteController,
                  ),
                ],
              )));
    });
  }
}
