import 'package:flutter/material.dart';

Future<DateTime?> selectDate(
  BuildContext context,
  DateTime? initialDate,
) async {
  var now = DateTime.now();
  return await showDatePicker(
    context: context,
    initialDate: initialDate ?? now,
    firstDate: DateTime(now.year - 5),
    lastDate: DateTime(now.year + 2),
  );
}
