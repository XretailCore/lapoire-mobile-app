import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/components/custom_appbar.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/app_colors.dart';
import '../controllers/customer_summary_controller.dart';
import '../controllers/payment_controller.dart';
import '../widgets/checkout_summary_widget.dart';
import '../widgets/custom_stepper_widget.dart';
import '../widgets/discount_method_widget.dart';
import '../widgets/payment_option_item_widget.dart';

class PaymentScreen extends GetView<PaymentController> {
  PaymentScreen({Key? key}) : super(key: key);
  final CustomerSummaryController customerSummaryController =
      Get.find<CustomerSummaryController>();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(title: Translate.checkout.tr, showBackButton: true),
      body: Form(
        key: controller.formKey,
        child: Column(
          children: [
            const SizedBox(height: 8),
            const CustomStepperWidget(currentIndex: 1),
            const SizedBox(height: 8),
            const SizedBox(height: 8),
            Expanded(
              child: controller.obx(
                (payments) => PaymentOptionItemWidget(
                  payments: payments ?? [],
                ),
                onLoading: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 10),
                const DiscountMethodsWidget(),
                const SizedBox(height: 10),
                customerSummaryController.obx(
                  (summary) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.redColor,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              Translate.deliveredWithinMinMaxBusinessDays
                                  .trParams(
                                params: {
                                  'Min': summary?.configDeliveryPeriod?.min
                                          .toString() ??
                                      "",
                                  'Max': summary?.configDeliveryPeriod?.max
                                          .toString() ??
                                      "",
                                  'PeriodName': (summary
                                          ?.configDeliveryPeriod?.periodName ??
                                      "")
                                },
                              ),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                CheckoutSummaryWidget(
                  onTapNext: (isPreOrder) {
                    controller.nextBtnAction();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
