import 'package:flutter/material.dart';

import '../../../core/components/custom_text.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget(
      {Key? key,
      required this.text,
      this.height = 50,
      this.width,
      this.backgroundColor = const Color.fromRGBO(34, 174, 165, 1),
      this.onTap})
      : super(key: key);
  final double height;
  final double? width;
  final VoidCallback? onTap;
  final String text;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          backgroundColor: MaterialStateProperty.all(
            onTap == null ? Colors.grey : backgroundColor,
          ),
          foregroundColor: MaterialStateProperty.all(
            Colors.white,
          ),
        ),
        onPressed: () {
          if (onTap != null) {
            onTap!();
            FocusScope.of(context).unfocus();
          }
        },
        child: CustomText(text),
      ),
    );
  }
}
