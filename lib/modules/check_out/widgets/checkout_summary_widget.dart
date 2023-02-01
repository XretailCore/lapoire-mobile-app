import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/localization/translate.dart';
import '../controllers/customer_summary_controller.dart';

import 'next_widget.dart';
import 'row_checkout_summary_information_widget.dart';

class CheckoutSummaryWidget extends GetView<CustomerSummaryController> {
  final Color? color;

  /// Default name is Translate.next.tr
  final String? buttonName;
  const CheckoutSummaryWidget(
      {Key? key, this.color, required this.onTapNext, this.buttonName})
      : super(key: key);
  final void Function(bool isPreOrder) onTapNext;
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return controller.obx(
      (checkoutSummary) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: color ?? Colors.brown,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              color: const Color.fromRGBO(243, 243, 243, 1),
              padding: const EdgeInsets.all(15),
              child: Column(
                children: checkoutSummary?.summary
                        ?.mapIndexed(
                          (summary, index) =>
                              RowCheckOutSummaryInformationWidget(
                            title: summary.title ?? 'sssss',
                            isLastIndex:
                                checkoutSummary.summary?.length == index + 1,
                            value:
                                '${(summary.additionalInfo ?? 'sss').isNotEmpty ? '(${summary.additionalInfo}) ' : 'ssss'} ${summary.value} ${summary.currencySymbol ?? 'ssss'}',
                          ),
                        )
                        .toList() ??
                    [],
              ),
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
      onLoading: Container(),
    );
  }
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}
