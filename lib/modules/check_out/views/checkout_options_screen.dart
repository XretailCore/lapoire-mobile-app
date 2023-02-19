import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/components/custom_appbar.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/routes.dart';
import '../../../core/utils/shipment_methods.dart';
import '../controllers/customer_location_controller.dart';
import '../controllers/customer_summary_controller.dart';
import '../controllers/delivery_controller.dart';
import '../widgets/custom_stepper_widget.dart';

class CheckoutOptionsScreen extends GetView<CustomerLocationController> {
  CheckoutOptionsScreen({Key? key}) : super(key: key);
  final CustomerSummaryController customerSummaryController =
      Get.find<CustomerSummaryController>();
  final DeliveryController deliveryController =
  Get.find<DeliveryController>();

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
          ListTile(
              onTap: ()async{
                deliveryController.selectedShipmentMethods = ShipmentMethods.pickAtStore;
                await controller.pickAndCollectAction(Routes.storesLocationScreen);
              },
            title: CustomText(Translate.collectFromStore.tr),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: CustomText(
                Translate.collectFromStoreMessage.tr,
                softWrap: true,
                style: const TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: primaryColor,
              size: 40.0,
            ),
          ),
          const DottedLine(dashColor: AppColors.redColor),
          ListTile(
            onTap: (){
              deliveryController.selectedShipmentMethods = ShipmentMethods.homeDelivery;
              Get.toNamed(Routes.customerLocationsScreen);
            },
            title: CustomText(Translate.homeDelivery.tr),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: CustomText(
                Translate.homeDeliveryMessage.tr,
                softWrap: true,
                style: const TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: primaryColor,
              size: 40.0,
            ),
          ),
        ],
      ),
    );
  }
}
