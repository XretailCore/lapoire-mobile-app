import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/components/appbar_widget.dart';
import '../controllers/customer_summary_controller.dart';
import '../controllers/payment_controller.dart';
import '../widgets/checkout_summary_widget.dart';
import '../widgets/choice_payment_method_widget.dart';
import '../widgets/custom_stepper_widget.dart';
import '../widgets/discount_method_widget.dart';

class PaymentScreen extends GetView<PaymentController> {
  PaymentScreen({Key? key}) : super(key: key);
  final CustomerSummaryController customerSummaryController =
      Get.find<CustomerSummaryController>();
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarWidget(title: Translate.checkout.tr),
      body: Form(
        key: controller.formKey,
        child: Column(
          children: [
            const SizedBox(height: 8),
            const CustomStepperWidget(
              currentIndex: 1,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(height: 8),
                  controller.obx(
                    (payments) => ChoicePaymentMethodWidget(
                      groupValue: 0,
                      payments: payments ?? [],
                    ),
                    onLoading: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const DiscountMethodsWidget(),
                  const SizedBox(height: 10),
                  customerSummaryController.obx(
                    (summary) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      decoration: BoxDecoration(
                        color: primaryColor,
                      ),
                      child: CustomText(
                        summary?.configDeliveryPeriod?.deliveryNote
                            ?.toUpperCase(),
                        textAlign: TextAlign.center,
                        softWrap: true,
                        maxLines: 2,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            CheckoutSummaryWidget(
              onTapNext: (isPreOrder) {
                controller.nextBtnAction();
              },
            ),
          ],
        ),
      ),
    );
  }
}
