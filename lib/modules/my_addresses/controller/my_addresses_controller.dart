import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/utils/routes.dart';
import '../../../core/utils/strings.dart';

class MyAddressesController extends GetxController
    with StateMixin<List<AddressModel>> {
  @override
  void onReady() {
    super.onReady();
    getAddresses();
  }

  Future<void> getAddresses() async {
    await HelperFunctions.errorRequestsHandler<List<AddressModel>>(
      loadingFunction: () async {
        change(null, status: RxStatus.loading());
        final userSharedPrefrenceController =
            Get.find<UserSharedPrefrenceController>();
        final userId = userSharedPrefrenceController.getUserId;
        final addresses =
            await LinkTspApi.instance.address.getAddressBook(customId: userId!);
        return addresses;
      },
      onSuccessFunction: (addresses) async {
        addresses.isEmpty
            ? change(addresses, status: RxStatus.empty())
            : change(addresses, status: RxStatus.success());
      },
      onDioErrorFunction: (e, m) async {
        change(null, status: RxStatus.error(m));
      },
      onUnexpectedErrorFunction: (e, m) async {
        change(null, status: RxStatus.error(m));
      },
      onApiErrorFunction: (e, m) async {
        change(null, status: RxStatus.error(e.message.toString()));
      },
    );
  }

  void addNewAddressAction() {
    Get.toNamed(
      Routes.selectLocationFromMapScreen,
      arguments: {
        Arguments.isCheckoutAddress: false,
      },
    );
  }

  void editAddressAction(AddressModel addressModel) {
    Get.toNamed(
      Routes.selectLocationFromMapScreen,
      arguments: addressModel,
    );
  }

  Future<void> deleteAddressAction(BuildContext context,
      {required List<AddressModel> addresses,
      required AddressModel selectedAddress}) async {
    await HelperFunctions.errorRequestsSnakBarHandler<List<AddressModel>>(
      context,
      loadingFunction: () async {
        final isSuccess = await LinkTspApi.instance.address
            .deleteAddress(addressId: selectedAddress.id!);
        if (isSuccess == true) {
          addresses.remove(selectedAddress);
          change(addresses, status: RxStatus.success());
        }
        return addresses;
      },
    );
  }
}
