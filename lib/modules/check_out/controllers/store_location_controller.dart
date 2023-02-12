import '../../../core/components/custom_loaders.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/data/exception_api.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/utils/helper_functions.dart';
import '../../../core/utils/routes.dart';
import 'locations.dart';
import '../enum/stores_enum.dart';

import 'customer_summary_controller.dart';

class StoreLocationController extends GetxController
    with StateMixin<List<StoreModel>?> {
  late final CustomerSummaryController _customerSummaryController;
  @override
  void onInit() {
    super.onInit();

    Locations.storeId = null;
    Locations.locationId = null;
    _customerSummaryController = Get.find<CustomerSummaryController>();
    final UserSharedPrefrenceController userSharedPrefrenceController =
    Get.find<UserSharedPrefrenceController>();
    getStores(position: userSharedPrefrenceController.getCurrentLocation);
    HelperFunctions.vibrate();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      HelperFunctions.showSnackBar(
          message: Translate.pleaseSelectStore.tr,
          context: Get.context!,
          duration: const Duration(seconds: 6));
    });
  }

  Future<void> onTapSelectStore(
      BuildContext context, int index, StoreModel store) async {
    Locations.storeId = store.id!;
    update();
  }

  Future<void> getStores(
      {Position? position, Stores storeFilter = Stores.nearstStores}) async {
    try {
      change(null, status: RxStatus.loading());
      List<StoreModel>? stores;

      if (storeFilter == Stores.nearstStores) {
        stores = await LinkTspApi.instance.store.storesFilter(
            storeFilterModel: StoreFilterModel(
                latitude: position?.latitude, longitude: position?.longitude));
      } else if (storeFilter == Stores.allStores) {
        stores = await LinkTspApi.instance.lookUp.getStores();
      }

      change(stores, status: RxStatus.success());
    } on ExceptionApi catch (e) {
      change(null, status: RxStatus.error(e.message.toString()));
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> onTapNext(BuildContext context) async {
    openLoadingDialog(context);
    await _customerSummaryController.getSummaryData();
    Get.back();

    Get.toNamed(Routes.paymentScreen);
  }
}
