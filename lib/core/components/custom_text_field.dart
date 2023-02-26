import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imtnan/core/utils/theme.dart';

import '../utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String? value) validator;
  final Function(String? value)? onChanged;
  final Function(String? value)? onSave;
  final Color? bgColor;
  final Color? labelColor;
  final Color? borderColor;
  final Color? errorBorderColor;
  final int maxLines;
  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.keyboardType,
    required this.validator,
    this.onChanged,
    this.onSave,
    this.bgColor,
    this.borderColor,
    this.errorBorderColor,
    this.maxLines = 1,
    this.labelColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // textInputAction: TextInputAction.search,
      controller: controller,

      maxLines: maxLines,
      style: TextStyle(
          color: CustomThemes.appTheme.primaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w700,
          letterSpacing: 0),
      autovalidateMode: AutovalidateMode.disabled,
      keyboardType: keyboardType ?? TextInputType.text,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onSave,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        hintText: labelText,
        filled: true,
        fillColor: bgColor ?? Colors.transparent,
        focusColor: bgColor ?? Colors.transparent,
        labelStyle: TextStyle(
          color: labelColor ?? const Color(0xffACBAC3),
          fontSize: 14,
          fontWeight: FontWeight.normal,
          letterSpacing: 0,
        ),
        hintStyle: TextStyle(
          color: labelColor ?? const Color(0xffACBAC3),
          fontSize: 14,
          fontWeight: FontWeight.normal,
          letterSpacing: 0,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide:
              BorderSide(color: borderColor ?? Colors.transparent, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
              color: errorBorderColor ?? AppColors.redColor, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
              color: errorBorderColor ?? AppColors.redColor, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide:
                BorderSide(color: borderColor ?? Colors.transparent, width: 1)),
        prefixIconConstraints:
            const BoxConstraints(minHeight: 25, minWidth: 60),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }
}

class CustomSearchTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String? value) validator;
  final void Function(String? value)? onChanged;
  final void Function(String? value)? onSave;
  final void Function()? onTap;
  const CustomSearchTextField({
    Key? key,
    required this.labelText,
    this.controller,
    this.keyboardType,
    required this.validator,
    this.onChanged,
    this.onSave, this.onTap,
  }) : super(key: key);

  @override
  State<CustomSearchTextField> createState() => _CustomSearchTextFieldState();
}

class _CustomSearchTextFieldState extends State<CustomSearchTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: CustomThemes.appTheme.primaryColor,
            width: 2,
          ),
        ),
      ),
      child: TextFormField(
        textInputAction: TextInputAction.search,
        controller: widget.controller,
        style: const TextStyle(
            color: AppColors.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 0),
        autovalidateMode: AutovalidateMode.disabled,
        keyboardType: TextInputType.text,
        onChanged: ((value) {
          widget.onChanged;
          setState(() {});
        }),
        // onSaved: onSave,
        onFieldSubmitted: widget.onSave,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          hintText: widget.labelText,
          filled: true,
          suffixIcon: InkWell(
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: FaIcon(
                FontAwesomeIcons.magnifyingGlass,
                size: 18,
                color: CustomThemes.appTheme.primaryColor
              ),
            ),
          ),
          fillColor: Colors.white,
          labelStyle: const TextStyle(
              color: Color(0xffACBAC3),
              fontSize: 14,
              fontWeight: FontWeight.normal,
              letterSpacing: 0),
          hintStyle: TextStyle(
            color: CustomThemes.appTheme.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: 0,
          ),
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          suffixIconConstraints:
              const BoxConstraints(minHeight: 30, minWidth: 30),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }
}
