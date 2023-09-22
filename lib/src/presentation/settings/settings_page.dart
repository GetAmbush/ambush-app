import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ambush_app/src/core/routes/app_route.gr.dart';
import 'package:ambush_app/src/core/settings/const.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ambush_app/src/presentation/settings/base_settings_page.dart';
import 'package:ambush_app/src/presentation/settings/settings_navigation_flow.dart';

import 'settings_item.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pageConfig = BasicInfoPageConfig(
      ctaText: 'Save',
      showSaveSwitch: false,
      alwaysSave: true,
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Observer(builder: (_) {
        return ListView(
          padding: const EdgeInsets.symmetric(vertical: regularMargin),
          children: [
            SettingsItem(
              title: "Basic information",
              subtitle: "Basic information about your company",
              onClick: () {
                context.router.push(
                  BasicInfoRoute(
                    flow: SettingsNavigationFlow(context.router),
                    screenConfig: _pageConfig,
                  ),
                );
              },
            ),
            const Divider(indent: regularMargin, endIndent: regularMargin),
            SettingsItem(
              title: "Bank information",
              subtitle: "Your bank account information",
              onClick: () {
                context.router.push(
                  BankInfoRoute(
                    flow: SettingsNavigationFlow(context.router),
                    screenConfig: _pageConfig,
                  ),
                );
              },
            ),
            const Divider(indent: regularMargin, endIndent: regularMargin),
            SettingsItem(
              title: "Service information",
              subtitle: "Information about the services that you provided",
              onClick: () {
                context.router.push(
                  ServiceInfoRoute(
                    flow: SettingsNavigationFlow(context.router),
                    screenConfig: _pageConfig,
                  ),
                );
              },
            ),
            const Divider(indent: regularMargin, endIndent: regularMargin),
            SettingsItem(
              title: "Client information",
              subtitle: "Information about your client",
              onClick: () {
                context.router.push(
                  ClientInfoRoute(
                    flow: SettingsNavigationFlow(context.router),
                    screenConfig: _pageConfig,
                  ),
                );
              },
            ),
          ],
        );
      }),
    );
  }
}
