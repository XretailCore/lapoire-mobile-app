// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';
import 'package:uni_links/uni_links.dart';

import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/utils/routes.dart';
import '../../../core/utils/strings.dart';
import '../../inner/controllers/inner_product_controller.dart';
import '../../settings/controller/language_controller.dart';
import '../../settings/controller/settings_controller.dart';
import '../../wishlist/controllers/wishlist_controller.dart';

class SplashController extends GetxController with StateMixin {
  SplashController();
  final UserSharedPrefrenceController userSharedPrefrenceController =
      Get.find<UserSharedPrefrenceController>();
  int? skuId;
  StreamSubscription? sub;

  @override
  void onInit() {
    super.onInit();
    initUniLinks();
    getTokenApi();
    incomingUniLinks();
  }

  @override
  void onReady() {
    super.onReady();
    final languageController = Get.find<LanguageController>();
    languageController.setDefaultLanguage();
  }

  Future<void> sendDeviceToken() async {
    try {
      String? token = await HelperFunctions.getDeviceToken();
      if (token != null) {
        await LinkTspApi.instance.account.notificationsToken(
            deviceToken: token,
            customerID: userSharedPrefrenceController.getUserId);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getTokenApi({bool isRetry = false}) async {
    if (isRetry) change(null, status: RxStatus.loading());
    try {
      await const Duration(seconds: 3).delay();

      final _prefs = Get.find<UserSharedPrefrenceController>();

      var currentZone = _prefs.getCurrentZone;
      currentZone = const CityModel(
        id: 7,
      );
      _prefs.setCurrentZone = currentZone;
      final LanguageController languageController =
          Get.find<LanguageController>();

      await LinkTspApi.init(
        domain: domain,
        admin: admin,
        zoneid: currentZone.id,
        lang: languageController.getLanguageIdByName(),
      );
      if (userSharedPrefrenceController.getNotificationsSubscription ?? true) {
        await sendDeviceToken();
      }
      setNotificationsSubscribe();
      final wishList = Get.find<WishlistController>();
      await wishList.setWishList();

      // _startUpPage();
      change(null, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  void setNotificationsSubscribe() {
    final controller = Get.find<SettingsController>();
    controller.getNotificationSubscribeValue();
  }

  retryGetToken() {
    getTokenApi(isRetry: true);
  }

  void _startUpPage() {
    if (skuId != null) {
      Get.offAllNamed(Routes.innerScreen, arguments: {
        Arguments.skuId: skuId,
      });
      final controller = Get.find<InnerProductController>();
      controller.comeFromDeepLinking = true;
      controller.productsInQueue.add(skuId ?? 0);
    } else {
      Get.offAllNamed(Routes.dashboard);
    }
  }

  void getSkuidFromUri(Uri? uniUri) {
    if (uniUri != null) {
      var segments = uniUri.pathSegments;
      var productCode = segments.last;
      skuId = int.parse(productCode
          .split(
            '-',
          )
          .first);
    }
  }

  Future<void> initUniLinks() async {
    final uri = await getInitialUri();
    getSkuidFromUri(uri);
  }

  void incomingUniLinks() {
    try {
      sub = uriLinkStream.listen((Uri? uri) {
        getSkuidFromUri(uri);
        if (skuId != null) {
          Get.toNamed(
            Routes.innerScreen,
            arguments: {
              Arguments.skuId: skuId,
            },
          );
          final controller = Get.find<InnerProductController>();
          controller.comeFromDeepLinking = true;
          controller.onStartAction(
              isRelatedProduct: Platform.isAndroid ? false : true,
              skuId: skuId);
          controller.productsInQueue.add(skuId ?? 0);
        }
      }, onError: (err) {
        HelperFunctions.showSnackBar(message: "$err", context: Get.context!);
      });
    } catch (e) {
      return;
    }
  }
}
