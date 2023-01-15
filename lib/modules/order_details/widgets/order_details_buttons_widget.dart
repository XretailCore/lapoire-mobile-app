import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          CustomBorderButton(
            title: Translate.addFeedback.name.tr,
            color: CustomThemes.appTheme.primaryColor,
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
                    color: Colors.white,
                    textColor: CustomThemes.appTheme.primaryColor,
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
