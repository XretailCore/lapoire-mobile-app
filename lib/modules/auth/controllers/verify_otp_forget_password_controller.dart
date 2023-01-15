import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/data/exception_api.dart';
import 'package:linktsp_api/linktsp_api.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/utils/routes.dart';
import 'forget_password_controller.dart';

class VerifyOtpForgetPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final otpTEC = TextEditingController(text: '');

  int? userId;
  static const _waitingTomeToResendSms = 120;
  final _counter = Rx<int>(_waitingTomeToResendSms);
  set counter(int timeOnSecond) => _counter.value = timeOnSecond;
  int get counter => _counter.value;
  Timer? _timer;
  @override
  void onReady() {
    super.onReady();

    _createTimer();
  }

  void _createTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (counter == 0) {
          timer.cancel();
          _timer = null;
        } else {
          counter--;
        }
      },
    );
  }

  void startTimer() {
    counter = _waitingTomeToResendSms;
    _createTimer();
  }

  Future<void> sendOtpToMobile(BuildContext context, String mobile) async {
    await HelperFunctions.errorRequestsSnakBarHandler<bool?>(
      Get.context!,
      loadingFunction: () async {
        return await LinkTspApi.instance.account
            .resendPassword(data: mobile, verifyType: 1);
      },
    );
  }

  Future<void> onTapResendOtp(BuildContext context) async {
    final forgetPasswordController = Get.find<ForgetPasswordController>();
    final mobile = forgetPasswordController.mobile;
    await sendOtpToMobile(context, mobile);
    startTimer();
  }

  Future<void> onTapVerify(BuildContext context) async {
    final forgetPasswordController = Get.find<ForgetPasswordController>();
    final mobile = forgetPasswordController.mobile;
    try {
      userId = await LinkTspApi.instance.account
          .confirmPassword(data: mobile, verifyType: 1, password: otpTEC.text);
      Get.offAllNamed(Routes.newPasswordScreen);
    } on ExceptionApi catch (e) {
      HelperFunctions.showSnackBar(
          message: e.message.toString(), context: context);
    } catch (e) {
      HelperFunctions.showSnackBar(message: e.toString(), context: context);
    }
  }

  bool get isCounterEqualZero => counter == 0;
  @override
  void onClose() {
    otpTEC.dispose();
    _counter.close();
    _timer?.cancel();
    super.onClose();
  }
}
