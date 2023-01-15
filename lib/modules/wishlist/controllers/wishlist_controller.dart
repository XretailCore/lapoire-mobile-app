import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/localization/translate.dart';
import 'package:linktsp_api/linktsp_api.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/utils/routes.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../dashboard/controller/dashboard_controller.dart';

class WishlistController extends GetxController
    with StateMixin<List<WishlistProductsModel>> {
  final refreshController = RefreshController(initialRefresh: false);
  final facebookAppEvents = FacebookAppEvents();

  bool get isUser => Get.find<UserSharedPrefrenceController>().isUser;

  final _favoriteList = <int>{}.obs;

  bool isFavorite(int productId) {
    return _favoriteList.contains(productId);
  }

  void startShoppingAction() {
    final dashboardController = Get.find<DashboardController>();
    dashboardController.updateIndex(0);
  }

  Future<void> setWishList() async {
    await HelperFunctions.errorRequestsHandler<void>(
      loadingFunction: () async {
        change(null, status: RxStatus.loading());
        final _userSharedPrefrenceController =
            Get.find<UserSharedPrefrenceController>();
        if (_userSharedPrefrenceController.isUser) {
          final customerId = _userSharedPrefrenceController.getUserId;

          final wishlistProducts = await LinkTspApi.instance.wishlist
              .getWishlist(customerId: customerId!, version: 3);
          final productsId = wishlistProducts
              .where((element) => element.id != null)
              .map((e) => e.id!);
          _favoriteList
            ..clear()
            ..addAll(productsId);
          if (wishlistProducts.isEmpty) {
            change(wishlistProducts, status: RxStatus.empty());
          } else {
            change(wishlistProducts, status: RxStatus.success());
          }
        } else {
          _favoriteList.clear();
          change([], status: RxStatus.empty());
        }
      },
      onSuccessFunction: (result) async {},
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

  Future<void> onChangeFavorite(
    BuildContext context,
    bool isFavorite,
    ListingItem product,
  ) async {
    final _userSharedPrefrenceController =
        Get.find<UserSharedPrefrenceController>();
    if (_userSharedPrefrenceController.getUserId != null) {
      await _addOrRemoveFromWishlist(context, isFavorite, product);
      await setWishList();
    } else {
      Get.toNamed(Routes.sign);
    }
  }

  Future<void> addToWishlistFBEvent(ListingItem product) async {
    facebookAppEvents.logAddToWishlist(
      id: product.id.toString(),
      type: 'product',
      price: product.finalPrice!,
      currency: 'EGP',
    );
  }

  Future<void> addToCartFBEvent(WishlistProductsModel product) async {
    facebookAppEvents.logAddToCart(
      id: product.id.toString(),
      type: 'product',
      price: product.finalPrice!,
      currency: 'EGP',
    );
  }

  Future<bool?> _addOrRemoveFromWishlist(
      BuildContext context, bool isFavorite, ListingItem product) async {
    final primaryColor = Theme.of(context).primaryColor;
    return await HelperFunctions.errorRequestsSnakBarHandler<bool?>(
      context,
      loadingFunction: () async {
        final _userSharedPrefrenceController =
            Get.find<UserSharedPrefrenceController>();
        if (isFavorite) {
          final isFav = await LinkTspApi.instance.wishlist.addToWishlist(
            customerId: _userSharedPrefrenceController.getUserId!,
            skuid: product.id ?? 0,
          );

          await addToWishlistFBEvent(product);

          HelperFunctions.showSnackBar(
            context: context,
            message: Translate.itemAddedToWishlist.tr,
            color: primaryColor,
          );
          return isFav;
        } else {
          final isFav = await LinkTspApi.instance.wishlist.removeFromWishlist(
              customerId: _userSharedPrefrenceController.getUserId!,
              skuid: product.id ?? 0);
          HelperFunctions.showSnackBar(
            context: context,
            message: Translate.itemRemovedFromWishlist.tr,
            color: primaryColor,
          );
          return !isFav!;
        }
      },
      onSuccessFunction: (result) async {},
    );
  }

  Future<void> moveToCart(int skuId) async {
    await HelperFunctions.errorRequestsSnakBarHandler<void>(
      Get.context!,
      loadingFunction: () async {
        final _userSharedPrefrenceController =
            Get.find<UserSharedPrefrenceController>();
        final customerId = _userSharedPrefrenceController.getUserId;

        bool? isSuccess = await LinkTspApi.instance.wishlist
            .moveToCart(customerId: customerId!, skuid: skuId);
        if (isSuccess == true) {
          final cartController = Get.find<CartController>();
          cartController.getCart();
          await setWishList();
        }
      },
      onSuccessFunction: (result) async {
        HelperFunctions.showSnackBar(
            message: Translate.itemAddedSuccessfullyToBag.tr,
            context: Get.context!,
            color: Theme.of(Get.context!).primaryColor);
      },
    );
  }

  Future<void> deleteItemFromWishList(
      BuildContext context, int productId) async {
    await HelperFunctions.errorRequestsSnakBarHandler<void>(
      context,
      loadingFunction: () async {
        final _userSharedPrefrenceController =
            Get.find<UserSharedPrefrenceController>();
        final customerId = _userSharedPrefrenceController.getUserId;
        if (customerId == null) {
          change(null, status: RxStatus.error());
          return;
        }
        await LinkTspApi.instance.wishlist
            .removeFromWishlist(customerId: customerId, skuid: productId);
        _favoriteList.remove(productId);
        await setWishList();
      },
    );
  }

  void loginAction() {
    Get.toNamed(Routes.sign);
  }

  @override
  void onClose() {
    _favoriteList.close();
    super.onClose();
  }
}
