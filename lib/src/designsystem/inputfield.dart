import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.label,
    required this.controller,
    this.textInputAction,
    this.validator,
    this.autovalidateMode,
    this.maxLines,
    this.minLines,
    this.hintText,
    this.keyboardType,
    this.readOnly = false,
    this.onTap,
    this.helperText,
    this.inputFormatters,
    this.showSuffix = true,
  });

  final String label;
  final String? hintText;
  final String? helperText;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final TextEditingController controller;
  final int? maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final bool showSuffix;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        helperText: helperText,
        helperStyle: textTheme.bodySmall,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        suffixIcon: showSuffix ? IconButton(
          onPressed: () {
            controller.clear();
          },
          icon: SvgPicture.asset('assets/icons/ic_clear.svg'),
        ) : null,
      ),
      textInputAction: textInputAction,
      validator: validator,
      autovalidateMode: autovalidateMode,
      controller: controller,
      maxLines: maxLines,
      minLines: minLines,
      keyboardType: keyboardType,
      readOnly: readOnly,
      onTap: onTap,
      inputFormatters: inputFormatters,
    );
  }
}
