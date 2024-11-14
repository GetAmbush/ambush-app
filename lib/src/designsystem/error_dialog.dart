import 'package:ambush_app/src/designsystem/buttons.dart';
import 'package:flutter/material.dart';

Future<void> showErrorDialog(BuildContext context) {
  return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              'Finished with an error',
              textAlign: TextAlign.center,
            ),
            content: Text(
              'There was an error formatting your backup file.',
              textAlign: TextAlign.center,
            ),
            actions: [
              Center(
                child: PrimaryButton(
                    text: 'Ok', onPressed: () => Navigator.pop(context)),
              )
            ],
          ));
}
