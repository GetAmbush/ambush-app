import 'package:ambush_app/src/designsystem/buttons.dart';
import 'package:flutter/material.dart';

Future<void> showErrorDialog(
    BuildContext context, String title, String content, String ctaText) {
  return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            content: Text(
              content,
              textAlign: TextAlign.center,
            ),
            actions: [
              Center(
                child: PrimaryButton(
                    text: ctaText, onPressed: () => Navigator.pop(context)),
              )
            ],
          ));
}
