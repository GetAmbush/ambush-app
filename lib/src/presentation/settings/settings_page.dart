import 'package:ambush_app/src/designsystem/constrained_scaffold.dart';
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
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pageConfig = BasicInfoPageConfig(
      ctaText: 'Save',
    );

    return ConstrainedScaffold(
      maxWidth: defaultPageMaxWidth,
      appBar: AppBar(title: const Text("Settings")),
      body: Observer(builder: (_) {
        return ListView(
          padding: const EdgeInsets.symmetric(vertical: regularMargin),
          children: [
            SettingsItem(
              title: "Contractor Information",
              subtitle: "Basic information about your company",
              onClick: () {
                context.router.push(
                  BasicInfoRoute(
                    flow: SettingsNavigationFlow(context.router),
                    screenConfig: pageConfig,
                  ),
                );
              },
            ),
            const Divider(indent: regularMargin, endIndent: regularMargin),
            SettingsItem(
              title: "Company Address",
              subtitle: "Your company’s address",
              onClick: () {
                context.router.push(
                  AddressRoute(
                    flow: SettingsNavigationFlow(context.router),
                    screenConfig: pageConfig,
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
                    screenConfig: pageConfig,
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
                    screenConfig: pageConfig,
                  ),
                );
              },
            ),
            const Divider(indent: regularMargin, endIndent: regularMargin),
            SettingsItem(
              title: "Backup",
              subtitle: "Create and restore backups",
              onClick: () {
                context.router.push(BackupRoute());
              },
            ),
          ],
        );
      }),
    );
  }
}
