import 'package:flutter/material.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';

class HeaderChangePasswordWidget extends StatelessWidget {
  const HeaderChangePasswordWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
      width: double.infinity,
      height: 176,
      color: primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            Translate.changeYourPassword.tr,
            style: const TextStyle(color: Colors.white, fontSize: 17),
          ),
        ],
      ),
    );
  }
}
