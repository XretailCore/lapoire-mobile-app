import '../../../core/localization/translate.dart';
import '../../../core/utils/validator.dart';
import '../controllers/signup_controller.dart';
import 'password_text_form_field_widget.dart';
import 'privacy_check_box_widget.dart';
import '../../../core/components/text_button_widget.dart';
import '../../../core/components/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signupwidget extends GetView<SignupController> {
  const Signupwidget({
    Key? key,
    required this.onTapGoToSignIn,
  }) : super(key: key);
  final VoidCallback onTapGoToSignIn;
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Form(
      key: controller.formKey,
      child: ListView(
        children: [
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: TextFormFieldWidget(
                  textEditingController: controller.firstNameTEC,
                  hint: '${Translate.firstName.tr} *',
                  textInputType: TextInputType.text,
                  validator: CustomValidator.userNameValidation,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: primaryColor),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormFieldWidget(
                  textEditingController: controller.lastNameTEC,
                  hint: '${Translate.lastName.tr} *',
                  textInputType: TextInputType.text,
                  validator: CustomValidator.userNameValidation,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: primaryColor),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          TextFormFieldWidget(
            textEditingController: controller.emailTEC,
            hint: '${Translate.emailAddress.tr} *',
            textInputType: TextInputType.text,
            validator: CustomValidator.emailValidation,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: primaryColor),
            ),
          ),
          const SizedBox(height: 15),
          TextFormFieldWidget(
            textEditingController: controller.mobileTEC,
            hint: '${Translate.mobileNumber.tr} *',
            textInputType: TextInputType.phone,
            validator: CustomValidator.mobileValidator,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: primaryColor),
            ),
          ),
          const SizedBox(height: 15),
          PasswordTextFormFieldWidget(
            textEditingController: controller.passwordTEC,
            hint: '${Translate.password.tr} *',
            textInputAction: TextInputAction.done,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: primaryColor),
            ),
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 10),
          PrivacyCheckBoxWidget(
            onChanged: controller.onChangePrivacy,
          ),
          const SizedBox(height: 8),
          Center(
            child: TextButtonWidget(
              minimumSize: const Size(180, 40),
              text: Translate.register.tr,
              onPressed: () => controller.onTapSignup(context),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: onTapGoToSignIn,
                child: RichText(
                  textAlign: TextAlign.center,
                  softWrap: true,
                  text: TextSpan(
                    text: '${Translate.youAlreadyHaveAnAccount.tr} ',
                    style: TextStyle(color: primaryColor, fontSize: 14),
                    children: [
                      TextSpan(
                        text: Translate.login.tr.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
