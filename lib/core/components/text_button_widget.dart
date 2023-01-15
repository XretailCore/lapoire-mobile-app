import 'package:flutter/material.dart';

import 'custom_text.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget(
      {Key? key,
      this.text = '',
      this.onPressed,
      this.padding,
      this.backgroundColor,
      this.minimumSize})
      : super(key: key);
  final String text;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Size? minimumSize;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(minimumSize),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        backgroundColor: MaterialStateProperty.all(
          backgroundColor ?? Theme.of(context).primaryColor,
        ),
        padding: MaterialStateProperty.all(padding),
      ),
      onPressed: () {
        if (onPressed != null) {
          FocusScope.of(context).unfocus();
          onPressed!();
        }
      },
      child: CustomText(text),
    );
  }
}
