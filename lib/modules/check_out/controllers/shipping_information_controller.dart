import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:get/get.dart';
import 'package:imtnan/modules/check_out/controllers/customer_location_controller.dart';
import 'package:linktsp_api/data/exception_api.dart';
import 'package:linktsp_api/linktsp_api.dart';
import '../../../core/components/custom_loaders.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/utils/routes.dart';
import 'checkout_confirmation_controller.dart';
import 'credit_card_controller.dart';
import 'customer_summary_controller.dart';
import 'delivery_controller.dart';
import 'locations.dart';
import 'payment_controller.dart';

class ShippingInformationController extends GetxController
    with StateMixin<CheckoutReviewModel> {
  ShippingInformationController();
  final PaymentController _paymentController = Get.find<PaymentController>();

  final CustomerSummaryController _customerSummaryController =
      Get.find<CustomerSummaryController>();
  final UserSharedPrefrenceController _userSharedPrefrenceController =
      Get.find<UserSharedPrefrenceController>();
  final DeliveryController _deliveryController = Get.find<DeliveryController>();
  double amount = 0;
  CheckoutReviewModel checkoutReviewModel = CheckoutReviewModel();

  String merchantGuid = '';
  @override
  void onReady() {
    super.onReady();

    getCheckOutReview();
  }

  Future<void> getCheckOutReview() async {
    try {
      change(null, status: RxStatus.loading());
      if (_userSharedPrefrenceController.isUser) {
        checkoutReviewModel = await LinkTspApi.instance.checkOut.checkoutReview(
          paymentOptionId: _paymentController.paymentOptionId,
          addressId: Locations.locationId,
          loyaltyPoints:
              int.tryParse(_customerSummaryController.pointTEC.text) ?? 0,
          pickStoreID: Locations.storeId,
          customerId: _userSharedPrefrenceController.getUserId!,
          shipmentMethods: "HomeDelivery",
          version: 3,
        );
        amount = checkoutReviewModel.total ?? 0;
        change(checkoutReviewModel, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error());
      }
    } catch (e) {
      change(null, status: RxStatus.error());
    }
  }

  void confirm(context) async {
    final paymentMethodId = _paymentController.paymentOptionId;
    var _customerLocationController = Get.find<CustomerLocationController>();
    if (paymentMethodId == 1) {
      try {
        openLoadingDialog(context);
        if (_userSharedPrefrenceController.isUser) {
          final orderCode = await LinkTspApi.instance.checkOut.confirm(
            paymentOptionId: paymentMethodId,
            addressId: Locations.locationId,
            loyaltyPoints:
                int.tryParse(_customerSummaryController.pointTEC.text) ?? 0,
            finalAmount: amount,
            storeId: Locations.storeId ?? 0,
            customerId: _userSharedPrefrenceController.getUserId!,
            shipmentMethods: "HomeDelivery",
            zoneID: _userSharedPrefrenceController.getCurrentZone?.id,
          );
          final confirmationController =
              Get.find<CheckoutConfirmationController>();
          confirmationController.orderCode = orderCode;
          Get.back();
          Get.offAllNamed(Routes.checkoutConfirmationScreen);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              HelperFunctions.customSnackBar(
                  message: Translate.userNotSelected.tr,
                  backgroundColor: Colors.red));
          Get.back();
        }
      } on ExceptionApi catch (e) {
        Get.back();
        ScaffoldMessenger.of(context).showSnackBar(
            HelperFunctions.customSnackBar(
                message: e.message, backgroundColor: Colors.red));
      } catch (e) {
        Get.back();
        ScaffoldMessenger.of(context).showSnackBar(
            HelperFunctions.customSnackBar(
                message: Translate.error.tr, backgroundColor: Colors.red));
      }
    } else {
      try {
        openLoadingDialog(context);
        final PaymentFrameModel paymentFrameModel =
        await LinkTspApi.instance.checkOut.confirmOrder(
          paymentOptionId: paymentMethodId,
          addressId: Locations.locationId ?? 0,
          zoneID: _userSharedPrefrenceController.getCurrentZone?.id,
          loyaltyPoints:
          int.tryParse(_customerSummaryController.pointTEC.text) ?? 0,
          finalAmount: amount,
          storeId: Locations.storeId ?? 0,
          customerId: _userSharedPrefrenceController.getUserId!,
          shipmentMethods: _deliveryController.selectedShipmentMethods??"",
        );
        Get.back();

        final creditCardController = Get.find<CreditCardController>();
        creditCardController.paymentModel = paymentFrameModel;
        Get.toNamed(Routes.creditCardScreen);
      } on ExceptionApi catch (e) {
        Get.back();
        ScaffoldMessenger.of(context).showSnackBar(
            HelperFunctions.customSnackBar(
                message: e.message, backgroundColor: Colors.red));
      } catch (e) {
        Get.back();
        ScaffoldMessenger.of(context).showSnackBar(
            HelperFunctions.customSnackBar(
                message: e.toString(), backgroundColor: Colors.red));
      }
    }
  }

  void generateGuid() {
    merchantGuid = Guid.newGuid.value;
  }
}
