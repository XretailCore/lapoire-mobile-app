import 'package:imtnan/core/utils/helper_functions.dart';

import '../../dashboard/controller/dashboard_controller.dart';
import '../../../core/localization/lanaguages_enum.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/strings.dart';
import '../../home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';

class LanguageController extends GetxController {
  final english = 1, arabic = 2;

  Future<void> changeLanguage(BuildContext context,
      {required Languages language}) async {
    return await HelperFunctions.errorRequestsSnakBarHandler(
      context,
      loadingFunction: () async {
        await Get.updateLocale(Locale(language.name));
        final userSharedPrefrenceController =
            Get.find<UserSharedPrefrenceController>();
        var currentZone = userSharedPrefrenceController.getCurrentZone;
        currentZone = const CityModel(
          id: 29,
        );
        await LinkTspApi.init(
          domain: domain,
          admin: admin,
          zoneid: currentZone.id ?? 0,
          lang: getLanguageId(language.name),
        );
        userSharedPrefrenceController.setLanguage = language.name;
        final homeController = Get.find<HomeController>();
        homeController.init();
        final dashboardController = Get.find<DashboardController>();
        dashboardController.updateIndex(0);
        Get.back();
      },
    );
  }

  Future<void> setDefaultLanguage() async {
    final userSharedPrefrenceController =
        Get.find<UserSharedPrefrenceController>();
    return await Get.updateLocale(
        Locale(userSharedPrefrenceController.getLanguage));
  }

  int getLanguageId(String language) {
    if (Languages.en.name == language) {
      return english;
    } else if (Languages.ar.name == language) {
      return arabic;
    }
    return english;
  }

  int getLanguageIdByName() {
    final userSharedPrefrenceController =
        Get.find<UserSharedPrefrenceController>();
    final language = userSharedPrefrenceController.getLanguage;
    if (Languages.en.name == language) {
      return english;
    } else if (Languages.ar.name == language) {
      return arabic;
    }
    return english;
  }
}
