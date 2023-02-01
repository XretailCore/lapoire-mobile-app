import 'package:flutter/material.dart';
import 'package:imtnan/core/utils/theme.dart';
import '../../../core/components/custom_text.dart';

class CheckOutTitleDividerWidget extends StatelessWidget {
  final String title;
  const CheckOutTitleDividerWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor=CustomThemes.appTheme.primaryColor;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(title),
          Divider(color: primaryColor, thickness: 1),
        ],
      ),
    );
  }
}
