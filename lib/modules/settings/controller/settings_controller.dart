import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/components/custom_loaders.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/utils/routes.dart';
import '../../../core/utils/strings.dart';
import '../../../core/utils/theme.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../dashboard/controller/dashboard_controller.dart';

class SettingsController extends GetxController {
  RxBool disableNotifications = true.obs;
  final UserSharedPrefrenceController userSharedPrefrenceController =
      Get.find<UserSharedPrefrenceController>();
  @override
  void onReady() {
    super.onReady();
    getNotificationSubscribeValue();
  }

  Future<void> goToChangePasswordScreen() async {
    final userSharedPrefrenceController =
        Get.find<UserSharedPrefrenceController>();
    if (userSharedPrefrenceController.isUser) {
      Get.toNamed(Routes.changePasswordScreen);
    } else {
      Get.toNamed(Routes.sign);
    }
  }

  Future<void> goToAboutScreen() async {
    Get.toNamed(Routes.content, arguments: {
      Arguments.contentPageTitle: Translate.aboutUs.tr,
      Arguments.contentPageId: aboutUsId,
    });
  }

  void getNotificationSubscribeValue() {
    final userSharedPrefrenceController =
        Get.find<UserSharedPrefrenceController>();
    disableNotifications.value =
        userSharedPrefrenceController.getNotificationsSubscription ?? true;
  }

  void toggleNotifications(bool val) {
    disableNotifications.value = val;
    final userSharedPrefrenceController =
        Get.find<UserSharedPrefrenceController>();
    userSharedPrefrenceController.setNotificationsSubscription = val;
    !val ? FirebaseMessaging.instance.deleteToken() : sendDeviceToken();
  }

  Future<void> sendDeviceToken() async {
    try {
      String? token = await FCMConfig.instance.messaging.getToken();
      if (token != null) {
        await LinkTspApi.instance.account.notificationsToken(
            deviceToken: token,
            customerID: userSharedPrefrenceController.getUserId);
      }
    } catch (e) {
      return;
    }
  }

  Future<void> goToChangeSubscribeScreen() async {
    Get.toNamed(Routes.subscribeScreen);
  }

  @override
  void onClose() {
    disableNotifications.close();
    super.onClose();
  }

  Future<void> deleteAccountPopup() async {
    Get.defaultDialog(
      barrierDismissible: false,
      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      titlePadding: const EdgeInsets.only(top: 20),
      title: Translate.deleteAccount.tr.capitalizeFirst ?? '',
      titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      middleText: Translate.areYouWantToDeleteYourAccount.tr,
      middleTextStyle:
          const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
      actions: [
        OutlinedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            side: BorderSide(
                color: CustomThemes.appTheme.primaryColor, width: 1.5),
            elevation: 1,
          ),
          onPressed: () =>
              Navigator.of(Get.context!, rootNavigator: true).pop(),
          child: CustomText(
            Translate.no.name.tr.toUpperCase(),
            style: TextStyle(
              color: CustomThemes.appTheme.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        OutlinedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomThemes.appTheme.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 1,
          ),
          onPressed: deleteAccount,
          child: Text(
            Translate.yes.tr.toUpperCase(),
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Future<void> deactivateAccountPopup() async {
    Get.defaultDialog(
      barrierDismissible: false,
      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      titlePadding: const EdgeInsets.only(top: 20),
      title: Translate.deactivateAccount.tr.capitalizeFirst ?? '',
      titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      middleText: Translate.areYouWantToDeactivateYourAccount.tr,
      middleTextStyle:
          const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
      actions: [
        OutlinedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            side: BorderSide(
                color: CustomThemes.appTheme.primaryColor, width: 1.5),
            elevation: 1,
          ),
          onPressed: () =>
              Navigator.of(Get.context!, rootNavigator: true).pop(),
          child: CustomText(
            Translate.no.name.tr.toUpperCase(),
            style: TextStyle(
              color: CustomThemes.appTheme.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        OutlinedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomThemes.appTheme.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 1,
          ),
          onPressed: deactivateAccount,
          child: Text(
            Translate.yes.tr.toUpperCase(),
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Future<void> deleteAccount() async {
    openLoadingDialog(Get.context!);

    await HelperFunctions.errorHandler(Get.context!, () async {
      await LinkTspApi.instance.account
          .delete(customerId: userSharedPrefrenceController.getUserId ?? 0);
      HelperFunctions.showSnackBar(
        message: Translate.accountDeletedSuccessfully.tr,
        context: Get.context!,
      );
      Get.back();
      signOut();
    });
  }

  Future<void> deactivateAccount() async {
    openLoadingDialog(Get.context!);

    await HelperFunctions.errorHandler(Get.context!, () async {
      await LinkTspApi.instance.account
          .deactivate(customerId: userSharedPrefrenceController.getUserId ?? 0);
      HelperFunctions.showSnackBar(
        message: Translate.accountDeactivatedSuccessfully.tr,
        context: Get.context!,
      );
      Get.back();
      signOut();
    });
  }

  Future<void> signOut() async {
    userSharedPrefrenceController.clearCacheUserData();
    final DashboardController dashboardController =
        Get.find<DashboardController>();
    dashboardController.navigationBarController.jumpToPage(0);
    final cartController = Get.find<CartController>();
    cartController.clearGuestCart();
    Get.offAllNamed(Routes.dashboard);
  }
}
