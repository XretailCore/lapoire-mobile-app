import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/data/exception_api.dart';
import '../../../core/components/text_button_widget.dart';
import 'package:linktsp_api/linktsp_api.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/utils/routes.dart';
import '../../../core/utils/strings.dart';
import '../../../core/utils/theme.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../models/payment_frame_model.dart';

class CreditCardController extends GetxController {
  PaymentFrameModel? paymentModel;
  FrameConfigModel? frameConfigModel;
  WebViewController? webViewController;
  double? finalAmount = 0;
  String? merchantGuid = '';

  int? paymentOptionID = 0;
  final letter = '\\"';
  String? json;
  String functionBody1 = "COWPAYOTPDIALOG.init()";
  String functionBody2 = "COWPAYOTPDIALOG.load(token)";
  CowpayConfirmModel cowpayConfirmModel = CowpayConfirmModel();
  final DashboardController dashboardController =
      Get.find<DashboardController>();
  @override
  void onInit() {
    super.onInit();
    final arguments = (Get.arguments ?? {}) as Map;
    paymentModel = arguments[Arguments.paymentFrameModel] as PaymentFrameModel?;
    paymentOptionID = arguments[Arguments.paymentOptionId];
    finalAmount = arguments[Arguments.finalAmount];
    merchantGuid = arguments[Arguments.merchantGuid];
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
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          TextButtonWidget(
            onPressed: () {
              Get.back();
            },
            backgroundColor: CustomThemes.appTheme.primaryColor,
            text: Translate.done.tr,
          ),
        ],
      ),
    );
  }

  void createSuccessDialog(String orderId) {
    var orderCode = orderId.padLeft(9, '0');
    Get.defaultDialog(
      barrierDismissible: false,
      onWillPop: () async => false,
      title: Translate.confirmation.tr,
      content: Column(
        children: [
          CustomText(
            Translate.thankYouForYourOrder.tr,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          FaIcon(
            FontAwesomeIcons.solidCircleCheck,
            color: CustomThemes.appTheme.primaryColor,
            size: 45,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomText('${Translate.yourOrderNumberIs.tr} : $orderCode',
              style: const TextStyle(fontSize: 14)),
          const SizedBox(
            height: 10,
          ),
          TextButtonWidget(
            onPressed: () {
              Get.back();
            },
            backgroundColor: CustomThemes.appTheme.primaryColor,
            text: Translate.done.tr,
          ),
        ],
      ),
    );
  }

  Future<void> fawrySuccess() async {
    dashboardController.updateIndex(0);
    Get.offAllNamed(Routes.dashboard);
  }

  Future<void> confirmCowpay() async {
    try {
      cowpayConfirmModel = await LinkTspApi.instance.checkOut
          .cowpayConfirm(ccOrderId: merchantGuid ?? '');
      if (cowpayConfirmModel.action?.toLowerCase() == 'confirmed') {
        dashboardController.updateIndex(0);
        Get.offAllNamed(Routes.dashboard);
        createSuccessDialog(cowpayConfirmModel.orderId ?? '');
      } else {
        dashboardController.updateIndex(0);
        Get.offAllNamed(Routes.dashboard);
        createRejectedDialog();
      }
    } on ExceptionApi catch (e) {
      HelperFunctions.showSnackBar(
          message: e.toString(), context: Get.context!);
    } catch (e) {
      HelperFunctions.showSnackBar(
          message: Translate.error.tr, context: Get.context!);
    }
  }

  void createFawryDialog() {
    Get.defaultDialog(
      onWillPop: () async => false,
      barrierDismissible: false,
      title: Translate.fawryId.tr,
      content: Column(
        children: [
          CustomText(
            frameConfigModel?.fawryId.toString(),
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 20,
          ),
          TextButtonWidget(
            onPressed: () {
              Get.back();
            },
            backgroundColor: CustomThemes.appTheme.primaryColor,
            text: Translate.done.tr,
          ),
        ],
      ),
    );
  }
}
