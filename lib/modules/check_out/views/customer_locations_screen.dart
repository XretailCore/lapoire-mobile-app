import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/components/custom_appbar.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import '../../../core/components/custom_error_widget.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/routes.dart';
import '../../../core/utils/strings.dart';
import '../controllers/customer_location_controller.dart';
import '../controllers/customer_summary_controller.dart';
import '../controllers/payment_controller.dart';
import '../widgets/checkout_summary_widget.dart';
import '../widgets/custom_stepper_widget.dart';
import '../widgets/customer_locations.dart';

class CustomerLocationsScreen extends GetView<CustomerLocationController> {
  CustomerLocationsScreen({Key? key}) : super(key: key);
  final CustomerSummaryController customerSummaryController = Get.find<CustomerSummaryController>();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: CustomAppBar(title: Translate.checkout.tr, showBackButton: true),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const CustomStepperWidget(currentIndex: 0),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      Translate.shippingInformation.tr,
                      style: TextStyle(
                        fontSize: 17,
                        color: primaryColor,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.selectLocationFromMapScreen, arguments: {
                          Arguments.isCheckoutAddress: true,
                        });
                      },
                      child: CustomText(
                        Translate.addNewAddress.tr,
                        style: const TextStyle(
                            fontSize: 13, color: AppColors.redColor, decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                Divider(color: primaryColor, thickness: 1.5),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: controller.obx(
                (addresses) => CustomerLocationsWidget(
                  isEnableEdit: true,
                  addresses: addresses ?? [],
                ),
                onLoading: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ),
                onError: (e) => CustomErrorWidget(
                  errorText: e,
                ),
              ),
            ),
          ),
          Obx(
            () => Offstage(
              offstage: controller.isAddressEmpty.value,
              child: customerSummaryController.obx(
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
                            Translate.deliveredWithinMinMaxBusinessDays.trParams(
                              params: {
                                'Min': summary?.configDeliveryPeriod?.min.toString() ?? "",
                                'Max': summary?.configDeliveryPeriod?.max.toString() ?? "",
                                'PeriodName': (summary?.configDeliveryPeriod?.periodName ?? "")
                              },
                            ),
                            // " ${Translate.deliveredWithin.tr} ${summary?.configDeliveryPeriod?.min}-${summary?.configDeliveryPeriod?.max} ${Translate.minutes.tr}",
                            // summary?.configDeliveryPeriod?.deliveryNote
                            //     ?.toUpperCase(),
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
                onLoading: Container(
                  height: 200,
                  color: Colors.white,
                  alignment: Alignment.topCenter,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Obx(
            () => CheckoutSummaryWidget(
              buttonColor: controller.isAddressEmpty.value ? Colors.grey : AppColors.redColor,
              onTapNext: controller.isAddressEmpty.value
                  ? (isPreOrder) {}
                  : (isPreOrder) {
                      final _paymentController = Get.find<PaymentController>();
                      _paymentController.isPreOrder = isPreOrder;
                      _paymentController.onInit();
                      controller.nextAction();
                    },
            ),
          ),
        ],
      ),
    );
  }
}
