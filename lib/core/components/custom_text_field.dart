import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imtnan/core/utils/theme.dart';

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
      style: const TextStyle(
          color: Color(0xffACBAC3),
          fontSize: 14,
          fontWeight: FontWeight.normal,
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
          borderRadius: BorderRadius.circular(20.0),
          borderSide:
              BorderSide(color: borderColor ?? Colors.transparent, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
              color: errorBorderColor ?? Colors.transparent, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
              color: errorBorderColor ?? Colors.transparent, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
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
  const CustomSearchTextField({
    Key? key,
    required this.labelText,
    this.controller,
    this.keyboardType,
    required this.validator,
    this.onChanged,
    this.onSave,
  }) : super(key: key);

  @override
  State<CustomSearchTextField> createState() => _CustomSearchTextFieldState();
}

class _CustomSearchTextFieldState extends State<CustomSearchTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.search,
      controller: widget.controller,
      style: const TextStyle(
          color: Color(0xffACBAC3),
          fontSize: 14,
          fontWeight: FontWeight.normal,
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
          onTap: (() {
            setState(() {
              widget.controller!.clear();
            });
          }),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: FaIcon(
              FontAwesomeIcons.xmark,
              color: widget.controller!.text.length > 0
                  ? CustomThemes.appTheme.primaryColor
                  : Colors.transparent,
            ),
          ),
        ),
        fillColor: Colors.white,
        labelStyle: const TextStyle(
            color: Color(0xffACBAC3),
            fontSize: 14,
            fontWeight: FontWeight.normal,
            letterSpacing: 0),
        hintStyle: const TextStyle(
          color: Color(0xffACBAC3),
          fontSize: 14,
          fontWeight: FontWeight.normal,
          letterSpacing: 0,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 2.0),
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIconConstraints:
            const BoxConstraints(minHeight: 30, minWidth: 30),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }
}
