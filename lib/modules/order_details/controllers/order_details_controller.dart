import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/utils/routes.dart';
import 'cancel_order_controller.dart';
import 'feedback_order_controller.dart';
import 'package:linktsp_api/linktsp_api.dart';
import '../../../core/utils/strings.dart';
import '../../my_orders/controller/my_orders_controller.dart';
import '../widgets/order_details_cancel_dialog.dart';
import '../widgets/order_details_feedback_dialog.dart';

class OrderDetailsController extends GetxController
    with StateMixin<OrderDetailsModel?> {
  RxBool isCheckoutCancel = false.obs;

  @override
  void onReady() {
    super.onReady();
    getOrderDetails();
  }

  Future<void> getOrderDetails() async {
    await HelperFunctions.errorRequestsHandler<OrderDetailsModel>(
      loadingFunction: () async {
        change(null, status: RxStatus.loading());
        final args = (Get.arguments ?? {}) as Map;
        final orderNo = args[Arguments.orderNo] as String;
        isCheckoutCancel.value = args[Arguments.isCheckoutCancel] ?? false;
        final orderDetailsModel = await LinkTspApi.instance.order
            .getOrderDetails(orderCode: orderNo, version: 3);
        return orderDetailsModel;
      },
      onSuccessFunction: (orderDetailsModel) async {
        change(orderDetailsModel, status: RxStatus.success());
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

  Future<void> openCancelDialog(
      BuildContext context, OrderDetailsModel orderDetailsModel) async {
    final cancelOrderController = Get.find<CancelOrderController>();
    if (cancelOrderController.cancelReasonsMenu.isEmpty) {
      await Get.delete<CancelOrderController>();
    }
    await openCancelOrderSheet(context,
        isCheckoutCancel: isCheckoutCancel.value,
        orderDetailsModel: orderDetailsModel);
    if (!isCheckoutCancel.value) {
      final myOrdersController = Get.find<MyOrdersController>();
      return await myOrdersController.getOrders();
    }
  }

  Future<void> openFeedbackDialog(
      BuildContext context, OrderDetailsModel orderDetailsModel) async {
    final cancelOrderController = Get.find<FeedbackOrderController>();
    if (cancelOrderController.feedbackMenu.isEmpty) {
      await Get.delete<FeedbackOrderController>();
    }
    await openFeedbackOrderSheet(context, orderDetailsModel: orderDetailsModel);
  }
  void trackOrder(OrderModel orderModel) {
    Get.toNamed(Routes.trackOrder, arguments: {
      Arguments.orderNo: orderModel.orderNo,
      Arguments.orderId: orderModel.id
    });
  }
}
