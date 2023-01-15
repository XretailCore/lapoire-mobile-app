import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/appbar_widget.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/components/text_button_widget.dart';
import '../../../core/localization/translate.dart';
import '../controllers/verify_otp_controller.dart';
import '../widgets/header_verify_otp_widget.dart';
import '../widgets/otp_widget.dart';

class VerifyOtpScreen extends GetView<VerifyOtpController> {
  const VerifyOtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(),
      body: Form(
        key: controller.formKey,
        child: ListView(
          children: [
            const HeaderVerifyOtp(),
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
              child: TextButtonWidget(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                text: Translate.submit.tr,
                onPressed: () async => await controller.onTapVerify(context),
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
                          fontSize: 10,
                        ),
                        children: [
                          TextSpan(
                            text: Translate.resend.tr,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: controller.isCounterEqualZero
                                  ? Colors.black
                                  : Colors.grey,
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
                      controller.counter.toString(),
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
