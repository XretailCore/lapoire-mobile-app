import 'package:imtnan/core/utils/app_colors.dart';
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
    final primary = CustomThemes.appTheme.primaryColor;
    var percentage = orderDetailsModel.personalDiscountAmount !=null && orderDetailsModel.personalDiscountAmount !=0.0?(orderDetailsModel.personalDiscountAmount! /
        orderDetailsModel.total!.toDouble() *
        100):0;
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: AppColors.highlighter,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (orderDetailsModel.codFee != 0.0&& orderDetailsModel.codFee!=null)
            SummaryInfoWidget(
              title: Translate.cashOnDeliveryFees.name.tr,
              textColor: primary,
              subTitle: orderDetailsModel.codFee!.toStringAsFixed(
                  orderDetailsModel.codFee!.truncateToDouble() ==
                          orderDetailsModel.codFee
                      ? 0
                      : 1),
            ),
          if (orderDetailsModel.subTotal != 0.0 && orderDetailsModel.subTotal!=null)
            SummaryInfoWidget(
              title:
                  "${Translate.subtotal.name.tr} (${orderDetailsModel.productsCount} ${Translate.items.tr})",
              textColor: primary,
              subTitle: orderDetailsModel.subTotal!.toStringAsFixed(
                  orderDetailsModel.subTotal!.truncateToDouble() ==
                          orderDetailsModel.subTotal!
                      ? 0
                      : 1),
            ),
          if (orderDetailsModel.personalDiscountAmount != 0.0 && orderDetailsModel.personalDiscountAmount!=null)
            SummaryInfoWidget(
                title: Translate.personalDiscountAmount.tr,
                textColor: primary,
                subTitle:
                    "${percentage.toStringAsFixed(percentage.truncateToDouble() == percentage ? 0 : 1)} %   ${orderDetailsModel.personalDiscountAmount!.toStringAsFixed(orderDetailsModel.personalDiscountAmount!.truncateToDouble() == orderDetailsModel.personalDiscountAmount ? 0 : 1)}"),
          if (orderDetailsModel.shipmentCost != 0.0)
            SummaryInfoWidget(
              title: Translate.shipmentfees.name.tr,
              textColor: primary,
              subTitle: orderDetailsModel.shipmentCost!.toStringAsFixed(
                  orderDetailsModel.shipmentCost!.truncateToDouble() ==
                          orderDetailsModel.shipmentCost
                      ? 0
                      : 1),
            ),
          if (orderDetailsModel.triggeredCartAmountDiscountAmount != 0.0 && orderDetailsModel.triggeredCartAmountDiscountAmount !=null)
            SummaryInfoWidget(
              title: Translate.cartDiscountAmount.tr,
              textColor: primary,
              subTitle: orderDetailsModel.triggeredCartAmountDiscountAmount!
                  .toStringAsFixed(orderDetailsModel
                              .triggeredCartAmountDiscountAmount!
                              .truncateToDouble() ==
                          orderDetailsModel.triggeredCartAmountDiscountAmount
                      ? 0
                      : 1),
            ),

          if (orderDetailsModel.couponDiscount != 0.0 && orderDetailsModel.couponDiscount !=null)
            SummaryInfoWidget(
              title: Translate.couponDiscountAmount.tr,
              textColor: primary,
              subTitle: orderDetailsModel.couponDiscount!
                  .toStringAsFixed(orderDetailsModel
                  .couponDiscount!
                  .truncateToDouble() ==
                  orderDetailsModel.couponDiscount
                  ? 0
                  : 1),
            ),
          if (orderDetailsModel.triggeredProfileBasedDiscountAmount != 0.0 && orderDetailsModel.triggeredProfileBasedDiscountAmount!=null)
            SummaryInfoWidget(
              title: Translate.profileDiscountAmount.tr,
              textColor: primary,
              subTitle: orderDetailsModel.triggeredProfileBasedDiscountAmount!
                  .toStringAsFixed(orderDetailsModel
                              .triggeredProfileBasedDiscountAmount!
                              .truncateToDouble() ==
                          orderDetailsModel.triggeredProfileBasedDiscountAmount
                      ? 0
                      : 1),
            ),
          Divider(color: primary),
          Row(
            children: [
              Expanded(
                child: CustomText(
                  "${Translate.total.name.tr}:",
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: primary,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              if (orderDetailsModel.total != 0.0)
                CustomText(
                  "${orderDetailsModel.total!.toStringAsFixed(orderDetailsModel.total!.truncateToDouble() == orderDetailsModel.total ? 0 : 1)} ${Translate.egp.tr}",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: AppColors.redColor,
                    fontSize: 18.0,
                  ),
                ),
            ],
          ),
        ],
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
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PaymentSummaryInfoWidget(
            title: "${Translate.payment.name.tr} :",
            subTitle: orderDetailsModel.paymentType ?? "",
            textColor: AppColors.redColor,
          ),
          PaymentSummaryInfoWidget(
            title: "${Translate.status.name.tr} :",
            subTitle: orderDetailsModel.orderStatus ?? "",
            textColor: CustomThemes.appTheme.primaryColor,
          ),
        ],
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
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
              color: textColor ?? Colors.grey,
            ),
          ),
        ],
      ),
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
            fontWeight: FontWeight.w700,
            color: textColor ?? Colors.grey,
            fontSize: 13,
          ),
        ),
        const SizedBox(width: 2),
        CustomText(
          subTitle,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: textColor ?? Colors.grey,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
