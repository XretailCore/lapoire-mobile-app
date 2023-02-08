import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/components/custom_appbar.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/app_colors.dart';
import '../controllers/customer_location_controller.dart';
import '../controllers/customer_summary_controller.dart';
import '../widgets/checkout_title_divider_widget.dart';
import '../widgets/custom_stepper_widget.dart';
import '../widgets/toggle_widget.dart';

class CheckoutPickStoreOptionScreen extends GetView<CustomerLocationController> {
  CheckoutPickStoreOptionScreen({Key? key}) : super(key: key);
  final CustomerSummaryController customerSummaryController =
  Get.find<CustomerSummaryController>();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: CustomAppBar(
          title: Translate.checkout.tr, showBackButton: true, showAction: true),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const CustomStepperWidget(currentIndex: 0),
          const SizedBox(height: 24),
          CheckOutTitleDividerWidget(title: Translate.selectCollectingStore.tr),
      Obx(()=> Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedToggle(
                values: ['English', 'Arabic'],
                onToggleCallback: (value) {
                  controller.toggleValue.value=value;
                },
                buttonColor: AppColors.primaryColor,
                backgroundColor: AppColors.redColor,
                textColor: const Color(0xFFFFFFFF),
              ),
              controller.toggleValue.value==0?Text('Toggle Value :'):Text('sssssss Value :'),
            ],
          ),
        ),
      ),
        ],
      ),
    );
  }
}
