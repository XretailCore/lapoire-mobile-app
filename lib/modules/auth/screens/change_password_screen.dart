import '../../../core/components/custom_appbar.dart';
import '../../../core/components/custom_button.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/validator.dart';
import '../../../core/localization/translate.dart';
import '../controllers/change_password_controller.dart';
import '../widgets/password_text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(
        title: Translate.changePassword.tr,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 40),
                PasswordTextFormFieldWidget(
                  textEditingController: controller.oldPasswordTEC,
                  hint: Translate.currentPassword.tr,
                ),
                const SizedBox(height: 10),
                PasswordTextFormFieldWidget(
                  textEditingController: controller.newPasswordTEC,
                  hint: Translate.newPassword.tr,
                ),
                const SizedBox(height: 10),
                PasswordTextFormFieldWidget(
                  textEditingController: controller.rePasswordTEC,
                  hint: Translate.confirmYourPassword.tr,
                  validator: (rePassword) {
                    final password = controller.newPasswordTEC.text;
                    return CustomValidator.rePasswordValidator(
                        password: password, rePassword: rePassword);
                  },
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomBorderButton(
                      radius: 30,
                      color: AppColors.redColor,
                      title: Translate.savePassword.tr,
                      onTap: () async => controller.onTapChange(context)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
