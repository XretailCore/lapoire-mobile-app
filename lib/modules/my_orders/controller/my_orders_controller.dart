import '../../../core/utils/helper_functions.dart';

import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/routes.dart';
import '../../../core/utils/strings.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';

class MyOrdersController extends GetxController
    with StateMixin<List<OrderModel>> {
  @override
  void onReady() {
    super.onReady();
    getOrders();
  }

  Future<void> getOrders() async {
    await HelperFunctions.errorRequestsHandler<List<OrderModel>>(
      loadingFunction: () async {
        change(null, status: RxStatus.loading());
        final userId = Get.find<UserSharedPrefrenceController>().getUserId;
        final orders =
            await LinkTspApi.instance.order.getOrders(customerId: userId!);
        return orders;
      },
      onSuccessFunction: (orders) async {
        if (orders.isEmpty) {
          change(orders, status: RxStatus.empty());
          return;
        }
        change(orders, status: RxStatus.success());
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

  void orderDetailsAction(OrderModel orderModel) {
    Get.toNamed(Routes.orderDetails, arguments: {
      Arguments.orderNo: orderModel.orderNo,
      Arguments.orderId: orderModel.id
    });
  }

  void trackOrderAction(OrderModel orderModel) {
    Get.toNamed(Routes.trackOrder, arguments: {
      Arguments.orderNo: orderModel.orderNo,
      Arguments.orderId: orderModel.id
    });
  }
}
