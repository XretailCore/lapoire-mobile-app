import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imtnan/modules/check_out/controllers/payment_controller.dart';
import 'package:linktsp_api/data/exception_api.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/utils/strings.dart';
import 'package:linktsp_api/linktsp_api.dart';
import '../../../core/components/custom_loaders.dart';
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
  final UserSharedPrefrenceController _userSharedPrefrenceController =
      Get.find<UserSharedPrefrenceController>();
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
// TODO : uncomment below comment when change imtenan to multi store
        final addresses = await LinkTspApi.instance.address
            .getShipmentAddresses(customId: customerId!);
//         final addresses = await LinkTspApi.instance.address
//             .getAddressBook(customId: customerId!);
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
    openLoadingDialog(context);
    Locations.locationId = address.id;
    selectedZoneId = address.zoneId;
    final CustomerSummaryController _customerSummaryController =
        Get.find<CustomerSummaryController>();
    await _customerSummaryController.getSummaryData();
    update();
    Get.back();
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
    String alertMessage = '';

    try {
      final cartValidate = await LinkTspApi.instance.multiStore.cartValidate(
          customerID: _userSharedPrefrenceController.getUserId!,
          addressId: Locations.locationId ?? 0);
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
        final PaymentController paymentController =
        Get.find<PaymentController>();
        paymentController.onInit();
        Get.toNamed(Routes.paymentScreen);
      }
    } on ExceptionApi catch (e) {
      HelperFunctions.showSnackBar(
          message: e.toString(), context: Get.context!);
    } catch (e) {
      change(null, status: RxStatus.error());
    }
  }
}
