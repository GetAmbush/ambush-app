import 'package:flutter/material.dart';
import 'package:ambush_app/src/core/settings/const.dart';
import 'package:ambush_app/src/designsystem/buttons.dart';

class BaseSettingsPage extends StatelessWidget {
  const BaseSettingsPage({
    super.key,
    required this.title,
    this.infoText,
    required this.buttonText,
    required this.onButtonPressed,
    required this.form,
  });

  final String title;
  final String? infoText;
  final Form form;
  final String buttonText;
  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: regularMargin,
          horizontal: regularMargin,
        ),
        children: [
          if (infoText != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 36),
              child: Text(
                infoText!,
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ),
          form,
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrimaryButton(
                onPressed: onButtonPressed,
                text: buttonText,
              ),
            ],
          )
        ],
      ),
    );
  }

}

class BasicInfoPageConfig {
  final String ctaText;

  BasicInfoPageConfig({
    required this.ctaText,
  });
}
