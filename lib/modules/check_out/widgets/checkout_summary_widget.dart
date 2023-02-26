import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/components/custom_button.dart';
import '../../../core/components/custom_error_widget.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/app_colors.dart';
import '../controllers/customer_summary_controller.dart';
import 'row_checkout_summary_information_widget.dart';

class CheckoutSummaryWidget extends GetView<CustomerSummaryController> {
  final Color? color;

  /// Default name is Translate.next.tr
  final String? buttonName;

  final Color? buttonColor;

  const CheckoutSummaryWidget(
      {Key? key,
      this.color,
      required this.onTapNext,
      this.buttonName,
      this.buttonColor})
      : super(key: key);
  final void Function(bool isPreOrder) onTapNext;

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (checkoutSummary) => Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          color: color ?? AppColors.highlighter,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              color: AppColors.highlighter,
              padding: const EdgeInsets.all(15),
              child: Column(
                children: checkoutSummary?.summary
                        ?.mapIndexed(
                          (summary, index) =>
                              RowCheckOutSummaryInformationWidget(
                            title: summary.title ?? '',
                            additionalInfo: summary.additionalInfo == "COD"
                                ? null
                                : summary.additionalInfo,
                            isLastIndex:
                                checkoutSummary.summary?.length == index + 1,
                            value: summary.value ?? "",
                            currencySymbol: summary.currencySymbol ?? '',
                          ),
                        )
                        .toList() ??
                    [],
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomBorderButton(
                  color: buttonColor ?? AppColors.redColor,
                  radius: 30.0,
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
      onLoading: Container(),
      onError: (e) => CustomErrorWidget(
        errorText: e,
        onReload: controller.onInit,
      ),
    );
  }
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}
