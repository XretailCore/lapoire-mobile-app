import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/localization/translate.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/utils/validation.dart';
import '../../check_out/controllers/customer_location_controller.dart';
import '../../my_addresses/controller/my_addresses_controller.dart';

class AddressDetailsController extends GetxController
    with StateMixin<List<CityModel>> {
  final mapController = Completer<GoogleMapController>();
  final formKey = GlobalKey<FormState>();
  final TextEditingController searchZoneTEController = TextEditingController();

  final firstNameTEC = TextEditingController(text: ''),
      lastNameTEC = TextEditingController(text: ''),
      addressNameTEC = TextEditingController(text: ''),
      streetNameTEC = TextEditingController(text: ''),
      mobileTEC = TextEditingController(text: ''),
      postalCodeTEC = TextEditingController(text: ''),
      buildingNumberTEC = TextEditingController(text: ''),
      apartmentNumberTEC = TextEditingController(text: ''),
      floorNumberTEC = TextEditingController(text: '');

  final _isDefaultAddress = false.obs;
  bool get isDefaultAddress => _isDefaultAddress.value;
  set isDefaultAddress(bool v) => _isDefaultAddress.value = v;

  final _selectedCity = Rx<CityModel?>(null);
  CityModel? get selectedZone => _selectedCity.value;
  set selectedZone(CityModel? v) => _selectedCity.value = v;

  final _selectedDistrict = Rx<CityModel?>(null);
  CityModel? get selectedDistrict => _selectedDistrict.value;
  set selectedDistrict(CityModel? v) => _selectedDistrict.value = v;

  final districts = RxList<CityModel>();
  AddressModel? addressModel;
  @override
  void onReady() {
    super.onReady();
    if (Get.arguments is AddressModel) {
      addressModel = Get.arguments;
    }
    init();
  }

  Future<void> init() async {
    await HelperFunctions.errorRequestsHandler<List<CityModel>>(
      loadingFunction: () async {
        change(null, status: RxStatus.loading());
        final zones = await LinkTspApi.instance.lookUp.getZoneLookup();
        zones.sort((a, b) {
          return a.name!.toLowerCase().compareTo(b.name!.toLowerCase());
        });
        return zones;
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
      onSuccessFunction: (zones) async {
        if (zones.isEmpty) {
          change(zones, status: RxStatus.empty());
          return;
        }
        await _setAddressDetails(zones);
        change(zones, status: RxStatus.success());
      },
    );
  }

  Future<void> _setAddressDetails(List<CityModel> zones) async {
    final userSharedPrefrenceController =
        Get.find<UserSharedPrefrenceController>();
    firstNameTEC.text = addressModel?.firstName ??
        userSharedPrefrenceController.getUserFirstName;
    lastNameTEC.text =
        addressModel?.lastName ?? userSharedPrefrenceController.getUserLastName;
    addressNameTEC.text = addressModel?.name ?? '';
    streetNameTEC.text = addressModel?.address ?? '';
    buildingNumberTEC.text = addressModel?.building ?? '';
    floorNumberTEC.text = addressModel?.floor ?? '';
    apartmentNumberTEC.text = addressModel?.apartment ?? '';
    mobileTEC.text = addressModel?.mobile ?? '';
    isDefaultAddress = addressModel?.isDefault ?? false;
    try {
      selectedZone =
          zones.firstWhere((element) => element.id == addressModel?.zoneId);
      if (selectedZone?.id != null) {
        await _setDistrict(Get.context!, selectedZone!.id!);
        selectedDistrict = districts
            .firstWhere((element) => element.id == addressModel?.city?.id);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _setDistrict(BuildContext context, int zoneId) async {
    await HelperFunctions.errorRequestsSnakBarHandler<List<CityModel>>(
      context,
      loadingFunction: () async {
        final districts = await LinkTspApi.instance.lookUp
            .getCityPerZoneLookup(zoneId: zoneId);
        districts.sort((a, b) {
          return a.name!.toLowerCase().compareTo(b.name!.toLowerCase());
        });
        return districts;
      },
      onSuccessFunction: (d) async {
        districts.clear();
        districts.addAll(d);
      },
    );
  }

  Future<void> onChangeZone(CityModel? newValue, BuildContext context) async {
    selectedZone = newValue;
    selectedDistrict = null;
    if (selectedZone?.id != null) {
      await _setDistrict(context, selectedZone!.id!);
    }
  }

  Future<void> saveAddress({required BuildContext context}) async {
    if (formKey.currentState?.validate() ?? false) {
      await HelperFunctions.errorRequestsSnakBarHandler(context,
          loadingFunction: () async {
        final userSharedPrefrenceController =
            Get.find<UserSharedPrefrenceController>();
        final address = AddressModel(
          id: addressModel?.id,
          apartment: apartmentNumberTEC.text,
          building: buildingNumberTEC.text,
          customerId: userSharedPrefrenceController.getUserId!,
          floor: floorNumberTEC.text,
          isDefault: isDefaultAddress,
          zoneId: selectedZone?.id,
          city: selectedDistrict,
          firstName: firstNameTEC.text,
          lastName: lastNameTEC.text,
          name: addressNameTEC.text,
          address: streetNameTEC.text,
          mobile: changeNumericToEnglish(mobileTEC.text),
          postalCode: postalCodeTEC.text,
          latitude: addressModel?.latitude,
          longitude: addressModel?.longitude,
        );
        await LinkTspApi.instance.address.saveAddress(
          addressModel: address,
        );

        final addressBookController = Get.find<MyAddressesController>();
        addressBookController.getAddresses();
        final customerLocationController =
            Get.find<CustomerLocationController>();
        await customerLocationController.init();
        ScaffoldMessenger.of(context).showSnackBar(
          HelperFunctions.customSnackBar(
              message: Translate.addressHasBeenSavedSuccessfuly.tr),
        );
        Get.back();
        Get.back();
      });
    }
  }

  @override
  void onClose() {
    firstNameTEC.dispose();
    lastNameTEC.dispose();
    addressNameTEC.dispose();
    streetNameTEC.dispose();
    buildingNumberTEC.dispose();
    floorNumberTEC.dispose();
    apartmentNumberTEC.dispose();
    mobileTEC.dispose();
    _isDefaultAddress.close();
    _selectedCity.close();
    _selectedDistrict.close();
    districts.close();
    super.onClose();
  }
}
