import 'package:flutter/material.dart';

class DialogOneButton extends StatelessWidget {
  const DialogOneButton(
      {super.key,
      required this.title,
      required this.supportText,
      required this.button});

  final String title;
  final String supportText;
  final DialogButton button;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(supportText),
      actions: [
        TextButton(
          onPressed: button.onClick,
          child: Text(button.text),
        ),
      ],
    );
  }
}

class DialogButton {
  final String text;
  final VoidCallback onClick;

  DialogButton(this.text, this.onClick);
}
