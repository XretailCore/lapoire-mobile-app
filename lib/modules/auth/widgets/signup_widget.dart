import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imtnan/core/components/custom_text.dart';
import 'package:imtnan/modules/auth/widgets/social_media_widget.dart';
import '../../../core/components/custom_button.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/validator.dart';
import '../controllers/signup_controller.dart';
import 'password_text_form_field_widget.dart';
import 'privacy_check_box_widget.dart';
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            TextFormFieldWidget(
              textEditingController: controller.firstNameTEC,
              hint: '${Translate.firstName.tr} *',
              textInputType: TextInputType.text,
              validator: CustomValidator.userNameValidation,
            ),
            const SizedBox(height: 15),
            TextFormFieldWidget(
              textEditingController: controller.lastNameTEC,
              hint: '${Translate.lastName.tr} *',
              textInputType: TextInputType.text,
              validator: CustomValidator.userNameValidation,
            ),
            const SizedBox(height: 15),
            TextFormFieldWidget(
              textEditingController: controller.emailTEC,
              hint: '${Translate.emailAddress.tr} *',
              textInputType: TextInputType.text,
              validator: CustomValidator.emailValidation,
            ),
            const SizedBox(height: 15),
            TextFormFieldWidget(
              textEditingController: controller.mobileTEC,
              hint: '${Translate.mobileNumber.tr} *',
              textInputType: TextInputType.phone,
              validator: CustomValidator.mobileValidator,
            ),
            const SizedBox(height: 15),
            PasswordTextFormFieldWidget(
              textEditingController: controller.passwordTEC,
              hint: '${Translate.password.tr} *',
              textInputAction: TextInputAction.done,
              validator: CustomValidator.requiredValidation,
            ),
            const SizedBox(height: 15),
            PasswordTextFormFieldWidget(
              textEditingController: controller.confirmPasswordTEC,
              hint: '${Translate.confirmYourPassword.tr} *',
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value != controller.passwordTEC.value.text) {
                  return Translate.confirmPasswordMessage.tr;
                }
              },
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () async {
                FocusScope.of(context).unfocus();
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: controller.selectedDate.value ?? DateTime.now(),
                  currentDate: controller.selectedDate.value ?? DateTime.now(),
                  firstDate: DateTime(1950, 1),
                  lastDate: DateTime.now(),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(primary: primaryColor),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                              primary: primaryColor // button text color
                              ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (picked != null) controller.selectedDate.value = picked;
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: primaryColor),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => CustomText(
                        controller.selectedDate.value == null
                            ? Translate.birthdate.tr
                            : "${controller.selectedDate.value!.day}/${controller.selectedDate.value!.month}/${controller.selectedDate.value!.year}",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    FaIcon(
                      FontAwesomeIcons.calendarDays,
                      color: primaryColor,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const SocialMediaWidget(),
            const SizedBox(height: 10),
            PrivacyCheckBoxWidget(
              onChanged: controller.onChangePrivacy,
            ),
            const SizedBox(height: 8),
            Center(
              child: CustomBorderButton(
                radius: 30,
                color: AppColors.redColor,
                title: Translate.createNewAccount.tr,
                onTap: () => controller.onTapSignup(context),
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
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: Translate.login.tr,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColors.redColor,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
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
      ),
    );
  }
}
