import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../my_account/controllers/my_account_controller.dart';
import '../../categories/controllers/categories_controller.dart';
import 'package:linktsp_api/linktsp_api.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../settings/controller/settings_controller.dart';
import '../../wishlist/controllers/wishlist_controller.dart';
import '../widgets/update_dialog.dart';

class DashboardController extends GetxController with StateMixin<SettingModel> {
  int? tabIndex;
  var counter = 0;
  late SettingModel settingData;
  double? versionNumber;
  List<Version>? versions;
  final navigationBarController = PageController(initialPage: 2);

  @override
  void onReady() {
    super.onReady();
    checkForUpdate();

    setNotificationsSubscribe();
    _onSwipeBetweenViews();
  }

  void _onSwipeBetweenViews() {
    navigationBarController.addListener(
      () async {
        switch (navigationBarController.page!.toInt()) {
          case 1:
            final categories = Get.find<CategoriesController>();
            await categories.init();
            break;

          case 3:
            final wishList = Get.find<WishlistController>();
            await wishList.setWishList();
            break;
          case 4:
            final profileController = Get.find<MyAccountController>();
            await profileController.getCustomerSummary();
            break;
          default:
            break;
        }
      },
    );
  }

  void updateIndex(int newIndex) {
    if (navigationBarController.hasClients) {
      navigationBarController.jumpToPage(newIndex);
    }
  }

  void setNotificationsSubscribe() {
    final controller = Get.find<SettingsController>();
    controller.getNotificationSubscribeValue();
  }

  Future<void> getVersionNumber() async {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String version;
      version = packageInfo.version;

      List newVersion = version.split(".");
      String checkVersion = "${newVersion[0]}.${newVersion[1]}${newVersion[2]}";
      versionNumber = double.tryParse(checkVersion);
    });
  }

  Future<void> checkForUpdate() async {
    await getVersionNumber();
    settingData = (await LinkTspApi.instance.setting.getVersions());

    versions = (settingData.versions ?? []);
    if (!kDebugMode) showUpdateDialog();
  }

  void showUpdateDialog() {
    List<Version> latestVersion = [];
    for (int i = 0; i < versions!.length; i++) {
      if (versions![i].available! && versions![i].serial! > versionNumber!) {
        latestVersion.add(versions![i]);
        break;
      }
    }
    if (latestVersion.isNotEmpty) {
      if (!settingData.forceUpdate!) {
        showFlexibleUpdateDialog(Get.context!, () => onUpdateTap());
      } else {
        showForceUpdateDialog(Get.context!, () => onUpdateTap());
      }
    }
  }

  void onUpdateTap() {
    final controller = Get.find<MyAccountController>();
    if (!settingData.forceUpdate!) {
      Navigator.of(Get.context!, rootNavigator: true).pop();
    }

    controller.sendToRateApp(Get.context!);
  }
}
