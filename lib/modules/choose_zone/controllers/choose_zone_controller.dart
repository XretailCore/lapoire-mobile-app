import 'dart:async';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/routes.dart';
import '../../../core/utils/strings.dart';
import '../../settings/controller/language_controller.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';

class ZoneController extends GetxController with StateMixin<List<CityModel>> {
  List<CityModel> zonesList = <CityModel>[];
  final RxString selectedZoneName = ''.obs;
  final Rx<CityModel> selectedZone = const CityModel().obs;
  RxList<CityModel> feedbackMenu = <CityModel>[].obs;
  final LanguageController _languageController = Get.find<LanguageController>();
  @override
  void onReady() {
    super.onReady();
    getZones();
  }

  Future getZones() async {
    final _prefs = Get.find<UserSharedPrefrenceController>();
    change(null, status: RxStatus.loading());
    try {
      zonesList = await LinkTspApi.instance.lookUp.getZoneLookup();
      if (zonesList.isEmpty) {
        change(null, status: RxStatus.empty());
      } else {
        for (int i = 0; i < zonesList.length; i++) {
          feedbackMenu
              .add(CityModel(id: zonesList[i].id, name: zonesList[i].name));
        }

        selectedZone.value = feedbackMenu[0];
        selectedZoneName.value = _prefs.getCurrentZone?.name == null
            ? selectedZone.value.name ?? ''
            : _prefs.getCurrentZone?.name ?? "";
        change(zonesList, status: RxStatus.success());
      }
    } catch (e) {
      change(null, status: RxStatus.error());
    }
  }

  Future<void> onChooseZone(newValue) async {
    selectedZone.value = newValue as CityModel;
    selectedZoneName.value = newValue.name ?? '';
    final _prefs = Get.find<UserSharedPrefrenceController>();
    _prefs.setCurrentZone = selectedZone.value;
    final languageId = _languageController.getLanguageIdByName();
    await LinkTspApi.init(
      domain: domain,
      admin: admin,
      zoneid: _prefs.getCurrentZone?.id,
      lang: languageId,
    );
    checkIntro();
  }

  void checkIntro() {
    final _prefs = Get.find<UserSharedPrefrenceController>();
    bool skipIntro = _prefs.getSkipIntro ?? false;
    Timer(const Duration(milliseconds: 500), () {
      skipIntro
          ? Get.offAllNamed(Routes.dashboard)
          : Get.offAllNamed(Routes.intro);
    });
    _prefs.setSkipIntro = true;
  }

  Future<void> onChangeZone(newValue) async {
    final _prefs = Get.find<UserSharedPrefrenceController>();
    selectedZone.value = newValue as CityModel;
    selectedZoneName.value = newValue.name ?? '';
    _prefs.setCurrentZone = selectedZone.value;
    await LinkTspApi.init(
        domain: domain,
        admin: admin,
        zoneid: _prefs.getCurrentZone?.id,
        lang: _languageController.getLanguageIdByName());
  }

  Future<void> onSubmitNewZone(
      {Function()? afterSubmitZoneAction, String? address}) async {
    final _prefs = Get.find<UserSharedPrefrenceController>();
    _prefs.setCurrentZone = selectedZone.value;
    selectedZoneName.value = address ?? selectedZone.value.name ?? "";
    if (afterSubmitZoneAction != null) afterSubmitZoneAction();
    Get.offAllNamed(Routes.dashboard);
  }
}
