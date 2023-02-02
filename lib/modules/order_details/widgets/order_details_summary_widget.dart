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
          SummaryInfoWidget(
              title:
                  "${Translate.subtotal.name.tr} (${orderDetailsModel.productsCount} ${Translate.items.tr})",
              textColor: primary,
              subTitle: orderDetailsModel.subTotal.toString()),
          const SizedBox(height: 8),
          SummaryInfoWidget(
              title: "${Translate.profileBasedDiscount.name.tr} ",
              textColor: primary,
              subTitle:
                  "${orderDetailsModel.personalDiscountAmount!=null ||orderDetailsModel.personalDiscountAmount==0.0?(orderDetailsModel.personalDiscountAmount! / orderDetailsModel.total!.toDouble() * 100).toStringAsFixed(2):"0"} %   ${orderDetailsModel.personalDiscountAmount.toString()}"),
          const SizedBox(height: 8),
          SummaryInfoWidget(
              title: "${Translate.cashOnDeliveryFees.name.tr} ",
              textColor: primary,
              subTitle: orderDetailsModel.codFee.toString()),
          const SizedBox(height: 8),
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
              CustomText(
                "${orderDetailsModel.total.toString()} ${Translate.egp.tr}",
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
          const SizedBox(height: 8),
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
            fontWeight: FontWeight.w700,
            color: textColor ?? Colors.grey,
            fontSize: 13,
          ),
        ),
        const SizedBox(width: 10),
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
