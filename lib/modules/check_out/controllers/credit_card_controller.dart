import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import 'package:linktsp_api/linktsp_api.dart';
import '../../../core/utils/routes.dart';
import '../../../core/utils/strings.dart';
import '../../../core/utils/theme.dart';
import '../../dashboard/controller/dashboard_controller.dart';

class CreditCardController extends GetxController {
  PaymentFrameModel? paymentModel;

  void checkPaymentSuccessUrl(String url) {
    if (url
            .toLowerCase()
            .contains(paymentModel?.confirmationPage?.toLowerCase() ?? '') &&
        url.toLowerCase().contains(paymentModel?.domain?.toLowerCase() ?? '')) {
      var dashboardController = Get.find<DashboardController>();
      dashboardController.updateIndex(0);
      // Get.offAllNamed(Routes.dashboard);
      navigateToConfirmationPage(getOrderIdFromUrl(url));
    } else if (url
            .toLowerCase()
            .contains(paymentModel?.rejectionPage?.toLowerCase() ?? '') &&
        url.toLowerCase().contains(paymentModel?.domain?.toLowerCase() ?? '')) {
      var dashboardController = Get.find<DashboardController>();
      dashboardController.updateIndex(0);
      Get.offAllNamed(Routes.dashboard);
      createRejectedDialog();
    }
  }

  void createRejectedDialog() {
    Get.defaultDialog(
      onWillPop: () async => false,
      barrierDismissible: false,
      title: Translate.rejected.tr,
      content: Column(
        children: [
          CustomText(
            Translate.transactionFailed.tr,
            style: TextStyle(fontSize:(Platform.isIOS) ? 20.sm : 18.sm),
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => Get.back(),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(CustomThemes.appTheme.primaryColor),
            ),
            child: CustomText(
              Translate.done.tr,
              style:const TextStyle(color: Colors.white),

            ),
          ),
        ],
      ),
    );
  }

  void navigateToConfirmationPage(String orderId) {
    var orderCode = orderId.padLeft(9, '0');
    Get.offAndToNamed(Routes.checkoutConfirmationScreen,
        arguments: {Arguments.orderNo: orderCode});
  }

  String getOrderIdFromUrl(String url) {
    var orderId = url.split('=')[1];
    return orderId;
  }
}
