import '../../../core/localization/translate.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/utils/theme.dart';

class ProfileController extends GetxController with StateMixin<UserModel> {
  final formKey = GlobalKey<FormState>();

  Rx<CityModel?> selectedCity = Rx<CityModel?>(null);

  var selectedDate = DateTime.now().obs;
  var cities = <CityModel>[];
  var selectedGender = Gender.MALE;

  final firstNameTEC = TextEditingController(text: ''),
      lastNameTEC = TextEditingController(text: ''),
      emailTEC = TextEditingController(text: ''),
      mobileTEC = TextEditingController(text: ''),
      searchZoneTEController = TextEditingController(text: '');

  final _userSharedPrefrenceController =
      Get.find<UserSharedPrefrenceController>();

  String get getUserName =>
      '${_userSharedPrefrenceController.getUserFirstName} ${_userSharedPrefrenceController.getUserLastName}';

  String get getEmail => _userSharedPrefrenceController.getUserEmail ?? '';

  int? get _userId => _userSharedPrefrenceController.getUserId;
  @override
  void onReady() {
    super.onReady();
    init();
  }

  Future<void> init() async {
    await HelperFunctions.errorRequestsHandler<UserModel>(
      loadingFunction: () async {
        change(null, status: RxStatus.loading());
        const int userDataIndex = 0, citiesIndex = 1;
        final list = await Future.wait([
          LinkTspApi.instance.account.getProfileDetails(customerId: _userId!),
          LinkTspApi.instance.lookUp.getCities(),
        ]);

        final userData = list.elementAt(userDataIndex) as UserModel;
        cities = list.elementAt(citiesIndex) as List<CityModel>;
        cities.sort((a, b) {
          return a.name!.toLowerCase().compareTo(b.name!.toLowerCase());
        });
        return userData;
      },
      onSuccessFunction: (userData) async {
        _updateProfileData(userData);
        change(userData, status: RxStatus.success());
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

  void onGenderChanged(int? gender) {
    if (gender == 0) {
      selectedGender = Gender.MALE;
    } else {
      selectedGender = Gender.FEMALE;
    }
  }

  void _updateProfileData(UserModel userData) {
    firstNameTEC.text = userData.firstName ?? '';
    lastNameTEC.text = userData.lastName ?? '';
    emailTEC.text = userData.email ?? '';
    mobileTEC.text = userData.mobile ?? '';

    final dateNow = DateTime.now();
    final year = ((userData.year ?? 0) != 0) ? userData.year! : dateNow.year;
    final month =
        ((userData.month ?? 0) != 0) ? userData.month! : dateNow.month;
    final day = ((userData.day ?? 0) != 0) ? userData.day! : dateNow.day;
    selectedDate.value = DateTime(year, month, day);
    selectedGender = userData.gender ?? Gender.MALE;
    selectedCity.value = userData.city;
  }

  Future<void> onTapSave(BuildContext context) async {
    final isInputsInValid = !(formKey.currentState?.validate() ?? false);
    if (isInputsInValid) {
      return;
    }
    HelperFunctions.errorRequestsSnakBarHandler(
      context,
      loadingFunction: () async {
        final userModel = UserModel(
          id: _userId!,
          firstName: firstNameTEC.text,
          lastName: lastNameTEC.text,
          email: emailTEC.text,
          mobile: mobileTEC.text,
          gender: selectedGender,
          city: selectedCity.value,
          day: selectedDate.value.day,
          month: selectedDate.value.month,
          year: selectedDate.value.year,
        );
        final userData = await LinkTspApi.instance.account
            .updateProfile(userModel: userModel);
        _userSharedPrefrenceController.cacheUserData(
          emailAddress: userData.email,
          firstName: userData.firstName,
          idUser: userData.id,
          isActive: userData.isActive,
          lastName: userData.lastName,
          mobile: userData.mobile,
        );
      },
      onSuccessFunction: (v) async {
        Get.back();
        HelperFunctions.showSnackBar(
          message: Translate.successed.tr,
          context: context,
          color: CustomThemes.appTheme.primaryColor,
        );
      },
    );
  }

  CityModel? setCurrentCity(CityModel? city) {
    try {
      return cities.firstWhere((element) => element.id == city?.id);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<void> chooseDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: CustomThemes.appTheme.primaryColor, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: Colors.black, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      selectedDate.value = pickedDate;
    }
    update();
  }

  @override
  void onClose() {
    firstNameTEC.dispose();
    lastNameTEC.dispose();
    emailTEC.dispose();
    mobileTEC.dispose();

    super.onClose();
  }
}
