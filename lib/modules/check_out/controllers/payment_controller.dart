import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imtnan/modules/check_out/controllers/locations.dart';
import 'package:linktsp_api/data/exception_api.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/utils/routes.dart';

class PaymentController extends GetxController
    with StateMixin<List<PaymentOptionsModel>> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  set isPreOrder(bool isPreOrder) => _isPreOrder = isPreOrder;
  final UserSharedPrefrenceController _userSharedPrefrenceController =
      Get.find<UserSharedPrefrenceController>();

  bool _isPreOrder = false;
  int? paymentOptionId;
  @override
  void onReady() {
    super.onReady();

    _init();
  }

  void _init() async {
    try {
      change(null, status: RxStatus.loading());
      final payments = await LinkTspApi.instance.checkOut.getPaymentOptions();
      if (payments.isNotEmpty) {
        if (Platform.isAndroid) {
          payments.removeWhere((element) => element.id == 4);
        }
        if (_isPreOrder) {
          payments.removeWhere((element) => element.id == 1);
        }
        paymentOptionId = payments.first.id;
      }
      change(payments, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error());
    }
  }

  void nextBtnAction() async {
    String alertMessage = '';

    try {
      final cartValidate = await LinkTspApi.instance.multiStore.cartValidate(
          customerID: _userSharedPrefrenceController.getUserId!,
          addressId: Locations.locationId ?? 0);
      if (cartValidate.alertMessage != null) {
        for (var i = 0; i < cartValidate.storeCartItems!.length; i++) {
          if (cartValidate.storeCartItems?[i].status != 1) {
            alertMessage +=
                "${cartValidate.storeCartItems?[i].title} : ${cartValidate.storeCartItems?[i].message} ";
          }
        }
        HelperFunctions.showSnackBar(
            message: alertMessage, context: Get.context!);
      } else {
        Get.toNamed(Routes.summaryScreen);
      }
    } on ExceptionApi catch (e) {
      HelperFunctions.showSnackBar(
          message: e.toString(), context: Get.context!);
    } catch (e) {
      change(null, status: RxStatus.error());
    }
  }
}
