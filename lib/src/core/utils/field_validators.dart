import 'package:ambush_app/src/core/settings/const.dart';

String? requiredFieldValidator(String? value) {
  if (value == null || value.isEmpty) {
    return requiredField;
  }
  return null;
}

String? doubleValueValidator(String? value) {
  if (value == null || value.isEmpty) {
    return requiredField;
  }

  if (double.tryParse(value) == null) {
    return invalidValue;
  }

  return null;
}

String? requiredEmailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return requiredField;
  }

  if (!value.contains("@")) {
    return invalidEmail;
  }

  return null;
}

String? intValueValidator(String? value) {
  if (value == null || value.isEmpty) {
    return requiredField;
  }

  if (int.tryParse(value) == null) {
    return invalidValue;
  }

  return null;
}
