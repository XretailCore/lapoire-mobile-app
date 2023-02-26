import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/components/custom_button.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/theme.dart';
import '../controllers/order_details_controller.dart';

class OrderDetailsButtonsWidget extends GetView<OrderDetailsController> {
  final OrderDetailsModel orderDetailsModel;

  const OrderDetailsButtonsWidget({Key? key, required this.orderDetailsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CustomBorderButton(
            radius: 30.0,
            title: Translate.trackOrder.name.tr,
            color: AppColors.redColor,
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            onTap: () => controller.trackOrder(
              OrderModel(
                id: orderDetailsModel.id,
                orderNo: orderDetailsModel.orderNo,
              ),
            ),
          ),
          const SizedBox(height: 8),
          CustomBorderButton(
            radius: 30.0,
            title: Translate.addFeedback.name.tr,
            borderColor: CustomThemes.appTheme.primaryColor,
            color: Colors.transparent,
            textColor: CustomThemes.appTheme.primaryColor,
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            onTap: () =>
                controller.openFeedbackDialog(context, orderDetailsModel),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Offstage(
                  offstage: !(orderDetailsModel.orderStatus == "New" ||
                      orderDetailsModel.orderStatus == "Store" ||
                      orderDetailsModel.orderStatus == "جديد" ||
                      orderDetailsModel.orderStatus == "في المخزن"),
                  child: CustomBorderButton(
                    title: Translate.cancel.name.tr,
                    radius: 30.0,
                    color: CustomThemes.appTheme.primaryColor,
                    textColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10.0),
                    onTap: () =>
                        controller.openCancelDialog(context, orderDetailsModel),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
