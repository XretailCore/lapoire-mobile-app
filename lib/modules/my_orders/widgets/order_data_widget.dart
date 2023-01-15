import 'package:flutter/material.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/utils/theme.dart';
import 'buttons_row_widget.dart';
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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: CustomThemes.appTheme.primaryColor,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: AlignmentDirectional.topStart,
            child: DataColumnWidget(
              orderDate: order.date,
              orderNumber: order.orderNo,
              totalAmount: order.total,
              orderStatus: order.orderStatus,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ButtonsRowWidget(
              orderDetailsAction: orderDetailsAction,
              orderStatus: order.orderStatus,
              trackOrderAction: trackOrderAction,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: (order.orderStatus == "New" ||
                      order.orderStatus == "Store" ||
                      order.orderStatus == "جديد" ||
                      order.orderStatus == "في المخزن")
                  ? CustomThemes.appTheme.primaryColor
                  : const Color.fromRGBO(237, 151, 32, 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  order.orderStatus,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
