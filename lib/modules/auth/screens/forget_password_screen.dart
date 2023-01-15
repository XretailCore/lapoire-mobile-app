import 'package:imtnan/core/utils/theme.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/validator.dart';
import '../controllers/forget_password_controller.dart';
import '../../../core/components/appbar_widget.dart';
import '../../../core/components/text_button_widget.dart';
import '../../../core/components/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends GetView<ForgetPasswordController> {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        title: Translate.forgetPasswordText.tr,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              CustomText(
                Translate.enterTheMobileNumberAssociatedWithYourAccount.tr,
                style: TextStyle(
                  wordSpacing: 1,
                  height: 1.5,
                  fontSize: 16,
                  color: CustomThemes.appTheme.primaryColor,
                ),
                softWrap: true,
              ),
              const SizedBox(height: 20),
              TextFormFieldWidget(
                textEditingController: controller.mobileTEC,
                hint: Translate.mobile.tr,
                validator: CustomValidator.mobileValidator,
                textInputType: TextInputType.phone,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 30),
              Align(
                child: TextButtonWidget(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  text: Translate.send.tr,
                  onPressed: () async => controller.onTapSendSms(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
