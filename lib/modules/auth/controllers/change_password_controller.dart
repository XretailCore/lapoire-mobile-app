import '../../../core/components/custom_loaders.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';

class ChangePasswordController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final UserSharedPrefrenceController _userSharedPrefrenceController =
  Get.find<UserSharedPrefrenceController>();
  final TextEditingController oldPasswordTEC = TextEditingController(text: ''),
      newPasswordTEC = TextEditingController(text: ''),
      rePasswordTEC = TextEditingController(text: '');

  RxString currenPassError = "".obs;
  RxString newPassError = "".obs;
  RxString confirmPassError = "".obs;
  Future<void> onTapChange(BuildContext context) async {
    FocusScope.of(context).unfocus();
    final isValid = (formKey.currentState?.validate()) ?? false;
    if (isValid) {
      openLoadingDialog(context);
      final oldPassword = oldPasswordTEC.text.trim();
      final newPassword = newPasswordTEC.text.trim();
      await HelperFunctions.errorHandler(context, () async {
        await LinkTspApi.instance.account.changePassword(
          customId: _userSharedPrefrenceController.getUserId!,
          oldPassword: oldPassword,
          newPassword: newPassword,
        );

        Get.back();
        HelperFunctions.showSnackBar(
            message: Translate.successed.tr,
            context: context,
            hasCloseBtn: true,
            color: Theme.of(context).primaryColor);
      });
      Get.back();
    }
  }

  String? getCurrentPassError(String? error) {
    currenPassError.value = error ?? "";
    return currenPassError.value == "" ? null : currenPassError.value;
  }

  String? getNewPassError(String? error) {
    newPassError.value = error ?? "";
    return newPassError.value == "" ? null : newPassError.value;
  }

  String? getConfirmPassError(String? error) {
    confirmPassError.value = error ?? "";
    return confirmPassError.value == "" ? null : confirmPassError.value;
  }

  @override
  void onClose() {
    oldPasswordTEC.dispose();
    newPasswordTEC.dispose();
    rePasswordTEC.dispose();
    super.onClose();
  }
}
