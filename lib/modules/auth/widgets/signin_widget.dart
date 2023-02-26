import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import 'package:imtnan/modules/auth/widgets/social_media_widget.dart';
import '../../../core/components/custom_button.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/components/text_form_field_widget.dart';
import '../../../core/localization/translate.dart';
import '../controllers/signin_controller.dart';
import 'password_text_form_field_widget.dart';

class SignInWidget extends GetView<SigninController> {
  const SignInWidget({
    Key? key,
    required this.onTapGoToSignUp,
  }) : super(key: key);
  final VoidCallback onTapGoToSignUp;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Form(
      key: controller.formKey,
      child: ListView(
        children: [
          const SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                Translate.welcomeBack.tr,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 4.0),
              CustomText(
                Translate.signInToAccess.tr,
                style: const TextStyle(
                  color: AppColors.redColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          TextFormFieldWidget(
            textEditingController: controller.emailTEC,
            hint: Translate.emailAddressOrPhoneNumber.tr,
            textInputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 15),
          PasswordTextFormFieldWidget(
            textEditingController: controller.passwordTEC,
            hint: Translate.password.tr,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: controller.onForgetPassword,
                child: CustomText(
                  Translate.forgetPassword.tr,
                  style: const TextStyle(
                      color: AppColors.redColor,
                      fontSize: 11,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: CustomBorderButton(
              radius: 30,
              color: AppColors.redColor,
              title: Translate.login.tr,
              onTap: () => controller.onTapSignIn(context),
            ),
          ),
          const SizedBox(height: 20),
          const SocialMediaWidget(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: onTapGoToSignUp,
                child: RichText(
                  textAlign: TextAlign.center,
                  softWrap: true,
                  text: TextSpan(
                    text: '${Translate.donotHaveAccount.tr} ',
                    style: TextStyle(color: primaryColor, fontSize: 14),
                    children: [
                      TextSpan(
                        text: Translate.register.tr,
                        style: const TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            color: AppColors.redColor),
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
