import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/components/custom_appbar.dart';
import 'package:imtnan/core/components/custom_button.dart';
import '../../../core/components/text_form_field_widget.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/validator.dart';
import '../controller/subscribe_controller.dart';

class SubscribeScreen extends GetView<SubscribeController> {
  const SubscribeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: Translate.subscribeToOurNewsletter.tr,
        showBackButton: true,
        showAction: false,
      ),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: ListView(
            children: [
              const SizedBox(height: 30),
              TextFormFieldWidget(
                textEditingController: controller.emailTEC,
                hint: Translate.emailAddress.tr,
                validator: CustomValidator.emailValidation,
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 50),
              Center(
                child: CustomBorderButton(
                  color: AppColors.redColor,
                  title: Translate.subscribe.tr,
                  radius: 30,
                  onTap: () async => await controller.onTapSubscribe(context),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
