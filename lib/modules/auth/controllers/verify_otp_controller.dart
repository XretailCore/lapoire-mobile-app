import 'dart:async';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/utils/routes.dart';
import '../../cart/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../dashboard/controller/dashboard_controller.dart';

class VerifyOtpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final otpTEC = TextEditingController(text: '');

  static const _waitingTomeToResendSms = 120;
  final _counter = Rx<int>(_waitingTomeToResendSms);

  ActivationCodeModel activationCodeModel = ActivationCodeModel();
  ActivationCodeModel activationModel = ActivationCodeModel();

  set counter(int timeOnSecond) => _counter.value = timeOnSecond;
  int get counter => _counter.value;

  Timer? _timer;

  bool get isCounterEqualZero => counter == 0;

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

  Future<void> sendOtpToMobile(BuildContext context) async {
    final userSharedPrefrenceController =
        Get.find<UserSharedPrefrenceController>();
    var isMobile =
        double.tryParse(userSharedPrefrenceController.getUserEmail ?? '');
    if (isMobile != null) {
      activationCodeModel = ActivationCodeModel(
          mobile: userSharedPrefrenceController.getUserEmail);
    } else {
      activationCodeModel = ActivationCodeModel(
          email: userSharedPrefrenceController.getUserEmail);
    }
userSharedPrefrenceController.getUserId;

    await HelperFunctions.errorRequestsSnakBarHandler<bool?>(
      context,
      loadingFunction: () async {
        var s = await LinkTspApi.instance.account
            .resendVerificationCode(activationCodeModel: activationCodeModel);
        return s;
      },
    );
  }

  Future<void> onTapResendOtp(BuildContext context) async {
    await sendOtpToMobile(context);
    startTimer();
  }

  Future<void> onTapVerify(BuildContext context) async {
    final userSharedPrefrenceController =
        Get.find<UserSharedPrefrenceController>();
    await HelperFunctions.errorRequestsSnakBarHandler<UserModel>(
      context,
      loadingFunction: () async {
        var isMobile =
            double.tryParse(userSharedPrefrenceController.getUserEmail ?? '');
        if (isMobile != null) {
          activationModel = ActivationCodeModel(
              activationCode: otpTEC.text,
              mobile: userSharedPrefrenceController.getUserEmail);
        } else {
          activationModel = ActivationCodeModel(
              activationCode: otpTEC.text,
              email: userSharedPrefrenceController.getUserEmail);
        }

        final userData = await LinkTspApi.instance.account
            .verify(activationCodeModel: activationModel, version: 3);
        return userData;
      },
      onSuccessFunction: (userData) async {
        userSharedPrefrenceController.cacheUserData(
          emailAddress: userData.email,
          firstName: userData.firstName,
          idUser: userData.id,
          isActive: userData.isActive,
          lastName: userData.lastName,
          mobile: userData.mobile,
        );
        await _sendGuestUserCart(
            context, userSharedPrefrenceController.getUserId!);
        userSharedPrefrenceController.removeCart();
        final cartController = Get.find<CartController>();
        await cartController.getCart();
        final dashboardController = Get.find<DashboardController>();
        dashboardController.updateIndex(0);
        Get.offAllNamed(Routes.dashboard);
      },
    );
  }

  Future<void> _sendGuestUserCart(BuildContext context, int userId) async {
    await HelperFunctions.errorRequestsSnakBarHandler<bool?>(
      context,
      loadingFunction: () async {
        final guestCart = Get.find<UserSharedPrefrenceController>().getAllCart;
        return await LinkTspApi.instance.cart
            .addToCart(cartSkuModel: guestCart, customerId: userId);
      },
    );
  }

  @override
  void onClose() {
    otpTEC.dispose();
    _counter.close();
    _timer?.cancel();
    super.onClose();
  }
}
