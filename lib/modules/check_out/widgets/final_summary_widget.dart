import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/localization/translate.dart';
import '../controllers/shipping_information_controller.dart';
import 'next_widget.dart';
import 'row_checkout_summary_information_widget.dart';

class FinalCheckoutSummaryWidget
    extends GetView<ShippingInformationController> {
  final Color? color;
  final String? buttonName;
  final List<Summary> summary;
  const FinalCheckoutSummaryWidget(
      {Key? key,
      this.color,
      required this.onTapNext,
      this.buttonName,
      required this.summary})
      : super(key: key);
  final void Function(bool isPreOrder) onTapNext;
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return controller.obx(
      (checkoutSummary) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: color ?? Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              color: const Color.fromRGBO(243, 243, 243, 1),
              padding: const EdgeInsets.all(15),
              child: Column(children: [
                ...summary
                    .map(
                      (summary) => RowCheckOutSummaryInformationWidget(
                        title: summary.title ?? '',
                        value:
                            '${summary.additionalInfo != null ? '${summary.additionalInfo} ' : ''} ${summary.value} ${summary.currencySymbol ?? ''}',
                      ),
                    )
                    .toList()
              ]),
            ),
            const SizedBox(height: 10),
            Center(
              child: TextButtonWidget(
                backgroundColor: primaryColor,
                height: 45,
                width: 240,
                text: buttonName ?? Translate.next.tr,
                onTap: () {
                  final isPreOrder =
                      checkoutSummary?.configDeliveryPeriod?.preOrder ?? false;

                  onTapNext(isPreOrder);
                },
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
      onLoading: const SizedBox(),
    );
  }
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}
