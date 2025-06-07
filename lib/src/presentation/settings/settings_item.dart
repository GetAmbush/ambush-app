import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.onClick});

  final String title;
  final String subtitle;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;

    return ListTile(
      title: Text(title, style: textTheme.headlineSmall),
      subtitle: Text(
        subtitle,
        style: textTheme.titleSmall?.apply(
          color: colorTheme.onSurface.withValues(alpha: 0.5),
        ),
      ),
      onTap: onClick,
    );
  }
}
