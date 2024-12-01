import 'dart:io';

import 'package:ambush_app/src/core/routes/app_route.gr.dart';
import 'package:ambush_app/src/designsystem/show_dialogs.dart';
import 'package:ambush_app/src/presentation/utils/backup/backup_error.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ambush_app/src/core/di/di.dart';
import 'package:ambush_app/src/core/settings/const.dart';
import 'package:ambush_app/src/designsystem/buttons.dart';
import 'package:ambush_app/src/presentation/onboarding/onboarding_navigation_flow.dart';

import 'onboarding_viewmodel.dart';

@RoutePage()
class OnBoardingPage extends StatelessWidget {
  OnBoardingPage({super.key});

  final OnboardingViewModel _viewModel = getIt();

  @override
  Widget build(BuildContext context) {
    final navigator = context.router;
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(regularMargin),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Welcome to the\nAmbush Invoice tool!',
                style: textTheme.headlineSmall?.copyWith(
                    color: colors.primary, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'It seems like it is your first time here.',
                style: textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 36),
              PrimaryButton(
                onPressed: () async {
                  await _viewModel.finishOnboarding();
                  final flow = OnBoardingNavigationFlow(navigator);
                  flow.start();
                },
                text: 'Set my info',
              ),
              if (_shouldHaveBackupFeature()) ...[
                const SizedBox(
                  height: 16,
                ),
                _OrDivider(),
                const SizedBox(
                  height: 16,
                ),
                SecondaryButton(
                    text: "Restore a back up",
                    onPressed: () => _onRestoreBackUpClick(context)),
              ]
            ],
          ),
        ),
      ),
    );
  }

  bool _shouldHaveBackupFeature() =>
      (kIsWeb) || Platform.isMacOS || Platform.isLinux || Platform.isWindows;

  void _onRestoreBackUpClick(BuildContext context) async {
    try {
      await _viewModel.restoreApplicationBackup();
      await _viewModel.finishOnboarding();
      if (context.mounted) context.router.replace(InvoiceListRoute());
    } catch (e) {
      if (context.mounted) {
        _showErrorDialog(
            context, e is BackupError ? e.message : genericErrorMessage);
      }
    }
  }

  void _showErrorDialog(BuildContext context, String message) =>
      showOnButtonDialog(context, genericErrorTitle, message, ok);
}

class _OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
        width: 20,
        child: Divider(
          height: 1,
          color: colors.primary,
        ),
      ),
      SizedBox(
        width: 4,
      ),
      Text(
        'Or',
        style: TextStyle(color: colors.primary),
        textAlign: TextAlign.center,
      ),
      SizedBox(
        width: 4,
      ),
      SizedBox(
        width: 20,
        child: Divider(
          height: 1,
          color: colors.primary,
        ),
      )
    ]);
  }
}
