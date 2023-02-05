import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:get/get.dart';
import 'package:imtnan/modules/check_out/controllers/locations.dart';
import 'package:linktsp_api/data/exception_api.dart';
import 'package:linktsp_api/linktsp_api.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/helper_functions.dart';

import '../../../core/utils/routes.dart';
import '../../../core/utils/shipment_methods.dart';
import '../../cart/controllers/cart_controller.dart';

class DeliveryController extends GetxController {
  String? selectedShipmentMethods;
  final UserSharedPrefrenceController _userSharedPrefrenceController =
      Get.find<UserSharedPrefrenceController>();

  @override
  void onInit() {
    super.onInit();
    initiatedCheckoutFBEvent();
  }

  final facebookAppEvents = FacebookAppEvents();

  Future<void> initiatedCheckoutFBEvent() async {
    final CartController _cartController = Get.find<CartController>();

    facebookAppEvents.logInitiatedCheckout(
      contentType: 'product_group',
      contentId: '${_cartController.cartItemsIds}',
      numItems: _cartController.cartItemsIds.length,
      currency: 'EGP',
    );
  }

  Future<void> goToCustomerLocation(BuildContext context) async {
    selectedShipmentMethods = ShipmentMethods.homeDelivery;
    String alertMessage = '';
    try {
      final cartValidate = await LinkTspApi.instance.multiStore.cartValidate(
          customerID: _userSharedPrefrenceController.getUserId!,
          addressId: Locations.locationId ?? 3);
      if (cartValidate.alertMessage != null) {
        for (var i = 0; i < cartValidate.storeCartItems!.length; i++) {
          if (cartValidate.storeCartItems?[i].status != 1) {
            alertMessage +=
                "${cartValidate.storeCartItems?[i].title} : ${cartValidate.storeCartItems?[i].message} ";
          }
        }
        HelperFunctions.showSnackBar(
            message: alertMessage, context: Get.context!);
      } else {
        Get.toNamed(Routes.customerLocationsScreen);
      }
    } on ExceptionApi catch (e) {
      HelperFunctions.showSnackBar(
          message: e.toString(), context: Get.context!);
    }
  }
}
