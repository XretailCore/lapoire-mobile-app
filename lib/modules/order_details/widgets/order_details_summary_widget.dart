import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/theme.dart';
import '../controllers/order_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsSummaryWidget extends GetView<OrderDetailsController> {
  const OrderDetailsSummaryWidget({Key? key, required this.orderDetailsModel})
      : super(key: key);
  final OrderDetailsModel orderDetailsModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(243, 243, 243, 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              Translate.orderSummary.tr,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            SummaryInfoWidget(
                title: "${Translate.itemsPrice.name.tr} ",
                subTitle: orderDetailsModel.subTotal.toString()),
            const SizedBox(height: 8),
            SummaryInfoWidget(
                title: "${Translate.shipmentfees.name.tr} ",
                subTitle: orderDetailsModel.shipmentCost.toString()),
            const SizedBox(height: 8),
            SummaryInfoWidget(
                title: "${Translate.cashOnDeliveryFees.name.tr} ",
                subTitle: orderDetailsModel.codFee.toString()),
            const SizedBox(height: 8),
            SummaryInfoWidget(
                title: "${Translate.totalAmount.name.tr} :",
                subTitle: orderDetailsModel.total.toString()),
          ],
        ),
      ),
    );
  }
}

class PaymentSummaryWidget extends GetView<OrderDetailsController> {
  const PaymentSummaryWidget({Key? key, required this.orderDetailsModel})
      : super(key: key);
  final OrderDetailsModel orderDetailsModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(243, 243, 243, 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PaymentSummaryInfoWidget(
              title: "${Translate.payment.name.tr} :",
              subTitle: orderDetailsModel.paymentType ?? "",
            ),
            const SizedBox(height: 8),
            PaymentSummaryInfoWidget(
              title: "${Translate.status.name.tr} :",
              subTitle: orderDetailsModel.orderStatus ?? "",
              textColor: CustomThemes.appTheme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryInfoWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color? textColor;
  const SummaryInfoWidget({
    Key? key,
    required this.title,
    required this.subTitle,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomText(
            title,
            softWrap: true,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: textColor ?? Colors.grey,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        CustomText(
          "$subTitle  ${Translate.egp.tr}",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: textColor ?? Colors.grey,
          ),
        ),
      ],
    );
  }
}

class PaymentSummaryInfoWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color? textColor;
  const PaymentSummaryInfoWidget({
    Key? key,
    required this.title,
    required this.subTitle,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: textColor ?? Colors.grey,
            fontSize: 13,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CustomText(
            subTitle,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: textColor ?? Colors.grey,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}
