import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/components/custom_button.dart';
import '../../../core/localization/translate.dart';
import '../controllers/shipping_information_controller.dart';
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
    return controller.obx(
      (checkoutSummary) => Container(
        decoration: BoxDecoration(
          color: color ?? AppColors.highlighter,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              color: AppColors.highlighter,
              padding: const EdgeInsets.all(15),
              child: Column(children: [
                ...summary
                    .map(
                      (summary) => RowCheckOutSummaryInformationWidget(
                        title: summary.title ?? '',
                        isLastIndex: checkoutSummary?.summary?.length ==
                            (checkoutSummary?.summary?.indexOf(summary))! + 1,
                        value:
                            '${summary.additionalInfo != null ? '${summary.additionalInfo} ' : ''} ${summary.value} ${summary.currencySymbol ?? ''}',
                      ),
                    )
                    .toList()
              ]),
            ),
            const SizedBox(height: 10),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomBorderButton(
                  color: AppColors.redColor,
                  radius: 20.0,
                  title: buttonName ?? Translate.next.tr,
                  onTap: () {
                    final isPreOrder =
                        checkoutSummary?.configDeliveryPeriod?.preOrder ??
                            false;

                    onTapNext(isPreOrder);
                  },
                ),
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
