import 'package:imtnan/core/components/custom_appbar.dart';
import '../../../core/components/custom_button.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/theme.dart';
import '../controllers/verify_otp_forget_password_controller.dart';
import '../widgets/otp_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyOtpForgetPasswordScreen
    extends GetView<VerifyOtpForgetPasswordController> {
  const VerifyOtpForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          title: Translate.verifyOTP.tr,
          showAction: false,
          showBackButton: true),
      body: Form(
        key: controller.formKey,
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: CustomText(
                Translate.enterYourOTPCodeHere.tr,
                style: TextStyle(
                  color: CustomThemes.appTheme.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OtpWidget(
                  otpTEC: controller.otpTEC,
                ),
              ],
            ),
            const SizedBox(height: 50),
            Align(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: CustomBorderButton(
                  radius: 30,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  title: Translate.submit.tr,
                  color: AppColors.redColor,
                  onTap: () async => await controller.onTapVerify(context),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      if (controller.isCounterEqualZero) {
                        await controller.onTapResendOtp(context);
                      }
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: RichText(
                      textAlign: TextAlign.center,
                      softWrap: true,
                      text: TextSpan(
                        text: '${Translate.didntReceiveOtpCode.tr} ! ',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                        children: [
                          TextSpan(
                            text: Translate.resend.tr,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: controller.isCounterEqualZero
                                  ? CustomThemes.appTheme.primaryColor
                                  : Colors.black,
                              decoration: TextDecoration.underline,
                              decorationThickness: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Offstage(
                    offstage: controller.isCounterEqualZero,
                    child: CustomText(
                      '${(Duration(seconds: controller.counter))}'.split('.')[0].padLeft(8, '0'),
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
