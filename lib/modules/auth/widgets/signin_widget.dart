import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/utils/app_colors.dart';
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
              radius: 20,
              color: AppColors.redColor,
              title: Translate.login.tr,
              onTap: () => controller.onTapSignIn(context),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: primaryColor,
                  thickness: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: CustomText(
                  Translate.or.tr,
                  style: TextStyle(color: primaryColor, fontSize: 12,fontWeight: FontWeight.w400),
                ),
              ),
              Expanded(
                child: Divider(
                  color: primaryColor,
                  thickness: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => controller.onTapSignInWithFacebook(context),
                iconSize: 40,
                icon: const Icon(
                  Icons.facebook,
                  color: Color.fromRGBO(59, 89, 152, 1),
                ),
              ),
              IconButton(
                onPressed: () {
                  controller.onTapSignInWithGoogle(context);
                },
                iconSize: 40,
                icon: SvgPicture.asset(
                  'assets/images/google_login_icon.svg',
                  fit: BoxFit.fill,
                ),
              ),
              Visibility(
                visible: Platform.isIOS,
                child: const SizedBox(
                  width: 10,
                ),
              ),
              Visibility(
                visible: Platform.isIOS,
                child: CircleAvatar(
                  radius: 17,
                  backgroundColor: Colors.black,
                  child: Center(
                    child: IconButton(
                      padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                      onPressed: () {
                        controller.loginWithAppleID(context);
                      },
                      iconSize: 22,
                      icon: const Icon(
                        Icons.apple,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
                        style: const TextStyle(fontSize: 14,decoration: TextDecoration.underline,color: AppColors.redColor),
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
