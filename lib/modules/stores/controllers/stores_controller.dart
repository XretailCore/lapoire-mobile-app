import 'dart:async';

import 'package:linktsp_api/data/exception_api.dart';

import '../../../core/components/custom_loaders.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:linktsp_api/linktsp_api.dart';

class StoresController extends GetxController with StateMixin<Set<Marker>> {
  final mapController = Completer<GoogleMapController>();
  final _selectedDistance = Rx<int?>(null);
  int? get selectedDistance => _selectedDistance.value;
  set selectedDistance(int? v) => _selectedDistance.value = v;
  final distances = <int>[5, 10, 20];
  void _setDefaultDistance(int? defaultDistance) {
    selectedDistance = defaultDistance;
  }

  final _selectedCity = Rx<CityModel?>(null);
  final _allCities = Rx<List<CityModel>>([]);
  List<CityModel> get allCities => _allCities.value;
  set allCities(List<CityModel> v) => _allCities.value = v;
  set selectedCity(CityModel? city) => _selectedCity.value = city;
  CityModel? get selectedCity => _selectedCity.value;
  @override
  void onReady() {
    super.onReady();
    mapController.future.then((controller) async {
      try {
        final currentLocation = await _getCurrentLocation();
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target:
                  LatLng(currentLocation.latitude, currentLocation.longitude),
              zoom: 12,
            ),
          ),
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    }, onError: (e) {
      debugPrint(e.toString());
    });

    _init();
  }

  Future<void> _init() async {
    if (distances.isNotEmpty) {
      final defaultDistance = distances.first;
      _setDefaultDistance(defaultDistance);
    }
    try {
      change(null, status: RxStatus.loading());
      final futures = await Future.wait([
        getCities(),
        getStoresList(),
      ]);
      allCities = futures.first as List<CityModel>;
      _setDefaultCity();
      final stores = futures.last as List<StoreModel>;
      final markers = _convertStoresToMarkers(stores);
      change(markers, status: RxStatus.success());
    } on ExceptionApi catch (e) {
      change(null, status: RxStatus.error(e.message.toString()));
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  void _setDefaultCity() {
    try {
      selectedCity = allCities.firstWhere((element) => element.id == 1);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> searchByLocationAction(
    BuildContext context, {
    int? distance,
  }) async {
    openLoadingDialog(context);
    try {
      final currentLocation = await _getCurrentLocation();
      final storeFilterModel = StoreFilterModel(
          distance: distance,
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude);
      final stores = await LinkTspApi.instance.store
          .storesFilter(storeFilterModel: storeFilterModel);
      final markers = _convertStoresToMarkers(stores);
      if (markers.isNotEmpty) {
        final controller = await mapController.future;
        controller
            .animateCamera(CameraUpdate.newLatLngBounds(_bounds(markers), 50));
        Get.back();
        change(markers, status: RxStatus.success());
      } else {
        Get.back();
        HelperFunctions.showSnackBar(
          context: context,
          message: Translate.noStores.tr,
        );
      }
    } on ExceptionApi catch (e) {
      Get.back();

      HelperFunctions.showSnackBar(
        context: context,
        message: e.message.toString(),
      );
    } catch (e) {
      Get.back();

      HelperFunctions.showSnackBar(
        context: context,
        message: e.toString(),
      );
    }
  }

  LatLngBounds _createBounds(List<LatLng> positions) {
    final southwestLat = positions.map((p) => p.latitude).reduce(
        (value, element) => value < element ? value : element); // smallest
    final southwestLon = positions
        .map((p) => p.longitude)
        .reduce((value, element) => value < element ? value : element);
    final northeastLat = positions.map((p) => p.latitude).reduce(
        (value, element) => value > element ? value : element); // biggest
    final northeastLon = positions
        .map((p) => p.longitude)
        .reduce((value, element) => value > element ? value : element);
    return LatLngBounds(
        southwest: LatLng(southwestLat, southwestLon),
        northeast: LatLng(northeastLat, northeastLon));
  }

  LatLngBounds _bounds(Set<Marker> markers) {
    return _createBounds(markers.map((m) => m.position).toList());
  }

  Future<void> searchByCityAction(BuildContext context, CityModel? city) async {
    if (city == null) {
      HelperFunctions.showSnackBar(
        context: context,
        message: Translate.selectCity.tr,
      );
      return;
    }
    await HelperFunctions.errorRequestsSnakBarHandler(context,
        loadingFunction: () async {
      final storeFilterModel = StoreFilterModel(cityId: city.id);
      final stores = await LinkTspApi.instance.store
          .storesFilter(storeFilterModel: storeFilterModel);

      final markers = _convertStoresToMarkers(stores);

      if (markers.isNotEmpty) {
        final controller = await mapController.future;
        controller
            .animateCamera(CameraUpdate.newLatLngBounds(_bounds(markers), 50));

        change(markers, status: RxStatus.success());
      } else {
        HelperFunctions.showSnackBar(
          context: context,
          message: Translate.noStores.tr,
        );
      }
    });
  }

  Future<List<CityModel>> getCities() async {
    final cities = await LinkTspApi.instance.lookUp.getStoreCityLookup();
    cities.sort((a, b) {
      return a.name
          .toString()
          .toLowerCase()
          .compareTo(b.name.toString().toLowerCase());
    });
    return cities;
  }

  Future<Position> _getCurrentLocation() async {
    await Geolocator.requestPermission();
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  Future<List<StoreModel>> getStoresList() async =>
      await LinkTspApi.instance.lookUp.getStores();

  Set<Marker> _convertStoresToMarkers(List<StoreModel> stores) {
    return stores
        .map(
          (store) => Marker(
            markerId: MarkerId(store.id.toString()),
            position: LatLng(store.latitude ?? 0, store.longitude ?? 0),
            infoWindow: InfoWindow(
              title: store.name,
              snippet: store.mobile ?? store.telephone,
            ),
          ),
        )
        .toSet();
  }

  @override
  void onClose() {
    _selectedCity.close();
    _allCities.close();
    _selectedDistance.close();
    mapController.future.then(
      (controller) {
        controller.dispose();
      },
    );
    super.onClose();
  }
}
