import '../../../core/utils/helper_functions.dart';
import '../../../core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';

class ForgetPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final mobileTEC = TextEditingController(text: '');
  String get mobile => mobileTEC.text;

  Future<void> onTapSendSms(BuildContext context) async {
    final isInputsInValid = !((formKey.currentState?.validate()) ?? false);
    if (isInputsInValid) {
      return;
    }
    await HelperFunctions.errorRequestsSnakBarHandler(
      context,
      loadingFunction: () async {
        await LinkTspApi.instance.account
            .forgetPassword(data: mobileTEC.text, verifyType: 1);
      },
      onSuccessFunction: (_) async {
        Get.toNamed(Routes.verifyOtpForgetPasswordScreen);
      },
    );
  }

  @override
  void onClose() {
    mobileTEC.dispose();
    super.onClose();
  }
}
