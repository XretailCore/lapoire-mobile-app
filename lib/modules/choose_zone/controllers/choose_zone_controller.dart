import 'dart:async';
import 'package:get/get.dart';
import 'package:imtnan/core/localization/lanaguages_enum.dart';
import 'package:imtnan/core/utils/strings.dart';
import 'package:imtnan/modules/cart/controllers/cart_controller.dart';
import 'package:imtnan/modules/home/controllers/home_controller.dart';
import 'package:imtnan/modules/map/controllers/map_controller.dart';
import 'package:imtnan/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:linktsp_api/linktsp_api.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/routes.dart';

class ZoneController extends GetxController with StateMixin<List<CityModel>> {
  List<CityModel> zonesList = <CityModel>[];
  final RxString selectedZoneName = ''.obs;
  final Rx<CityModel> selectedZone = const CityModel().obs;
  RxList<CityModel> feedbackMenu = <CityModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getZones();
  }

  Future getZones() async {
    final prefs = Get.find<UserSharedPrefrenceController>();
    change(null, status: RxStatus.loading());
    try {
      feedbackMenu.clear();
      zonesList = await LinkTspApi.instance.lookUp.getZoneLookup();
      if (zonesList.isEmpty) {
        change(null, status: RxStatus.empty());
      } else {
        for (int i = 0; i < zonesList.length; i++) {
          feedbackMenu
              .add(CityModel(id: zonesList[i].id, name: zonesList[i].name));
        }
        //var zone=feedbackMenu.firstWhere((element) => element.id==prefs.getCurrentZone!.id);
        selectedZone.value = prefs.getCurrentZone ?? const CityModel();
        selectedZone.value = feedbackMenu
            .firstWhere((element) => element.id == selectedZone.value.id);
        selectedZoneName.value = selectedZone.value.name??"";
        change(zonesList, status: RxStatus.success());
      }
    } catch (e) {
      change(null, status: RxStatus.error());
    }
  }

  Future<void> onChangeZone(newValue) async {
    selectedZone.value = newValue as CityModel;
  }

  Future<void> onChooseZone(newValue) async {
    selectedZone.value = newValue as CityModel;
    selectedZoneName.value = newValue.name ?? '';
    final prefs = Get.find<UserSharedPrefrenceController>();
    prefs.setCurrentZone = selectedZone.value;
    await LinkTspApi.init(
        admin: admin, domain: domain, zoneid: prefs.getCurrentZone?.id);
    Get.offAllNamed(Routes.dashboard);
  }

  Future<void> onSubmitNewZone({Function()? afterSubmitZoneAction}) async {
    final prefs = Get.find<UserSharedPrefrenceController>();
    final mapController = Get.find<MapController>();
    final cartController = Get.find<CartController>();
    final wishListController = Get.find<WishlistController>();
    final homeController = Get.find<HomeController>();
    var languageId = prefs.getLanguage == Languages.en.name ? 1 : 2;
    prefs.setCurrentZone = selectedZone.value;
    await LinkTspApi.init(
        domain: domain,
        admin: admin,
        zoneid: prefs.getCurrentZone?.id,
        lang: languageId);
    await homeController.getPageBlock();
    await cartController.getCart();
    await wishListController.setWishList();
    selectedZoneName.value = selectedZone.value.name ?? "";
    mapController.selectedAddress.value = selectedZone.value.name ?? "";
    if (afterSubmitZoneAction != null) afterSubmitZoneAction();
    Get.back();
  }
}
