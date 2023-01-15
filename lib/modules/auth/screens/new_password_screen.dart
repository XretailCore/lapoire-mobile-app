import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/appbar_widget.dart';
import '../../../core/components/text_button_widget.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/validator.dart';
import '../controllers/new_password_controller.dart';
import '../widgets/password_text_form_field_widget.dart';

class NewPasswordScreen extends GetView<NewPasswordController> {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBarWidget(
        title: Translate.newPassword.tr,
        backgroundColor: Colors.grey[50]!,
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
                child: TextButtonWidget(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
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
