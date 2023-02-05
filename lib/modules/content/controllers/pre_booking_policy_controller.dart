import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/localization/translate.dart';
import '../../../core/utils/helper_functions.dart';
import '../view/pre_booking_poilcy_widget.dart';

class PreBookingPolicyController extends GetxController
    with StateMixin<String> {
  final RxBool _isAgree = false.obs;
  bool get isAgree => _isAgree.value;
  set isAgree(bool v) => _isAgree.value = v;

  @override
  void onReady() {
    super.onReady();
    getPreBookingPolicy();
  }

  Future<void> onTapAgree(bool isAgree) async {
    if (!isAgree) {
      return;
    }
    Get.back();
  }

  Future<void> getPreBookingPolicy() async {
    await HelperFunctions.errorRequestsHandler<String>(
      loadingFunction: () async {
        change(null, status: RxStatus.loading());
        final policy = await LinkTspApi.instance.menu.getPreOrderPolicy();
        return policy;
      },
      onSuccessFunction: (policy) async {
        change(policy, status: RxStatus.success());
      },
      onDioErrorFunction: (e, m) async {
        change(null, status: RxStatus.error(m));
      },
      onUnexpectedErrorFunction: (e, m) async {
        change(null, status: RxStatus.error(m));
      },
      onApiErrorFunction: (e, m) async {
        change(null, status: RxStatus.error(e.message.toString()));
      },
    );
  }

  Future<bool> showPreBookingPolicy(BuildContext context) async {
    await Get.defaultDialog(
          radius: 4,
          title: Translate.prebookingPolicy.tr,
          titleStyle: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w700),
          content: const PreBookingPolicyWidget(),
        ) ??
        false;

    return isAgree;
  }

  @override
  void onClose() {
    _isAgree.close();
    super.onClose();
  }
}
