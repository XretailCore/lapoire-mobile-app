import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class OtpWidget extends StatelessWidget {
  const OtpWidget({Key? key, this.otpTEC}) : super(key: key);
  final TextEditingController? otpTEC;
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return PinCodeTextField(
      controller: otpTEC,
      hasUnderline: false,
      autofocus: true,
      highlightColor: const Color.fromRGBO(246, 246, 247, 1),
      defaultBorderColor: primaryColor,
      hasTextBorderColor: primaryColor,
      highlightPinBoxColor: const Color.fromRGBO(246, 246, 247, 1),
      pinBoxColor: const Color.fromRGBO(246, 246, 247, 1),
      maxLength: 4,
      pinBoxWidth: 40,
      pinBoxHeight: 40,
      wrapAlignment: WrapAlignment.spaceEvenly,
      pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
      pinTextStyle: TextStyle(fontSize: 12.0.sp, color: primaryColor),
      pinTextAnimatedSwitcherTransition:
          ProvidedPinBoxTextAnimation.scalingTransition,
      pinTextAnimatedSwitcherDuration: const Duration(milliseconds: 300),
      highlightAnimationBeginColor: Colors.black,
      highlightAnimationEndColor: Colors.white12,
      pinBoxBorderWidth: 1,
      pinBoxRadius: 8,
    );
  }
}
