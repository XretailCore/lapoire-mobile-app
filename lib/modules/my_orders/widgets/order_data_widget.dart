import 'package:cowpay/core/helpers/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:imtnan/core/components/custom_button.dart';
import 'package:imtnan/core/localization/translate.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/theme.dart';
import 'data_column_widget.dart';

class OrderDataWidget extends StatelessWidget {
  final VoidCallback? orderDetailsAction;
  final VoidCallback? trackOrderAction;
  final VoidCallback? cancelOrderAction;

  final OrderModel order;

  const OrderDataWidget({
    Key? key,
    required this.order,
    this.orderDetailsAction,
    this.trackOrderAction,
    this.cancelOrderAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: AlignmentDirectional.topStart,
                child: DataColumnWidget(
                  orderDate: order.date,
                  orderNumber: order.orderNo,
                  totalAmount: order.total,
                  orderStatus: order.orderStatus,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 0.4.sw,
                  child: CustomBorderButton(
                    title: Translate.orderDetails.tr,
                    color: AppColors.redColor,
                    radius: 20.0,
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 16.0),
                    onTap: orderDetailsAction,
                  ),
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  width: 0.4.sw,
                  child: CustomBorderButton(
                    title: Translate.trackOrder.tr,
                    color: Colors.white,
                    borderColor: CustomThemes.appTheme.primaryColor,
                    radius: 20.0,
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 16.0),
                    onTap: trackOrderAction,
                    textColor: CustomThemes.appTheme.primaryColor,
                  ),
                ),
              ],
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CustomText(
            order.orderStatus,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: (order.orderStatus == "New" ||
                      order.orderStatus == "Store" ||
                      order.orderStatus == "جديد" ||
                      order.orderStatus == "في المخزن")
                  ? const Color(0xff00BF4C)
                  : const Color.fromRGBO(237, 151, 32, 1),
            ),
          ),
        ),
      ],
    );
  }
}
