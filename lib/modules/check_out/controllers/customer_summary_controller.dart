import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/data/exception_api.dart';
import 'package:linktsp_api/linktsp_api.dart';
import '../../../core/components/custom_loaders.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/helper_functions.dart';
import 'delivery_controller.dart';
import 'locations.dart';

class CustomerSummaryController extends GetxController
    with StateMixin<CheckouCartSummaryModel> {
  final TextEditingController pointTEC = TextEditingController(text: ''),
      couponTEC = TextEditingController(text: '');
  int? appliedPoints;

  final DeliveryController _deliveryController = Get.find<DeliveryController>();
  final GlobalKey<FormState> formKeyLoyalty = GlobalKey<FormState>();

  final GlobalKey<FormState> formKeyCoupon = GlobalKey<FormState>();

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
    if (formKeyLoyalty.currentState?.validate() ?? false) {
      try {
        if (userId != null) {
          openLoadingDialog(Get.context!);
          final checkouCartSummaryModel =
          await LinkTspApi.instance.checkOut.loyaltyPointsRedeem(
            customerId: userId!,
            addressId: Locations.locationId ?? 0,
            loyaltyPoints: points,
            storeId: Locations.storeId,
            shipmentMethods: _deliveryController.selectedShipmentMethods,
          );
          appliedPoints = points;

          HelperFunctions.showSnackBar(
              context: Get.context!,
              message: Translate.iconsRedemptionSuccessfullyApplied.tr,
              duration: const Duration(seconds: 6));
          HelperFunctions.vibrate();
          change(checkouCartSummaryModel, status: RxStatus.success());

          Get.back();
        } else {
          change(null, status: RxStatus.error());
        }
      } on ExceptionApi catch (e) {
        HelperFunctions.showSnackBar(
            context: Get.context!,
            message: e.message ?? '',
            duration: const Duration(seconds: 5));

        Get.back();
      } catch (e) {
        Get.back();
        change(null, status: RxStatus.error());
      }
    }
    formKeyLoyalty.currentState?.validate();
  }

  void onTapPointsClear(int? addressId, int points) async {
    try {
      if (userId != null) {
        openLoadingDialog(Get.context!);
        appliedPoints = 0;

        final checkouCartSummaryModel =
        await LinkTspApi.instance.checkOut.loyaltyPointsClear(
          customerId: userId!,
          addressId: Locations.locationId ?? 0,
          loyaltyPoints: points,
          storeId: Locations.storeId,
          shipmentMethods: _deliveryController.selectedShipmentMethods,
        );
        errorloyelty = null;
        pointTEC.clear();
        appliedPoints = 0;
        change(checkouCartSummaryModel, status: RxStatus.success());
        Get.back();
      } else {
        change(null, status: RxStatus.error());
      }
    } on ExceptionApi catch (e) {
      HelperFunctions.showSnackBar(
          context: Get.context!,
          message: e.message ?? '',
          duration: const Duration(seconds: 5));
      Get.back();
      formKeyLoyalty.currentState?.validate();
    } catch (e) {
      change(null, status: RxStatus.error());
    }
  }

  void onTapCupoinApply(
      String couponCode, int? addressId, int loyaltyPoints) async {
    errorCoupon = null;
    errorloyelty = null;
    if (formKeyCoupon.currentState?.validate() ?? false) {
      try {
        if (userId != null) {
          openLoadingDialog(Get.context!);
          final checkouCartSummaryModel =
          await LinkTspApi.instance.checkOut.couponRedeem(
            couponCode: couponCode,
            addressId: Locations.locationId ?? 0,
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
        HelperFunctions.showSnackBar(
            context: Get.context!,
            message: e.message ?? '',
            duration: const Duration(seconds: 5));
        Get.back();
      } catch (e) {
        Get.back();
        change(null, status: RxStatus.error());
      }
    }
    formKeyCoupon.currentState?.validate();
  }

  void onTapCupoinClear(
      String couponCode, int? addressId, int loyaltyPoints) async {
    try {
      if (userId != null) {
        openLoadingDialog(Get.context!);
        final checkouCartSummaryModel =
        await LinkTspApi.instance.checkOut.couponClear(
          couponCode: couponCode,
          addressId: Locations.locationId ?? 0,
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
      HelperFunctions.showSnackBar(
          context: Get.context!,
          message: e.message ?? '',
          duration: const Duration(seconds: 5));
      Get.back();
      formKeyCoupon.currentState?.validate();
    } catch (e) {
      change(null, status: RxStatus.error());
    }
  }
}
