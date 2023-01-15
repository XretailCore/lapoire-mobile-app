import 'package:flutter/material.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';

class HeaderVerifyOtp extends StatelessWidget {
  const HeaderVerifyOtp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
      height: 176,
      width: double.infinity,
      color: primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomText(
            Translate.enterTheCodeToVerifyYourPhone.tr,
            style: const TextStyle(fontSize: 17, color: Colors.white),
          ),
          const SizedBox(height: 10),
          CustomText(
            Translate.enterYourOTPCodeHere.tr,
            style: const TextStyle(fontSize: 11, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
