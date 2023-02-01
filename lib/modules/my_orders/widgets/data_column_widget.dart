import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/theme.dart';

class DataColumnWidget extends StatelessWidget {
  final String? orderNumber;
  final String? orderDate;
  final double? totalAmount;
  final String? orderStatus;
  const DataColumnWidget({
    Key? key,
    this.orderNumber,
    this.orderDate,
    this.totalAmount,
    this.orderStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 5,
        ),
        OrdersInfoWidget(
          title: '${Translate.orderNumber.name.tr} :',
          subTitle: "#$orderNumber",
        ),
        const SizedBox(
          height: 5,
        ),
        OrdersInfoWidget(
          title: '${Translate.orderDate.name.tr} :',
          subTitle: orderDate ?? '',
        ),
        const SizedBox(
          height: 5,
        ),
        OrdersInfoWidget(
          title: '${Translate.totalAmount.name.tr} :',
          subTitle: totalAmount.toString() + ' ' + Translate.egp.tr,
        ),
      ],
    );
  }
}

class OrdersInfoWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color? textColor;
  const OrdersInfoWidget({
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
            '$title $subTitle',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: CustomThemes.appTheme.primaryColor,
              fontSize: 14,
            ),
            maxLines: 2,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
