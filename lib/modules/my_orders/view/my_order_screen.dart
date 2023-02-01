import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/components/custom_appbar.dart';
import 'package:imtnan/core/utils/app_colors.dart';
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
      appBar: CustomAppBar(title: Translate.myOrders.name.tr,showBackButton: true),
      body: controller.obx(
        (data) {
          final orders = data ?? [];
          return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders.elementAt(index);
              return Column(
                children: [
                  OrderDataWidget(
                    order: order,
                    orderDetailsAction: () => controller.orderDetailsAction(order),
                    trackOrderAction: () => controller.trackOrderAction(order),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: DottedLine(dashColor: AppColors.redColor),
                  )
                ],
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
