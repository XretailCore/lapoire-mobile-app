import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/data/exception_api.dart';
import 'package:linktsp_api/linktsp_api.dart' hide Size;
import '../../../core/components/custom_loaders.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/utils/routes.dart';
import '../../check_out/controllers/customer_summary_controller.dart';
import '../../check_out/controllers/locations.dart';
import '../../content/controllers/pre_booking_policy_controller.dart';

class CartController extends GetxController with StateMixin<CartSummaryModel?> {
  int? userId;
  RxInt cartCounter = 0.obs;
  final List<int> cartItemsIds = <int>[];
  final facebookAppEvents = FacebookAppEvents();
  Rx<num> total = 0.0.obs;

  final Rx<CartSummaryModel> cartSummaryResult = CartSummaryModel().obs;
  final UserSharedPrefrenceController _userSharedPrefrenceController =
      Get.find<UserSharedPrefrenceController>();
  final ScrollController scrollController = ScrollController();
  bool _isValidUser({required String? email, required String? mobile}) {
    if ((email ?? '').isEmpty || (mobile ?? '').isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> onTapCheckOut(BuildContext context) async {
    final isUser = _userSharedPrefrenceController.isUser;
    String alertMessage = '';

    if (isUser) {
      if (!_isValidUser(
          email: _userSharedPrefrenceController.getUserEmail,
          mobile: _userSharedPrefrenceController.getUserMobile)) {
        HelperFunctions.showSnackBar(
            message: Translate.pleaseCompleteYourAccountFirst.tr,
            context: context);
        return;
      }
      try {
        final cartValidate = await LinkTspApi.instance.multiStore.cartValidate(
            customerID: _userSharedPrefrenceController.getUserId!,
            addressId: Locations.locationId ?? 0);
        if (cartValidate.alertMessage != null) {
          for (var i = 0; i < cartValidate.storeCartItems!.length; i++) {
            if (cartValidate.storeCartItems?[i].status != 1) {
              alertMessage +=
                  "${cartValidate.storeCartItems?[i].title} : ${cartValidate.storeCartItems?[i].message} ";
            }
          }
          HelperFunctions.showSnackBar(
              message: alertMessage, context: Get.context!);
        }
       else {
          final CustomerSummaryController _customerSummaryController =
              Get.find<CustomerSummaryController>();
          _customerSummaryController.getSummaryData();
          Get.toNamed(Routes.checkOutOptionsScreen);
       }
      } on ExceptionApi catch (e) {
        HelperFunctions.showSnackBar(
            message: e.toString(), context: Get.context!);
      } catch (e) {
        change(null, status: RxStatus.error());
      }
    } else {
      Get.toNamed(Routes.sign);
    }
  }

  Future<void> getCart(
      {bool? isUpdate, bool showDiscountNotification = false}) async {
    userId = Get.find<UserSharedPrefrenceController>().getUserId;
    if (userId != null) {
      await getLoggedUserCart(isUpdate: isUpdate);
    } else {
      await getGuestUserCart(isUpdate: isUpdate);
    }
  }

  void setCartCount(List<CartItemModel> items) {
    cartCounter.value = items.isEmpty
        ? 0
        : items.fold<int>(
            0, (previousValue, element) => previousValue + (element.qty ?? 0));
  }

  Future<void> getLoggedUserCart({bool? isUpdate}) async {
    try {
      if (isUpdate != true) change(null, status: RxStatus.loading());
      cartSummaryResult.value = await LinkTspApi.instance.cart
          .getCartSummary(customerId: userId!, version: 3);
      if (cartSummaryResult.value.items == null ||
          cartSummaryResult.value.items!.isEmpty) {
        setCartCount(cartSummaryResult.value.items ?? []);
        change(cartSummaryResult.value, status: RxStatus.empty());
      } else {
        if (cartSummaryResult.value.summary!.last.value!.contains(".")) {
          total.value = double.parse(
              cartSummaryResult.value.summary?.last.value ?? "0.0");
        } else {
          total.value =
              int.parse(cartSummaryResult.value.summary?.last.value ?? "0")
                  .toDouble();
        }
        cartItemsIds.clear();
        for (var i = 0; i < cartSummaryResult.value.items!.length; i++) {
          cartItemsIds.add(cartSummaryResult.value.items![i].id ?? 0);
        }
        setCartCount(cartSummaryResult.value.items ?? []);
        change(cartSummaryResult.value, status: RxStatus.success());
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> getGuestUserCart({bool? isUpdate}) async {
    if (isUpdate != true) change(null, status: RxStatus.loading());
    var guestCart = Get.find<UserSharedPrefrenceController>().getAllCart;
    if (guestCart.isEmpty) {
      setCartCount(guestCart.cast<CartItemModel>());
      change(null, status: RxStatus.empty());
    } else {
      List<CartItemModel> guestCartItems = await LinkTspApi.instance.cart
          .guestCartUpdate(cartSkuModel: guestCart);
      if (guestCartItems.isNotEmpty) {
        for (var item in guestCartItems) {
          total.value += item.finalPrice! * item.qty!;
        }
        setCartCount(guestCartItems.cast<CartItemModel>());
        change(CartSummaryModel(items: guestCartItems.cast<CartItemModel>()),
            status: RxStatus.success());
      } else {
        Get.defaultDialog(
            title: Translate.failed.tr, middleText: Translate.error.tr);
        change(null, status: RxStatus.error());
      }
    }
  }

  Future<void> increase(int skuid, int qty, BuildContext context) async {
    if (userId != null) {
      qty++;
      updateCart(skuid, qty);
    } else {
      openLoadingDialog(context);
      qty++;
      final product = CartSkuModel(skuid: skuid, qty: qty);
      final controller = Get.find<UserSharedPrefrenceController>();
      controller.updateFromCart(product);
      await getGuestUserCart(isUpdate: true);
      //Get.back();
    }
  }

  Future<void> decrease(int skuid, int qty, BuildContext context) async {
    if (userId != null) {
      qty--;
      updateCart(skuid, qty);
    } else {
      openLoadingDialog(context);
      qty--;
      final product = CartSkuModel(skuid: skuid, qty: qty);
      final controller = Get.find<UserSharedPrefrenceController>();
      controller.updateFromCart(product);
      await getGuestUserCart(isUpdate: true);
      Get.back();
    }
  }

  Future<void> updateCart(int skuid, int qty) async {
    openLoadingDialog(Get.context!);
    try {
      final success = await LinkTspApi.instance.cart.updateItemInCart(
            cartSkuModel: [CartSkuModel(skuid: skuid, qty: qty)],
            customerId: userId!,
          ) ??
          false;
      if (success) {
        await getCart(isUpdate: true);
        Get.back();
      } else {
        Get.back();
        change(null, status: RxStatus.error());
      }
    } on ExceptionApi catch (e) {
      Get.back();
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        HelperFunctions.customSnackBar(
          message: e.message,
          backgroundColor: Colors.red,
          snackBarBehavior: SnackBarBehavior.fixed,
        ),
      );
    } catch (e) {
      Get.back();
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        HelperFunctions.customSnackBar(
          message: e.toString(),
          backgroundColor: Colors.red,
          snackBarBehavior: SnackBarBehavior.fixed,
        ),
      );
    }
  }

  Future<void> deleteFromCart(int skuid) async {
    Navigator.of(Get.context!, rootNavigator: true).pop();
    int? userId = Get.find<UserSharedPrefrenceController>().getUserId;
    openLoadingDialog(Get.context!);
    try {
      if (userId == null) {
        deleteFromGuestCart(skuid);
        await getCart(isUpdate: true);
        Get.back();
      } else {
        final success = await LinkTspApi.instance.cart
            .removeFromCart(customerId: userId, skuId: skuid);
        if (success) {
          Get.back();
          await getCart(isUpdate: true);
        } else {
          Get.back();
          change(null, status: RxStatus.error());
        }
      }
    } on ExceptionApi catch (e) {
      Get.back();
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        HelperFunctions.customSnackBar(
          message: e.message,
          backgroundColor: Colors.red,
          snackBarBehavior: SnackBarBehavior.fixed,
        ),
      );
    } catch (e) {
      Get.back();
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        HelperFunctions.customSnackBar(
          message: e.toString(),
          backgroundColor: Colors.red,
          snackBarBehavior: SnackBarBehavior.fixed,
        ),
      );
    }
  }

  void deleteFromGuestCart(int skuid) {
    final controller = Get.find<UserSharedPrefrenceController>();
    final products = controller.getAllCart;
    products.removeWhere((element) => element.skuid == skuid);
    cartCounter.value--;
    controller.updateCartList(products);
  }

  Future<void> clearGuestCart() async {
    final controller = Get.find<UserSharedPrefrenceController>();
    final products = controller.getAllCart;
    products.clear();
    await getCart();
    cartCounter.value = 0;
    controller.updateCartList(products);
  }

  Future<void> onTapAddToCard(
      {required BuildContext context,
      required int skuId,
      required int quantity,
      required double price,
      required bool isPreOrder,
      bool isHome = false}) async {
    if (isPreOrder) {
      final preBookingPolicyController = Get.find<PreBookingPolicyController>();
      bool isAgree =
          await preBookingPolicyController.showPreBookingPolicy(context);
      if (!isAgree) {
        return;
      }
    }
    final product = CartSkuModel(skuid: skuId, qty: quantity);
    final userSharedPrefrenceController = UserSharedPrefrenceController();
    final userId = userSharedPrefrenceController.getUserId;
    if (userId != null) {
      openLoadingDialog(context);
      try {
        await LinkTspApi.instance.cart
            .addToCart(cartSkuModel: [product], customerId: userId);
        await getCart();
        Get.back();
        addToCartFBEvent(skuId, price);
        ScaffoldMessenger.of(context).showSnackBar(
          HelperFunctions.customSnackBar(
            message: Translate.productHasBeenAddedSusccessfully.tr,
            snackBarBehavior: SnackBarBehavior.fixed,
          ),
        );
      } on ExceptionApi catch (e) {
        Get.back();
        ScaffoldMessenger.of(context).showSnackBar(
          HelperFunctions.customSnackBar(
            message: e.message,
            backgroundColor: Colors.red,
            snackBarBehavior: SnackBarBehavior.fixed,
          ),
        );
      } catch (e) {
        Get.back();
        ScaffoldMessenger.of(context).showSnackBar(
          HelperFunctions.customSnackBar(
            message: e.toString(),
            backgroundColor: Colors.red,
            snackBarBehavior: SnackBarBehavior.fixed,
          ),
        );
      }
    } else {
      openLoadingDialog(context);
      userSharedPrefrenceController.addToCart(product);
      getCart();
      Get.back();
      ScaffoldMessenger.of(context).showSnackBar(
        HelperFunctions.customSnackBar(
          message: Translate.productHasBeenAddedSusccessfully.tr,
          snackBarBehavior: SnackBarBehavior.fixed,
        ),
      );
    }
  }

  Future<void> addToCartFBEvent(int skuid, double price) async {
    facebookAppEvents.logAddToCart(
      id: skuid.toString(),
      type: 'product',
      price: price,
      currency: 'EGP',
    );
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
