import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/components/custom_appbar.dart';
import 'package:imtnan/core/components/custom_button.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/validator.dart';
import '../controllers/new_password_controller.dart';
import '../widgets/password_text_form_field_widget.dart';

class NewPasswordScreen extends GetView<NewPasswordController> {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(
        title: Translate.newPassword.tr,
        showBackButton: true,
        showAction: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              PasswordTextFormFieldWidget(
                textEditingController: controller.newPasswordTEC,
                hint: Translate.newPassword.tr,
                validator: CustomValidator.passwordValidator,
                textInputAction: TextInputAction.next,
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
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 10),
              Align(
                child: CustomBorderButton(
                  padding: const EdgeInsets.all(12),
                  radius: 30,
                  title: Translate.submit.tr,
                  color: AppColors.redColor,
                  onTap: () async => controller.onTapChange(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
