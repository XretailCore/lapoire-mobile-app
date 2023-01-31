import 'package:flutter/material.dart';
import 'package:imtnan/core/utils/theme.dart';

import '../../../core/components/text_form_field_widget.dart';

class PasswordTextFormFieldWidget extends StatefulWidget {
  const PasswordTextFormFieldWidget({
    Key? key,
    this.hint = '',
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.textEditingController,
    this.focusedBorder,
  }) : super(key: key);
  final String hint;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final TextEditingController? textEditingController;
  final InputBorder? focusedBorder;
  @override
  State<PasswordTextFormFieldWidget> createState() =>
      _PasswordTextFormFieldWidgetState();
}

class _PasswordTextFormFieldWidgetState
    extends State<PasswordTextFormFieldWidget> {
  bool isObscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      textEditingController: widget.textEditingController,
      textInputAction: widget.textInputAction,
      hint: widget.hint,
      textInputType: TextInputType.visiblePassword,
      autocorrect: false,
      enableSuggestions: false,
      obscureText: isObscureText,
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            isObscureText = !isObscureText;
          });
        },
        icon: Icon(
          isObscureText ? Icons.visibility : Icons.visibility_off,
          color:CustomThemes.appTheme.primaryColor,
        ),
      ),
      validator: widget.validator,
      focusedBorder: widget.focusedBorder,
    );
  }
}
