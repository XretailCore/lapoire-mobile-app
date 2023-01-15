import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_appbar.dart';
import '../../../core/components/custom_error_widget.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/components/imtnan_loading_widget.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/routes.dart';
import '../../../core/utils/theme.dart';
import '../controllers/order_details_controller.dart';
import '../widgets/order_details_address_widget.dart';
import '../widgets/order_details_buttons_widget.dart';
import '../widgets/order_details_items_widget.dart';
import '../widgets/order_details_summary_widget.dart';

class OrderDetailsScreen extends GetView<OrderDetailsController> {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTitledAppBar(
        title: Translate.orderDetails.name.tr,
        actionsWidget: [
          controller.isCheckoutCancel.value
              ? IconButton(
                  onPressed: () {
                    Get.offAllNamed(Routes.dashboard);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                )
              : Container()
        ],
      ),
      body: controller.obx(
        (orderDetailsModel) => Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  CustomText(
                    orderDetailsModel?.date ?? "",
                    style: TextStyle(
                      color: CustomThemes.appTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  CustomText(
                    "${Translate.orderNo.tr}: ${orderDetailsModel?.orderNo}",
                    style: const TextStyle(
                      color: Color.fromRGBO(237, 151, 32, 1),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView(
                  children: [
                    OrderDetailsItemsWidget(
                        orderDetailsModel: orderDetailsModel!),
                    const SizedBox(height: 8),
                    OrderDetailsAddressWidget(
                        orderDetailsModel: orderDetailsModel),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              PaymentSummaryWidget(orderDetailsModel: orderDetailsModel),
              const SizedBox(height: 8),
              OrderDetailsSummaryWidget(orderDetailsModel: orderDetailsModel),
              const SizedBox(height: 8),
              OrderDetailsButtonsWidget(orderDetailsModel: orderDetailsModel),
            ],
          ),
        ),
        onLoading: const CustomLoadingWidget(),
        onError: (e) => CustomErrorWidget(
          errorText: e,
          onReload: controller.getOrderDetails,
        ),
      ),
    );
  }
}
