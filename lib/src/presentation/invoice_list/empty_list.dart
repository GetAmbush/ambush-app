import 'package:flutter/material.dart';
import 'package:ambush_app/src/core/settings/const.dart';
import 'package:ambush_app/src/designsystem/buttons.dart';

class EmptyList extends StatelessWidget {
  const EmptyList(
      {super.key, required this.onAddClick, required this.onSaveBackupClick});

  final VoidCallback onAddClick;
  final VoidCallback onSaveBackupClick;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final contentOffset = screenHeight * 0.25;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(regularMargin),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: contentOffset),
              Text(
                "Nothing to see here, yet.",
                style: textTheme.titleLarge?.copyWith(color: colors.primary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                "You don't have any invoice at the moment.\nMaybe it's time to create the first one?",
                style: textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 46),
              PrimaryButton(
                text: "Create invoice",
                onPressed: onAddClick,
              ),
              const SizedBox(
                height: 8,
              ),
              SecondaryButton(
                  text: "Save back up", onPressed: onSaveBackupClick),
            ],
          ),
        ),
      ),
    );
  }
}
