import '../../../core/localization/translate.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';

class ChangePasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final oldPasswordTEC = TextEditingController(text: ''),
      newPasswordTEC = TextEditingController(text: ''),
      rePasswordTEC = TextEditingController(text: '');

  Future<void> onTapChange(BuildContext context) async {
    final isInputsInValid = !((formKey.currentState?.validate()) ?? false);
    if (isInputsInValid) {
      return;
    }
    await HelperFunctions.errorRequestsSnakBarHandler(
      context,
      hasCloseBtn: true,
      loadingFunction: () async {
        final userSharedPrefrenceController =
            Get.find<UserSharedPrefrenceController>();
        await LinkTspApi.instance.account.changePassword(
          customId: userSharedPrefrenceController.getUserId!,
          oldPassword: oldPasswordTEC.text,
          newPassword: newPasswordTEC.text,
        );
        HelperFunctions.showSnackBar(
            message: Translate.successed.tr,
            context: context,
            hasCloseBtn: true,
            color: Theme.of(context).primaryColor);
        _backToPerviousScreen();
      },
    );
  }

  void _backToPerviousScreen() {
    Get.back();
  }

  @override
  void onClose() {
    oldPasswordTEC.dispose();
    newPasswordTEC.dispose();
    rePasswordTEC.dispose();
    ScaffoldMessenger.of(Get.context!).clearSnackBars();
    super.onClose();
  }
}
