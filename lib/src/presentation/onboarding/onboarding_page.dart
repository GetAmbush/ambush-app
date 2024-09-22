import 'package:auto_route/auto_route.dart';
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
            ],
          ),
        ),
      ),
    );
  }
}
