import '../../../core/utils/validator.dart';
import '../widgets/header_change_password_widget.dart';
import '../../../core/localization/translate.dart';
import '../controllers/change_password_controller.dart';
import '../../../core/components/appbar_widget.dart';
import '../widgets/password_text_form_field_widget.dart';
import '../../../core/components/text_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBarWidget(
        title: Translate.changePassword.tr,
        backgroundColor: Colors.grey[50]!,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const HeaderChangePasswordWidget(),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Align(
                child: TextButtonWidget(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  text: Translate.submit.tr,
                  onPressed: () async => controller.onTapChange(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
