import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:imtnan/core/utils/strings.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../../core/utils/helper_functions.dart';
import '../../../../core/utils/routes.dart';

class SelectLocationFromMapController extends GetxController {
  final mapController = Completer<GoogleMapController>();
  GoogleMapController? googleMapController;
  final defaultLatLng = const LatLng(30.0444, 31.2357);
  final _address = Rx<String>('');

  String get showAddressName => _address.value;

  set showAddressName(String v) => _address.value = v;

  late AddressModel addressModel;
  bool isCheckoutAddress = false;
  bool _isCreateAddress = true;

  @override
  void onReady() {
    super.onReady();
    final args = (Get.arguments ?? {}) as Map?;
    isCheckoutAddress =
    args == null ? null : (args[Arguments.isCheckoutAddress] ?? false);
    addressModel = args == null ? null : args[Arguments.addressModel] ?? AddressModel();
    if (addressModel.id !=null) {
      _isCreateAddress = false;
      _address.value=addressModel.address??"";
    } else {
      addressModel = AddressModel(
          longitude: defaultLatLng.longitude, latitude: defaultLatLng.latitude);
      _isCreateAddress = true;
    }
    _onInit();
  }

  Future<void> _onInit() async {
    await mapController.future.then((controller) async {
      final locationPermission = await Geolocator.requestPermission();
      HelperFunctions.errorRequestsSnakBarHandler(Get.context!,
          loadingFunction: () async {
        googleMapController = controller;
        if (_isCreateAddress &&
            (locationPermission == LocationPermission.always ||
                locationPermission == LocationPermission.whileInUse)) {
          final currentLocation = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best);
          addressModel = AddressModel(
              latitude: currentLocation.latitude,
              longitude: currentLocation.longitude);
        }
        await _moveCamMap(addressModel);
      });
    }, onError: (e) {
      debugPrint(e.toString());
    });
  }

  Future<void> _moveCamMap(AddressModel addressModel) async {
    return await googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(addressModel.latitude ?? 30.0444,
              addressModel.longitude ?? 31.2357),
          zoom: 18,
        ),
      ),
    );
  }

  Future<void> submitLocationAction() async {
    Get.toNamed(
      Routes.addressDetails,
      arguments: {
        Arguments.addressModel: addressModel,
        Arguments.isCheckoutAddress: isCheckoutAddress,
      },
    );
  }

  Future<void> onCameraIdle() async {
    await _onLocationChanged(
        latitude: addressModel.latitude??30.0444, longitude: addressModel.longitude??31.2357);
  }

  Future<void> _onLocationChanged(
      {required double latitude, required double longitude}) async {
    showAddressName = await _getNameOfCurrentPosition(
        latitude: latitude, longitude: longitude);
    addressModel.longitude = longitude;
    addressModel.latitude = latitude;
    addressModel.address = showAddressName;
  }

  Future<String> _getNameOfCurrentPosition(
      {required double latitude, required double longitude}) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      latitude,
      longitude,
      localeIdentifier: "en",
    );
    return "${placemarks.first.thoroughfare}, ${placemarks.first.street}";
  }

  @override
  void onClose() {
    googleMapController?.dispose();
    _address.close();
    super.onClose();
  }
}
