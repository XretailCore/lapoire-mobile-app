import '../../../core/components/custom_appbar.dart';
import '../../../core/components/custom_button.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/validator.dart';
import '../controllers/forget_password_controller.dart';
import '../../../core/components/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends GetView<ForgetPasswordController> {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: Translate.enterYourPhone.tr,
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              TextFormFieldWidget(
                textEditingController: controller.mobileTEC,
                hint: Translate.enterYourPhone.tr,
                validator: CustomValidator.mobileValidator,
                textInputType: TextInputType.phone,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 64),
              CustomBorderButton(
                radius: 30,
                color: AppColors.redColor,
                title: Translate.send.tr,
                onTap: () async => controller.onTapSendSms(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
