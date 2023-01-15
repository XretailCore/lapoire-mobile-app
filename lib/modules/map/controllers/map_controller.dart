import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:linktsp_api/core/models/zone_details_model.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/localization/translate.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/enums.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/utils/routes.dart';
import '../../../core/utils/strings.dart';
import '../../home/controllers/home_controller.dart';
import '../../settings/controller/language_controller.dart';
import 'nearset_zones_model.dart';

class MapController extends GetxController with StateMixin {
  var currentPostion = const LatLng(30.0444, 31.2357).obs;
  final currentAddress = ''.obs;
  final lat = 30.0444.obs;
  final lng = 31.2357.obs;
  final zoneMenu = <CityModel>[].obs;
  final searchZoneMenu = <CityModel>[].obs;
  final selectedAddress = ''.obs;
  final markers = <Marker>[];
  final selectedZoneDetailsModel = ZoneDetailsModel().obs;
  final _prefs = Get.find<UserSharedPrefrenceController>();
  final searchTextFilledController = TextEditingController();
  final _languageController = Get.find<LanguageController>();
  var zones = <CityModel>[];
  var nearestZones = <NearestZonesModel>[];
  var zonesDetailsList = <ZoneDetailsModel>[];

  @override
  void onReady() {
    super.onReady();
    change(null, status: RxStatus.loading());
    determinePosition();
    getZonesDetails();
    getZones();
  }

  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(HelperFunctions.customSnackBar(message: "Turn on GPS"));
      await getLocation(lat: 30.0444, lng: 31.2357);
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await getLocation(lat: 30.0444, lng: 31.2357);
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await getLocation(lat: 30.0444, lng: 31.2357);
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    await getLocation(lat: position.latitude, lng: position.longitude);
  }

  Future<void> getLocation({double lat = 30.0444, double lng = 31.2357}) async {
    final _prefs = Get.find<UserSharedPrefrenceController>();
    selectedAddress.value = _prefs.getCurrentZone?.name ?? "";
    currentPostion = LatLng(lat, lng).obs;
    addMakrer(lat, lng);
    List<Placemark> placemarks = await placemarkFromCoordinates(
      lat,
      lng,
      localeIdentifier: "en",
    );
    currentAddress.value =
        "${placemarks.first.thoroughfare}, ${placemarks.first.street}";
    this.lat.value = lat;
    this.lng.value = lng;

    change(null, status: RxStatus.success());
  }

  void onCameraMove(CameraPosition position) {
    lat.value = position.target.latitude;
    lng.value = position.target.longitude;
  }

  Future<void> getZonesDetails() async {
    zonesDetailsList = await LinkTspApi.instance.cart.getZoneDetails();
  }

  void addMakrer(double lat, double lng) {
    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId('SomeId'),
        position: LatLng(lat, lng),
        infoWindow: const InfoWindow(title: ''),
      ),
    );
  }

  Future<void> getZones() async {
    change(null, status: RxStatus.loading());
    try {
      zones = await LinkTspApi.instance.lookUp.getZoneLookup();
      if (zones.isNotEmpty) {
        zoneMenu.clear();
        for (int i = 0; i < zones.length; i++) {
          zoneMenu.add(CityModel(id: zones[i].id, name: zones[i].name));
        }
      } else {
        change(null, status: RxStatus.error());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _getFewerDistance() async {
    nearestZones.clear();
    for (var item in zonesDetailsList) {
      final distance = calculateDistance(
          lat.value, lng.value, item.latitude, item.longitude);
      nearestZones.add(
        NearestZonesModel(
          id: item.id,
          coverageArea: item.coverageArea,
          latitude: item.latitude,
          longitude: item.longitude,
          distance: distance,
        ),
      );
    }
    nearestZones.sort((a, b) => a.distance!.compareTo(b.distance!));
  }

  ZoneDetailsModel _ifDistanceInSelectedZone() {
    final zone = nearestZones.firstWhereOrNull(
            (element) => element.distance! < element.coverageArea!) ??
        NearestZonesModel();
    selectedZoneDetailsModel.value = ZoneDetailsModel(
        coverageArea: zone.coverageArea,
        id: zone.id,
        latitude: zone.latitude,
        longitude: zone.longitude);
    return selectedZoneDetailsModel.value;
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return (12742 * asin(sqrt(a))) * 1000; // by meter
  }

  Future<void> submitLocationAction() async {
    if (zones.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        HelperFunctions.customSnackBar(
          message: "No Zones Found",
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      await _getFewerDistance();
      ZoneDetailsModel nearestZone = _ifDistanceInSelectedZone();
      if (nearestZone.id != null) {
        onSubmitNewZone();
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          HelperFunctions.customSnackBar(
            message: Translate.yourLocationIsOutOfZoneRange.tr,
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  bool _checkIfZoneChanged() {
    if (_prefs.getCurrentZone?.id == null ||
        _prefs.getCurrentZone?.id != selectedZoneDetailsModel.value.id) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> onSubmitNewZone() async {
    if (zones.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        HelperFunctions.customSnackBar(
          message: "No Zones Found",
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      final isZoneChanged = _checkIfZoneChanged();
      var args = (Get.arguments ?? {}) as Map;
      final pageName = args[Arguments.mapPageName] ?? "";
      if (isZoneChanged) {
        _prefs.setCurrentZone = zoneMenu
            .where((e) => e.id == selectedZoneDetailsModel.value.id)
            .toList()[0];
        selectedAddress.value = _prefs.getCurrentZone?.name ?? "";
        await LinkTspApi.init(
            domain: domain,
            admin: admin,
            zoneid: _prefs.getCurrentZone?.id,
            lang: _languageController.getLanguageIdByName());
      }
      _submitActionByPage(pageName, isZoneChanged);
    }
  }

  void _submitActionByPage(String pageName, bool isZoneChanged) {
    if (pageName == MapPages.splashScreen.name) {
      // _checkIntro();
      Get.offAllNamed(Routes.dashboard);
    } else if (pageName == MapPages.homeScreen.name) {
      Get.back();
      if (isZoneChanged) {
        final homeController = Get.find<HomeController>();
        homeController.getPageBlock();
      }
    }
  }

  void searchInZones(String? val) {
    searchZoneMenu.value = zoneMenu
        .where((zone) =>
            zone.name!.toLowerCase().contains(val?.toLowerCase() ?? ""))
        .toList();
  }

  Future<void> getSearchResultLocation(BuildContext context, int zoneId) async {
    double lat = zonesDetailsList
        .where((element) => element.id == zoneId)
        .toList()[0]
        .latitude!;
    double lng = zonesDetailsList
        .where((element) => element.id == zoneId)
        .toList()[0]
        .longitude!;

    getLocation(lat: lat, lng: lng);
    searchTextFilledController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  void onClose() {
    searchTextFilledController.dispose();
    super.onClose();
  }
}
