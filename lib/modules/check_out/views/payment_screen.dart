import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/components/custom_appbar.dart';
import '../../../core/components/custom_error_widget.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/routes.dart';
import '../../../core/utils/shipment_methods.dart';
import '../../listing_items/widgets/categories_filter_widget.dart';
import '../controllers/customer_summary_controller.dart';
import '../controllers/delivery_controller.dart';
import '../controllers/payment_controller.dart';
import '../widgets/checkout_summary_widget.dart';
import '../widgets/custom_stepper_widget.dart';
import '../widgets/discount_method_widget.dart';
import '../widgets/payment_option_item_widget.dart';

class PaymentScreen extends GetView<PaymentController> {
  PaymentScreen({Key? key}) : super(key: key);
  final CustomerSummaryController customerSummaryController =
      Get.find<CustomerSummaryController>();
  final DeliveryController deliveryController = Get.find<DeliveryController>();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: Translate.checkout.tr,
        showBackButton: true,
        showAction: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    const CustomStepperWidget(currentIndex: 1),
                    const SizedBox(height: 8),
                    const SizedBox(height: 8),
                    TitleWithDivider(
                      title: Translate.selectAPaymentMethod.tr,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(
                      height: 0.15.sh,
                      child: controller.obx(
                        (payments) => PaymentOptionItemWidget(
                          payments: payments ?? [],
                        ),
                        onLoading: Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(primaryColor),
                          ),
                        ),
                        onError: (e) => CustomErrorWidget(
                          errorText: e,
                        ),
                      ),
                    ),
                    Column(
                      children: const [
                        SizedBox(height: 10),
                        DiscountMethodsWidget(),
                        SizedBox(height: 10),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          deliveryController.selectedShipmentMethods == ShipmentMethods.pickAtStore
              ? const SizedBox.shrink()
              : customerSummaryController.obx(
                  (summary) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
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
                  onError: (e) => const SizedBox.shrink(),
                ),
          const SizedBox(height: 10),
          CheckoutSummaryWidget(
            onTapNext: (isPreOrder) {
              Get.toNamed(Routes.summaryScreen);
            },
          ),
        ],
      ),
    );
  }
}
