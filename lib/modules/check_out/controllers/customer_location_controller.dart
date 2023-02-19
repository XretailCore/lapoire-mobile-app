import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:imtnan/modules/check_out/controllers/payment_controller.dart';
import 'package:linktsp_api/data/exception_api.dart';
import '../../../core/components/custom_loaders.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/utils/strings.dart';
import 'package:linktsp_api/linktsp_api.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/routes.dart';
import 'customer_summary_controller.dart';

import 'locations.dart';

class CustomerLocationController extends GetxController
    with StateMixin<List<AddressModel>> {
  CustomerLocationController();

  final Rx<bool> _isAddressEmpty = Rx<bool>(true);
RxInt toggleValue=0.obs;
  bool get isAddressEmpty => _isAddressEmpty.value;
  int? selectedZoneId = 0;

  @override
  void onReady() {
    super.onReady();
    Locations.storeId = null;
    Locations.locationId = null;
    init();
  }

  Future<void> init() async {
    change(null, status: RxStatus.loading());
    final UserSharedPrefrenceController _userSharedPrefrenceController =
        Get.find<UserSharedPrefrenceController>();
    try {
      final isUser = _userSharedPrefrenceController.isUser;

      if (isUser) {
        final customerId = _userSharedPrefrenceController.getUserId;
        final addresses = await LinkTspApi.instance.address
            .getShipmentAddresses(customId: customerId!);
        _setDefaultLocation(addresses: addresses);
        _isAddressEmpty.value = addresses.isEmpty;
        change(addresses, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error());
      }
    } catch (e) {
      change(null, status: RxStatus.error());
    }
  }

  Future<void> _setDefaultLocation(
      {required List<AddressModel> addresses}) async {
    for (var element in addresses) {
      if (element.isDefault ?? false) {
        Locations.locationId = element.id;
        selectedZoneId = element.zoneId;

        break;
      }
    }
    if (addresses.isNotEmpty) {
      Locations.locationId ??= addresses.first.id;
    }
    final CustomerSummaryController _customerSummaryController =
        Get.find<CustomerSummaryController>();
    await _customerSummaryController.getSummaryData();
  }

  void onSelectAddress(BuildContext context, AddressModel address) async {
   // openLoadingDialog(context);
    Locations.locationId = address.id;
    selectedZoneId = address.zoneId;
    final CustomerSummaryController _customerSummaryController =
        Get.find<CustomerSummaryController>();
    await _customerSummaryController.getSummaryData();
    update();
   // Get.back();
  }

  Future<void> onEditSelect(AddressModel address) async {
    Get.toNamed(Routes.addressDetails, arguments: {
      Arguments.isCheckoutAddress: true,
    });
  }

  @override
  void onClose() {
    _isAddressEmpty.close();
    super.onClose();
  }

  void nextAction() async {
    try {
        final PaymentController paymentController =
        Get.find<PaymentController>();
        paymentController.onInit();
        Get.toNamed(Routes.paymentScreen);
    } on ExceptionApi catch (e) {
      HelperFunctions.showSnackBar(
          message: e.toString(), context: Get.context!);
    } catch (e) {
      change(null, status: RxStatus.error());
    }
  }

  Future<void> pickAndCollectAction(String route) async {
    var permissionGranted = await HelperFunctions().checkLocationPermission();
    if (permissionGranted) {
      openLoadingDialog(Get.context!);
      final userSharedPref = Get.find<UserSharedPrefrenceController>();
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      userSharedPref.setCurrentLocation = position;
      Get.back();
      Get.toNamed(route);
    }
  }
}
