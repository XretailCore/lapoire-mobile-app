import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/localization/translate.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/utils/routes.dart';

class CancelOrderController extends GetxController {
  final cancelReasonTextController = TextEditingController(text: '');
  final selectedReason = CancelReasonLookupModel().obs;
  final cancelReasonsMenu = <CancelReasonLookupModel>[].obs;

  @override
  void onReady() {
    super.onReady();
    getReasonsList();
  }

  Future<void> getReasonsList() async {
    await HelperFunctions.errorRequestsSnakBarHandler<
        List<CancelReasonLookupModel>>(
      Get.context!,
      loadingFunction: () async {
        final cancelReasonsList =
            await LinkTspApi.instance.lookUp.getCancelReasonLookup();
        cancelReasonsMenu.addAll(cancelReasonsList);
        if (cancelReasonsMenu.isNotEmpty) {
          selectedReason.value = cancelReasonsMenu.first;
        }
        return cancelReasonsList;
      },
    );
  }

  Future<void> cancelOrderAction(
      {required BuildContext context,
      required bool isCheckout,
      required OrderDetailsModel orderDetailsModel}) async {
    await HelperFunctions.errorRequestsSnakBarHandler<void>(context,
        loadingFunction: () async {
      final userId = Get.find<UserSharedPrefrenceController>().getUserId;
      final orderId = orderDetailsModel.id;
      Get.back();
      await LinkTspApi.instance.cancelOrder.cancelOrder(
        cancelReasonModel: CancelReasonModel(
          customerId: userId,
          reasonId: selectedReason.value.id,
          orderId: orderId,
          content: cancelReasonTextController.text,
        ),
      );
    }, onSuccessFunction: (_) async {
      cancelReasonTextController.clear();
      if (!isCheckout) {
        Get.back();
      } else {
        Get.offAllNamed(Routes.dashboard);
      }
      HelperFunctions.showSnackBar(
        context: context,
        message: Translate.cancelOrderSuccessMsg.name.tr,
        color: Theme.of(context).primaryColor,
      );
    });
  }

  @override
  void onClose() {
    cancelReasonTextController.dispose();
    selectedReason.close();
    cancelReasonsMenu.close();
    super.onClose();
  }
}
