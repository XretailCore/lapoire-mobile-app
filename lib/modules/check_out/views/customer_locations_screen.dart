import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/components/custom_appbar.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/routes.dart';
import '../../../core/utils/strings.dart';
import '../../../core/utils/theme.dart';
import '../controllers/customer_location_controller.dart';
import '../controllers/customer_summary_controller.dart';
import '../controllers/payment_controller.dart';
import '../widgets/checkout_summary_widget.dart';
import '../widgets/custom_stepper_widget.dart';
import '../widgets/customer_locations.dart';

class CustomerLocationsScreen extends GetView<CustomerLocationController> {
  CustomerLocationsScreen({Key? key}) : super(key: key);
  final CustomerSummaryController customerSummaryController =
      Get.find<CustomerSummaryController>();
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: CustomAppBar(title: Translate.checkout.tr,showBackButton: true),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const CustomStepperWidget(currentIndex: 0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  Translate.shippingInformation.tr,
                  style: const TextStyle(
                    fontSize: 17,
                    color: Color.fromRGBO(112, 112, 112, 1),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    Get.toNamed(Routes.selectLocationFromMapScreen, arguments: {
                      Arguments.isCheckoutAddress: true,
                    });
                  },
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(
                          CustomThemes.appTheme.primaryColor)),
                  icon: const Icon(Icons.add_circle_outline),
                  label: CustomText(
                    Translate.newAddress.tr,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(8.0),
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
              ),
            ),
          ),
          Obx(
            () => Offstage(
              offstage: controller.isAddressEmpty,
              child: Card(
                elevation: 1.5,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: customerSummaryController.obx(
                  (summary) => Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                        color: CustomThemes.appTheme.primaryColor),
                    margin: const EdgeInsets.all(0),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomText(
                            summary?.configDeliveryPeriod?.deliveryNote
                                ?.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 9,
                              color: Colors.white,
                            ),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onLoading: const SizedBox.shrink(),
                ),
              ),
            ),
          ),
          CheckoutSummaryWidget(
            onTapNext: (isPreOrder) {
              final _paymentController = Get.find<PaymentController>();
              _paymentController.isPreOrder = isPreOrder;
              _paymentController.onInit();
              controller.nextAction();
            },
          ),
        ],
      ),
    );
  }
}
