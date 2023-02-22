import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'signin_controller.dart';
import 'package:linktsp_api/data/account/models/register_model_v3.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/localization/translate.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/utils/routes.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final firstNameTEC = TextEditingController(text: ''),
      lastNameTEC = TextEditingController(text: ''),
      emailTEC = TextEditingController(text: ''),
      mobileTEC = TextEditingController(text: ''),
      confirmPasswordTEC = TextEditingController(text: ''),
      passwordTEC = TextEditingController(text: '');
  Rxn<DateTime> selectedDate = Rxn<DateTime>() ;
  bool _isAcceptedPrivacy = false;

  bool get _isNotAcceptedPrivacy => !_isAcceptedPrivacy;

  ///1 male 2 female
  int? selectedGender;

  Future<void> onTapSignup(BuildContext context) async {
    final isInputsInValid = !((formKey.currentState?.validate()) ?? false);
    if (isInputsInValid) {
      return;
    }
    if (_isNotAcceptedPrivacy) {
      HelperFunctions.showSnackBar(
          message: Translate.pleaseAgreeOnTheTermsAndConditionsOfTheApp.tr,
          context: context,
          hasCloseBtn: true);
      return;
    }
    if (_isAcceptedPrivacy) {
      await HelperFunctions.errorRequestsSnakBarHandler<RegisterModelV3>(
        context,
        hasCloseBtn: true,
        loadingFunction: () async {
          String? deviceId = await HelperFunctions.getDeviceToken();

          final registerModel = RegisterModelV3(
            password: passwordTEC.text,
            conditionAgreement: _isAcceptedPrivacy,
            deviceId: deviceId,
            firstName: firstNameTEC.text.trim(),
            lastName: lastNameTEC.text.trim(),
            email: emailTEC.text,
            day: selectedDate.value?.day,
            month: selectedDate.value?.month,
            year: selectedDate.value?.year,
            mobile: mobileTEC.text,
          );

          final registerModelV3 = await LinkTspApi.instance.account
              .registerV3(registerModel: registerModel);
          return registerModelV3;
        },
        onSuccessFunction: (registerModelV3) async {
          final isVerifiedAccount = registerModelV3.isActive ?? false;
          final userSharedPrefrenceController =
              Get.find<UserSharedPrefrenceController>();
          if (isVerifiedAccount) {
            final userData = UserModel(
              email: registerModelV3.email,
              firstName: registerModelV3.firstName,
              id: registerModelV3.id!,
              isActive: isVerifiedAccount,
              day: registerModelV3.day,
              month: registerModelV3.month,
              year: registerModelV3.year,
              lastName: registerModelV3.lastName,
              mobile: registerModelV3.mobile,
            );
            final signinController = Get.find<SigninController>();
            await signinController.afterSignin(userData);
            await completedRegistrationFBEvent();

            Get.offAllNamed(Routes.dashboard);
          } else {
            userSharedPrefrenceController.setUserEmail = emailTEC.text;
            Get.back();
            Get.toNamed(Routes.verifyOtpScreen);
          }
        },
      );
    }
  }

  final facebookAppEvents = FacebookAppEvents();

  Future<void> completedRegistrationFBEvent() async {
    facebookAppEvents.logCompletedRegistration(registrationMethod: 'Email');
  }

  Future<void> onChangePrivacy(bool isChecked) async {
    _isAcceptedPrivacy = isChecked;
  }

  @override
  void onClose() {
    firstNameTEC.dispose();
    lastNameTEC.dispose();
    emailTEC.dispose();
    mobileTEC.dispose();
    passwordTEC.dispose();
    ScaffoldMessenger.of(Get.context!).clearSnackBars();
    super.onClose();
  }
}
