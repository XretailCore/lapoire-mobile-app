import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/utils/helper_functions.dart';
import '../../../core/utils/routes.dart';
import 'verify_otp_forget_password_controller.dart';

class NewPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final VerifyOtpForgetPasswordController _verifyOtpForgetPasswordController =
      Get.find<VerifyOtpForgetPasswordController>();
  final newPasswordTEC = TextEditingController(text: ''),
      rePasswordTEC = TextEditingController(text: '');
  Future<void> onTapChange(BuildContext context) async {
    final isInputsInValid = !((formKey.currentState?.validate()) ?? false);
    if (isInputsInValid) {
      return;
    }
    final newPassword = newPasswordTEC.text;
    await HelperFunctions.errorHandler(context, () async {
      await LinkTspApi.instance.account.resetPassword(
        customerId: _verifyOtpForgetPasswordController.userId!,
        password: newPassword,
      );
      Get.offAllNamed(Routes.dashboard);
    });
  }

  @override
  void onClose() {
    newPasswordTEC.dispose();
    rePasswordTEC.dispose();
    ScaffoldMessenger.of(Get.context!).clearSnackBars();
    super.onClose();
  }
}
