import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_store/open_store.dart';
import 'package:share/share.dart';
import '../../../core/utils/firebase_auth.dart';
import '../../../core/utils/strings.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../../core/utils/helper_functions.dart';
import 'package:linktsp_api/linktsp_api.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/routes.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../../home/widgets/language_widget.dart';
import '../../wishlist/controllers/wishlist_controller.dart';

class MyAccountController extends GetxController
    with StateMixin<CustomerSummaryModel?> {
  final userSharedPrefrenceController =
      Get.find<UserSharedPrefrenceController>();

  Future<void> getCustomerSummary() async {
    final userSharedPrefrenceController =
        Get.find<UserSharedPrefrenceController>();
    if (userSharedPrefrenceController.isUser) {
      await HelperFunctions.errorRequestsHandler<CustomerSummaryModel>(
        loadingFunction: () async {
          change(null, status: RxStatus.loading());
          final customerSummary = await LinkTspApi.instance.account
              .customerSummary(
                  customerId: userSharedPrefrenceController.getUserId!);
          return customerSummary;
        },
        onSuccessFunction: (customerSummary) async {
          change(customerSummary, status: RxStatus.success());
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
  }

  void goToProfile() {
    if (userSharedPrefrenceController.isUser) {
      Get.toNamed(Routes.profile);
    } else {
      Get.toNamed(Routes.sign);
    }
  }

  void myOrdersAction() {
    if (userSharedPrefrenceController.isUser) {
      Get.toNamed(Routes.myorders);
    } else {
      Get.toNamed(Routes.sign);
    }
  }

  void goToAddressBook() {
    if (userSharedPrefrenceController.isUser) {
      Get.toNamed(Routes.addresses);
    } else {
      Get.toNamed(Routes.sign);
    }
  }

  void goToMyOrders() {
    if (userSharedPrefrenceController.isUser) {
      Get.toNamed(Routes.myorders);
    } else {
      Get.toNamed(Routes.sign);
    }
  }

  void changePasswordAction() {
    if (userSharedPrefrenceController.isUser) {
      Get.toNamed(Routes.changePasswordScreen);
    } else {
      Get.toNamed(Routes.sign);
    }
  }

  void goToSettings() {
    Get.toNamed(Routes.settings);
  }

  void goToLanguage() {
    showModalBottomSheet(
      context: Get.context!,
      backgroundColor: Colors.white,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return const LanguageWidget();
      },
    );
  }

  void goToBranches() {
    Get.toNamed(Routes.branchs);
  }

  void goToContactUs() {
    Get.toNamed(Routes.contactUsScreen);
  }

  Future<void> goToSign() async {
    Get.toNamed(Routes.sign);
  }

  Future<void> onTapSign(BuildContext context) async {
    if (userSharedPrefrenceController.isUser) {
      return await signOut(context);
    } else {
      return await goToSign();
    }
  }

  Future<void> signOut(BuildContext context) async {
    await HelperFunctions.errorRequestsSnakBarHandler(
      context,
      loadingFunction: () async {
        userSharedPrefrenceController.clearCacheUserData();
        await SocialAuth.instance.signoutFromAllSocialMedia();
        final wishList = Get.find<WishlistController>();
        await wishList.setWishList();
        final cartController = Get.find<CartController>();
        await cartController.clearGuestCart();
        final dashboardController = Get.find<DashboardController>();
        dashboardController.updateIndex(2);
      },
    );
  }

  Future<void> sendToRateApp(BuildContext context) async {
    OpenStore.instance.open(
      appStoreId: appIdIOs,
      androidAppBundleId: appIdAndroid,
    );
  }

  void shareAction(BuildContext context) {
    Share.share('Check out LaPoire Mobile App \n $appUrl');
  }
}
