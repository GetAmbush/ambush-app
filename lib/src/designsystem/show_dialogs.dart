import 'package:ambush_app/src/designsystem/dialog_one_button.dart';
import 'package:flutter/material.dart';

Future<void> showOnButtonDialog(
    BuildContext context, String title, String message, String ctaText) {
  return showDialog<void>(
    context: context,
    builder: (context) => DialogOneButton(
      title: title,
      supportText: message,
      button: DialogButton(ctaText, () => Navigator.pop(context)),
    ),
  );
}
