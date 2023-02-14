import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/data/exception_api.dart';
import 'package:linktsp_api/linktsp_api.dart';
import '../../../core/components/custom_loaders.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import 'delivery_controller.dart';
import 'locations.dart';
import 'payment_controller.dart';

class CustomerSummaryController extends GetxController
    with StateMixin<CheckouCartSummaryModel> {
  final TextEditingController pointTEC = TextEditingController(text: ''),
      couponTEC = TextEditingController(text: '');

  final PaymentController _paymentController = Get.find<PaymentController>();
  final DeliveryController _deliveryController = Get.find<DeliveryController>();
  String? errorCoupon, errorloyelty;
  int? userId;

  @override
  void onInit() {
    super.onInit();
    userId = Get.find<UserSharedPrefrenceController>().getUserId;
  }
  Future<void> getSummaryData() async {
    change(null, status: RxStatus.loading());
    try {
      if (userId != null) {
        final checkouCartSummaryModel =
        await LinkTspApi.instance.checkOut.chehckoutCartSummary(
          addressId: Locations.locationId,
          storeId: Locations.storeId,
          customerId: userId!,
          shipmentMethods: _deliveryController.selectedShipmentMethods,
        );

        change(checkouCartSummaryModel, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error());
      }
    } on ExceptionApi catch (e) {
      change(null, status: RxStatus.error(e.message));
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  void onTapPointsApply(int? addressId, int points) async {
    errorCoupon = null;
    errorloyelty = null;
    if (addressId == null) {
      change(null, status: RxStatus.empty());
    } else if (_paymentController.formKey.currentState?.validate() ?? false) {
      try {
        if (userId != null) {
          openLoadingDialog(Get.context!);
          final checkouCartSummaryModel =
              await LinkTspApi.instance.checkOut.loyaltyPointsRedeem(
            customerId: userId!,
            addressId: Locations.locationId!,
            loyaltyPoints: points,
            storeId: Locations.storeId,
            shipmentMethods: _deliveryController.selectedShipmentMethods,
          );

          change(checkouCartSummaryModel, status: RxStatus.success());

          Get.back();
        } else {
          change(null, status: RxStatus.error());
        }
      } on ExceptionApi catch (e) {
        errorloyelty = e.message;
        Get.back();
      } catch (e) {
        Get.back();
        change(null, status: RxStatus.error());
      }
    }
    _paymentController.formKey.currentState?.validate();
  }

  void onTapPointsClear(int? addressId, int points) async {
    if (addressId == null) {
      change(null, status: RxStatus.empty());
    } else {
      try {
        if (userId != null) {
          openLoadingDialog(Get.context!);
          final checkouCartSummaryModel =
              await LinkTspApi.instance.checkOut.loyaltyPointsClear(
            customerId: userId!,
            addressId: Locations.locationId!,
            loyaltyPoints: points,
            storeId: Locations.storeId,
            shipmentMethods: _deliveryController.selectedShipmentMethods,
          );
          errorloyelty = null;
          pointTEC.clear();
          change(checkouCartSummaryModel, status: RxStatus.success());
          Get.back();
        } else {
          change(null, status: RxStatus.error());
        }
      } on ExceptionApi catch (e) {
        errorCoupon = e.message;
        Get.back();
        _paymentController.formKey.currentState?.validate();
      } catch (e) {
        change(null, status: RxStatus.error());
      }
    }
  }

  void onTapCupoinApply(
      String couponCode, int? addressId, int loyaltyPoints) async {
    errorCoupon = null;
    errorloyelty = null;
    if (addressId == null) {
      change(null, status: RxStatus.empty());
    } else if (_paymentController.formKey.currentState?.validate() ?? false) {
      try {
        if (userId != null) {
          openLoadingDialog(Get.context!);
          final checkouCartSummaryModel =
              await LinkTspApi.instance.checkOut.couponRedeem(
            couponCode: couponCode,
            addressId: Locations.locationId!,
            loyaltyPoints: loyaltyPoints,
            storeId: Locations.storeId,
            customerId: userId!,
            shipmentMethods: _deliveryController.selectedShipmentMethods,
          );

          change(checkouCartSummaryModel, status: RxStatus.success());

          Get.back();
        } else {
          change(null, status: RxStatus.error());
        }
      } on ExceptionApi catch (e) {
        errorCoupon = e.message;
        Get.back();
      } catch (e) {
        Get.back();
        change(null, status: RxStatus.error());
      }
    }
    _paymentController.formKey.currentState?.validate();
  }

  void onTapCupoinClear(
      String couponCode, int? addressId, int loyaltyPoints) async {
    if (addressId == null) {
      change(null, status: RxStatus.empty());
    } else {
      try {
        if (userId != null) {
          openLoadingDialog(Get.context!);
          final checkouCartSummaryModel =
              await LinkTspApi.instance.checkOut.couponClear(
            couponCode: couponCode,
            addressId: Locations.locationId!,
            loyaltyPoints: loyaltyPoints,
            storeId: Locations.storeId,
            customerId: userId!,
            shipmentMethods: _deliveryController.selectedShipmentMethods,
          );
          errorCoupon = null;
          couponTEC.clear();
          change(checkouCartSummaryModel, status: RxStatus.success());
          Get.back();
        } else {
          change(null, status: RxStatus.error());
        }
      } on ExceptionApi catch (e) {
        errorCoupon = e.message;
        Get.back();
        _paymentController.formKey.currentState?.validate();
      } catch (e) {
        change(null, status: RxStatus.error());
      }
    }
  }
}
