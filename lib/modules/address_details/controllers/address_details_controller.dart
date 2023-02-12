// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:linktsp_api/data/exception_api.dart';
import '../../../core/components/custom_loaders.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/utils/strings.dart';
import '../../../core/utils/validation.dart';
import '../../check_out/controllers/customer_location_controller.dart';
import '../../my_addresses/controller/my_addresses_controller.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:linktsp_api/linktsp_api.dart';

class AddressDetailsController extends GetxController with StateMixin {
  AddressModel addressModel = AddressModel();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final streetNameController = TextEditingController();
  final mobileController = TextEditingController();
  final postalCodeController = TextEditingController();
  final addressNameController = TextEditingController(text: '');
  final buildingNumberController = TextEditingController();
  final apartmentNumberController = TextEditingController();
  final floorNumberController = TextEditingController();
  Rx<LatLng> currentPostion = const LatLng(30.110972, 30.317374).obs;
  int? addressId;
  Completer<GoogleMapController> mapController = Completer();
  final List<Marker> markers = <Marker>[];
  final formKey = GlobalKey<FormState>();
  RxBool? isDefaultAddress = false.obs;
  RxList<CityModel> zoneMenu = <CityModel>[].obs;
  final Rx<CityModel?> selectedZone = Rx<CityModel?>(null);
  Rx<CityModel> selectedAddressName = const CityModel().obs;
  RxString selectedZoneName = ''.obs;
  RxList<CityModel> districtMenu = <CityModel>[].obs;
  Rx<CityModel?> selectedDistrict = Rx<CityModel?>(null);
  RxString selectedDistrictName = ''.obs;
  RxString currentAddress = ''.obs;
  RxDouble lat = 0.0.obs;
  RxDouble lng = 0.0.obs;
  RxString firstNameError = "".obs;
  RxString lastNameError = "".obs;
  RxString addressNameError = "".obs;
  RxString streetNameError = "".obs;
  RxString buildingNumberError = "".obs;
  RxString flooNumberError = "".obs;
  RxString apartmentNumberError = "".obs;
  RxString mobileNumberError = "".obs;
  final _prefs = Get.find<UserSharedPrefrenceController>();
  bool isCheckoutAddress = false;
  final TextEditingController searchZoneTEController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.loading());
    getAddressDetails();
    getZones();
  }

  void getAddressDetails() async {
    change(null, status: RxStatus.loading());
    final args = (Get.arguments ?? {}) as Map?;
    isCheckoutAddress =
    args == null ? null : (args[Arguments.isCheckoutAddress] ?? false);
    addressModel = args == null ? null : args[Arguments.addressModel] ?? AddressModel();
    addressId=addressModel.id;
    streetNameController.text =addressModel.address ?? "";
    lat.value = 0;
    lng.value = 0;
    lat.value = addressModel.latitude ?? 30.110972;
    lng.value = addressModel.longitude ?? 31.317374;
    try {
      if (addressId != null) {
        addressModel = await LinkTspApi.instance.address
            .getAddressDetails(addressId: addressId!);
        if (addressModel.id != null) {
          isDefaultAddress!.value = addressModel.isDefault ?? true;
          firstNameController.text = addressModel.firstName ?? "";
          addressNameController.text = addressModel.name ?? '';
          lastNameController.text = addressModel.lastName ?? "";
          buildingNumberController.text = addressModel.building ?? "";
          floorNumberController.text = addressModel.floor ?? "";
          apartmentNumberController.text = addressModel.apartment ?? "";
          mobileController.text = addressModel.mobile ?? "";
          getLocation(lat: lat.value, lng: lng.value);
        } else {
          getLocation(lat: lat.value, lng: lng.value);
          change(null, status: RxStatus.error());
        }
      } else {
        getLocation(lat: lat.value, lng: lng.value);
      }
    } catch (e) {
      getLocation(lat: lat.value, lng: lng.value);
      change(null, status: RxStatus.error());
    }
  }

  Future editAddress({required BuildContext context}) async {
    final controller = Get.find<UserSharedPrefrenceController>();
    final addressBookController = Get.find<MyAddressesController>();
    final customerLocationController = Get.find<CustomerLocationController>();
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      openLoadingDialog(context);
      try {
        AddressModel result = await LinkTspApi.instance.address.saveAddress(
          addressModel: AddressModel(
            id: addressId,
            apartment: apartmentNumberController.text,
            building: buildingNumberController.text,
            customerId: controller.getUserId!,
            floor: floorNumberController.text,
            isDefault: isDefaultAddress!.value,
            zoneId: selectedZone.value?.id ?? 36,
            city: CityModel(
                id: selectedDistrict.value?.id,
                name: selectedDistrict.value?.name),
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            name: addressNameController.text,
            address: streetNameController.text,
            mobile: changeNumericToEnglish(mobileController.text),
            latitude: lat.value == 0.0 ? null : lat.value,
            longitude: lng.value == 0.0 ? null : lng.value,
          ),
        );
        if (result.id != null) {
          addressBookController.getAddresses();
          customerLocationController.onInit();
          change(addressModel, status: RxStatus.success());
          Get.back(); // this one is for closing loading dialog
          Get.back();
          ScaffoldMessenger.of(context).showSnackBar(
            HelperFunctions.customSnackBar(
                message: Translate.addressHasBeenSavedSuccessfuly.tr),
          );
          Get.back();
        } else {
          Get.back();
          ScaffoldMessenger.of(context).showSnackBar(
            HelperFunctions.customSnackBar(
                message: Translate.error.tr, backgroundColor: Colors.red),
          );
        }
      } on ExceptionApi catch (e) {
        Get.back();
        ScaffoldMessenger.of(context).showSnackBar(
          HelperFunctions.customSnackBar(
              message: e.message, backgroundColor: Colors.red),
        );
      } catch (e) {
        Get.back();
        ScaffoldMessenger.of(context).showSnackBar(
          HelperFunctions.customSnackBar(
              message: e.toString(), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future getZones() async {
    final args = (Get.arguments ?? {}) as Map?;
    final isCheckoutAddress =
    args == null ? null : (args[Arguments.isCheckoutAddress] ?? false);
    // change(null, status: RxStatus.loading());
    try {
      List<CityModel> zones = await LinkTspApi.instance.lookUp.getZoneLookup();
      if (zones.isNotEmpty) {
        zoneMenu.clear();
        for (int i = 0; i < zones.length; i++) {
          zoneMenu.add(CityModel(id: zones[i].id, name: zones[i].name));
        }
        zoneMenu.sort((a, b) {
          return a.name!.toLowerCase().compareTo(b.name!.toLowerCase());
        });
        List<CityModel> searchZoneMenu = [];
        if (isCheckoutAddress) {
          searchZoneMenu = zoneMenu
              .where((zone) => zone.id == (_prefs.getCurrentZone!.id))
              .toList();
          selectedZone.value = searchZoneMenu.first;
          selectedZoneName.value = selectedZone.value?.name ?? '';
          getDistrict(_prefs.getCurrentZone!.id!);
        } else {
          int? selectedZoneId;
          if(addressModel.zoneId !=null)
            {
              selectedZoneId=addressModel.zoneId;
            }
          if(selectedZoneId !=null)
            {
              searchZoneMenu =
                  zoneMenu.where((zone) => zone.id == selectedZoneId).toList();
              selectedZone.value = searchZoneMenu.first;
              selectedZoneName.value = selectedZone.value?.name ?? '';
            }
          getDistrict(selectedZone.value?.id ?? 0);
        }
      } else {
        change(null, status: RxStatus.error());
      }
    } catch (e) {
      change(null, status: RxStatus.error());
    }
  }

  bool _checkIfZoneContainsDistrict() {
    if (districtMenu
        .where((zone) => zone.id == addressModel.city?.id)
        .toList()
        .isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future getDistrict(int zoneId) async {
    // change(null, status: RxStatus.loading());
    List<CityModel> districts = await LinkTspApi.instance.lookUp
        .getCityPerZoneLookup(zoneId: selectedZone.value?.id ?? 0);
    if (districts.isNotEmpty) {
      districtMenu.clear();
      for (int i = 0; i < districts.length; i++) {
        districtMenu
            .add(CityModel(id: districts[i].id, name: districts[i].name));
      }
      districtMenu.sort((a, b) {
        return a.name!.toLowerCase().compareTo(b.name!.toLowerCase());
      });
      if (addressId != null) {
        selectedDistrict.value = _checkIfZoneContainsDistrict()
            ? districtMenu
            .where((district) => district.id == addressModel.city?.id)
            .toList()
            .first
            : districtMenu.first;
        selectedDistrictName.value = selectedDistrict.value?.name ?? '';
      }
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error());
    }
  }

  void addMakrer(double lat, double lng) {
    markers.clear();
    markers.add(Marker(
        markerId: const MarkerId('SomeId'),
        position: LatLng(lat, lng),
        infoWindow: const InfoWindow(title: '')));
  }

  Future<void> getLocation(
      {double lat = 30.110972, double lng = 31.317374}) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      lat,
      lng,
      localeIdentifier: "en",
    );
    currentAddress.value =
    "${placemarks.first.thoroughfare}, ${placemarks.first.street}";
    streetNameController.text = currentAddress.value;
    this.lat.value = lat;
    this.lng.value = lng;
    currentPostion.value = LatLng(this.lat.value, this.lng.value);
    addMakrer(this.lat.value, this.lng.value);
    change(addressModel, status: RxStatus.success());
  }

  String? getFirstNameError(String? error) {
    firstNameError.value = error ?? "";
    return firstNameError.value == "" ? null : firstNameError.value;
  }

  String? getLastNameError(String? error) {
    lastNameError.value = error ?? "";
    return lastNameError.value == "" ? null : lastNameError.value;
  }

  String? getAddressNameError(String? error) {
    addressNameError.value = error ?? "";
    return addressNameError.value == "" ? null : addressNameError.value;
  }

  String? getStreetNameError(String? error) {
    streetNameError.value = error ?? "";
    return streetNameError.value == "" ? null : streetNameError.value;
  }

  String? getBuildingNumberError(String? error) {
    buildingNumberError.value = error ?? "";
    return buildingNumberError.value.isEmpty ? null : buildingNumberError.value;
  }

  String? getFloorNumberError(String? error) {
    flooNumberError.value = error ?? "";
    return flooNumberError.value.isEmpty ? null : flooNumberError.value;
  }

  String? getApartmentNumberError(String? error) {
    apartmentNumberError.value = error ?? "";
    return apartmentNumberError.value.isEmpty
        ? null
        : apartmentNumberError.value;
  }

  String? getMobileNumbetError(String? error) {
    mobileNumberError.value = error ?? "";
    return mobileNumberError.value.isEmpty ? null : mobileNumberError.value;
  }

  void onMapComplete(GoogleMapController googleController) {
    if (!mapController.isCompleted) mapController.complete(googleController);
  }

  void onMapAction() {
    // Get.toNamed(Routes.addressMap, arguments: {
    //   Arguments.lat: addressModel.latitude,
    //   Arguments.lng: addressModel.longitude,
    //   Arguments.address: addressModel.address,
    //   Arguments.addressModel: addressModel,
    //   Arguments.isMapAction: true,
    // });
  }

  void onAddressNameChange(CityModel value) {
    selectedAddressName.value = value;
  }

  void onDistricChange(String value) {
    selectedDistrict.value =
        districtMenu.where((e) => e.name == value).toList().first;
    selectedDistrictName.value = value;
  }
  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    addressNameController.dispose();
    streetNameController.dispose();
    buildingNumberController.dispose();
    floorNumberController.dispose();
    apartmentNumberController.dispose();
    mobileController.dispose();
    isDefaultAddress?.close();
    selectedZone.close();
    selectedDistrict.close();
    districtMenu.close();
    super.onClose();
  }
}
