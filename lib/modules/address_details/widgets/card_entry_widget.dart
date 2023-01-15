import '../../../core/utils/theme.dart';
import 'package:flutter/material.dart';

class CardEntryWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String placeHolderLabel;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final bool enabled;
  const CardEntryWidget({
    Key? key,
    required this.textEditingController,
    this.placeHolderLabel = '',
    this.textInputType,
    this.validator,
    this.enabled = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: textEditingController,
      enabled: enabled,
      keyboardType: textInputType,
      style: TextStyle(
        color: CustomThemes.appTheme.colorScheme.secondary,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        letterSpacing: 0,
      ),
      validator: validator,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: primaryColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: primaryColor)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red)),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primaryColor),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        errorStyle: const TextStyle(fontSize: 12, height: 1.2),
        labelText: placeHolderLabel,
        labelStyle: TextStyle(
          color: primaryColor,
          fontSize: 12,
          fontWeight: FontWeight.normal,
          letterSpacing: 0,
        ),
      ),
    );
  }
}
