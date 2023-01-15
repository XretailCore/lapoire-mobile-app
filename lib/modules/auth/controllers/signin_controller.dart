import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/data/exception_api.dart';
import 'package:linktsp_api/linktsp_api.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../core/components/custom_loaders.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/firebase_auth.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/utils/routes.dart';
import '../../../core/utils/strings.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../../wishlist/controllers/wishlist_controller.dart';
import 'verify_otp_controller.dart';

class SigninController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailTEC = TextEditingController(text: ''),
      passwordTEC = TextEditingController(text: '');

  final userSharedPrefrenceController =
      Get.find<UserSharedPrefrenceController>();
  Future<void> onTapSignIn(BuildContext context) async {
    final isInputsInValid = !((formKey.currentState?.validate()) ?? false);
    if (isInputsInValid) {
      return;
    }
    openLoadingDialog(context);
    final email = emailTEC.text.trim();
    final password = passwordTEC.text.trim();
    try {
      final userData = await _signin(email: email, password: password);
      await afterSignin(userData);
      Get.back();
      Get.back();
    } on ExceptionApi catch (e) {
      Get.back();
      if (e.code == 403) {
        final userSharedPrefrenceController =
            Get.find<UserSharedPrefrenceController>();
        userSharedPrefrenceController.setUserEmail = email;
        final VerifyOtpController verifyOtpController =
            Get.find<VerifyOtpController>();
        await verifyOtpController.sendOtpToMobile(context);
        Get.toNamed(Routes.verifyOtpScreen);
      } else {
        HelperFunctions.showSnackBar(
            hasCloseBtn: true, message: e.message.toString(), context: context);
      }
    } catch (e) {
      Get.back();
      HelperFunctions.showSnackBar(
          message: e.toString(), context: context, hasCloseBtn: true);
    }
  }

  Future<void> afterSignin(UserModel userData) async {
    userSharedPrefrenceController.cacheUserData(
      emailAddress: userData.email,
      firstName: userData.firstName,
      idUser: userData.id,
      isActive: userData.isActive,
      lastName: userData.lastName,
      mobile: userData.mobile,
    );
    await sendDeviceToken();
    await sendGuestUserCart(userSharedPrefrenceController.getUserId!);
    userSharedPrefrenceController.removeCart();
    final wishlistController = Get.find<WishlistController>();
    await wishlistController.setWishList();
    final cartController = Get.find<CartController>();
    await cartController.getCart();
    final dashboardController = Get.find<DashboardController>();
    dashboardController.updateIndex(0);
    Get.back();
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
      return;
    }
  }

  Future<UserModel> _signin(
      {required String email, required String password}) async {
    final userData = await LinkTspApi.instance.account
        .login(password: password, email: email);
    return userData;
  }

  Future<void> onForgetPassword() async {
    Get.toNamed(Routes.forgetPasswordScreen);
  }

  Future<void> sendGuestUserCart(int userId) async {
    await HelperFunctions.errorRequestsSnakBarHandler<bool?>(Get.context!,
        loadingFunction: () async {
      final guestCart = Get.find<UserSharedPrefrenceController>().getAllCart;
      return await LinkTspApi.instance.cart
          .addToCart(cartSkuModel: guestCart, customerId: userId);
    });
  }

  Future<void> onTapSignInWithFacebook(BuildContext context) async {
    await HelperFunctions.errorRequestsSnakBarHandler(context,
        loadingFunction: () async {
      String? deviceId = await HelperFunctions.getDeviceToken();
      final userSocialData = await SocialAuth.instance.signInWithFacebook();
      await _socialLogin(userSocialData: userSocialData, deviceId: deviceId);
      await completedRegistrationFBEvent('Facebook');
    });
  }

  final facebookAppEvents = FacebookAppEvents();

  Future<void> completedRegistrationFBEvent(String registrationMethod) async {
    facebookAppEvents.logCompletedRegistration(
        registrationMethod: registrationMethod);
  }

  Future<void> onTapSignInWithGoogle(BuildContext context) async {
    await HelperFunctions.errorRequestsSnakBarHandler(context,
        loadingFunction: () async {
      String? deviceId = await HelperFunctions.getDeviceToken();
      final userSocialData = await SocialAuth.instance.signInWithGoogle();
      if (userSocialData != null) {
        await _socialLogin(userSocialData: userSocialData, deviceId: deviceId);
        await completedRegistrationFBEvent('Google');
      }
    });
  }

  Future<void> _socialLogin(
      {UserSocialData? userSocialData, String? deviceId}) async {
    if (userSocialData == null) {
      return;
    }
    final socialLoginUserModel =
        await LinkTspApi.instance.socialLogin.socialLogin(
      socialLoginUserModel: SocialLoginUserModel(
        firstName: userSocialData.firstName,
        lastName: userSocialData.lastName,
        deviceId: deviceId,
        email: userSocialData.email,
        socialCode: userSocialData.socialCode,
        socialType: userSocialData.socialType,
      ),
    );
    final userData = UserModel(
      email: socialLoginUserModel.email,
      firstName: socialLoginUserModel.firstName,
      id: socialLoginUserModel.id!,
      lastName: socialLoginUserModel.lastName,
      mobile: socialLoginUserModel.mobile,
    );
    await afterSignin(userData);
    Get.back();
  }

  Future<void> loginWithAppleID(BuildContext context) async {
    openLoadingDialog(context);
    AuthorizationCredentialAppleID? credential;
    try {
      try {
        credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );
      } catch (e) {
        Get.back();

        return;
      }

      String? deviceId = await HelperFunctions.getDeviceToken();
      final socialLoginUserModel =
          await LinkTspApi.instance.socialLogin.socialLogin(
        socialLoginUserModel: SocialLoginUserModel(
          firstName: credential.givenName,
          deviceId: deviceId,
          email: credential.email,
          appleId: credential.userIdentifier,
          socialType: appleIdSocial,
        ),
      );
      final userData = UserModel(
        email: socialLoginUserModel.email,
        firstName: socialLoginUserModel.firstName,
        id: socialLoginUserModel.id!,
        lastName: socialLoginUserModel.lastName,
        mobile: socialLoginUserModel.mobile,
      );
      await afterSignin(userData);
      await completedRegistrationFBEvent('AppleID');

      Get.back();
    } on ExceptionApi catch (e) {
      Get.back();
      HelperFunctions.showSnackBar(
          message: e.message.toString(), context: context, hasCloseBtn: true);
    } catch (e) {
      Get.back();
      HelperFunctions.showSnackBar(
          message: e.toString(), context: context, hasCloseBtn: true);
    }
  }

  @override
  void onClose() {
    emailTEC.dispose();
    passwordTEC.dispose();
    ScaffoldMessenger.of(Get.context!).clearSnackBars();
    super.onClose();
  }
}
