import 'package:flutter/material.dart';
import 'package:imtnan/core/utils/theme.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    Key? key,
    this.hint = '',
    this.textInputType = TextInputType.emailAddress,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.textEditingController,
    this.minLines = 1,
    this.maxLines = 1,
    this.backgroundColor,
    this.focusedBorder,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.autovalidateMode,
    this.hintStyle,
    this.enabledBorder,
  }) : super(key: key);
  final String hint;
  final TextInputType textInputType;
  final bool obscureText, enableSuggestions, autocorrect;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final TextEditingController? textEditingController;
  final int minLines, maxLines;
  final Color? backgroundColor;
  final InputBorder? focusedBorder, enabledBorder;
  final EdgeInsetsGeometry contentPadding;
  final AutovalidateMode? autovalidateMode;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    final primaryColor = CustomThemes.appTheme.primaryColor;
    return TextFormField(
      autovalidateMode: autovalidateMode,
      controller: textEditingController,
      keyboardType: textInputType,
      obscureText: obscureText,
      enableSuggestions: enableSuggestions,
      textInputAction: textInputAction,
      autocorrect: autocorrect,
      minLines: minLines,
      maxLines: maxLines,
      style: TextStyle(
        color: primaryColor,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      decoration: InputDecoration(
        fillColor: backgroundColor,
        filled: backgroundColor != null,
        suffixIcon: suffixIcon,
        contentPadding: contentPadding,
        hintText: hint,
        hintStyle: hintStyle ??
            TextStyle(color: primaryColor, fontWeight: FontWeight.w400),
        hoverColor: primaryColor,
        focusColor: primaryColor,
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: primaryColor),
            ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: primaryColor),
            ),
      ),
      validator: validator,
    );
  }
}
