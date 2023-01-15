import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/appbar_widget.dart';
import '../../../core/components/custom_empty_widget.dart';
import '../../../core/components/custom_error_widget.dart';
import '../../../core/components/imtnan_loading_widget.dart';
import '../../../core/localization/translate.dart';
import '../controller/my_orders_controller.dart';
import '../widgets/order_data_widget.dart';

class MyOrdersScreen extends GetView<MyOrdersController> {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: Translate.myOrders.name.tr),
      body: controller.obx(
        (data) {
          final orders = data ?? [];
          return GridView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: orders.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 2.1 / 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final order = orders.elementAt(index);
              return OrderDataWidget(
                order: order,
                orderDetailsAction: () => controller.orderDetailsAction(order),
                trackOrderAction: () => controller.trackOrderAction(order),
              );
            },
          );
        },
        onEmpty: CustomEmptyWidget(
          emptyLabel: Translate.noOrdersFound.name.tr,
        ),
        onLoading: const CustomLoadingWidget(),
        onError: (e) => CustomErrorWidget(
          errorText: e,
          onReload: controller.getOrders,
        ),
      ),
    );
  }
}
