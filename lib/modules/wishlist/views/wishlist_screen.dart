import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/components/custm_product_card.dart';
import '../../../core/components/custom_empty_widget.dart';
import '../../../core/components/custom_error_widget.dart';
import '../../../core/localization/translate.dart';
import '../../../core/shimmer_loader/horizontal_product_card_shimmer.dart';
import '../controllers/wishlist_controller.dart';

class WishlistScreen extends GetView<WishlistController> {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      ((data) {
        final wishList = data ?? [];
        return ListView.builder(
          key: UniqueKey(),
          padding: const EdgeInsets.all(10),
          shrinkWrap: true,
          itemCount: wishList.length,
          itemBuilder: (context, index) {
            final oneOfWishlist = wishList.elementAt(index);
            return ProductCardWidget(
              showDashedLine: index != wishList.length - 1,
              productId: oneOfWishlist.id!,
              isPreOrder: oneOfWishlist.preOrder ?? false,
              imageHeight: .32.sw,
              imageWidth: .22.sw,
              isHorizontal: true,
              promoText: oneOfWishlist.promoText ?? '',
              elevation: 2,
              hasOffer: (oneOfWishlist.productDiscountList ?? []).isNotEmpty,
              offerPercentage: (oneOfWishlist.productDiscountList ?? []).isEmpty
                  ? ""
                  : oneOfWishlist.productDiscountList?.first.value ?? "",
              productName: oneOfWishlist.title!,
              image: oneOfWishlist.imageUrl!,
              brandName: oneOfWishlist.brandName!,
              oldPrice: oneOfWishlist.price!,
              price: oneOfWishlist.finalPrice!,
              size: oneOfWishlist.size!,
              color: oneOfWishlist.color!,
              isAvailable: !oneOfWishlist.isOutOfStock!,
              isBogo: (oneOfWishlist.bogoPromoText != null &&
                  oneOfWishlist.bogoPromoText != ""),
              bogoText: oneOfWishlist.bogoPromoText ?? '',
              showFavorite: true,
              onAddToCart: () {
                int orderId = oneOfWishlist.id!;
                controller.moveToCart(orderId);
                wishList.removeAt(index);
              },
            );
          },
        );
      }),
      onLoading: const HorizontalCardShimmerLoader(),
      onEmpty: Obx(
        () => controller.isUser
            ? CustomEmptyWidget(
                emptyLabel: Translate.yourWishlistIsEmpty.tr,
                buttonLabel: Translate.continueShopping.tr,
                emptyBtnAction: controller.startShoppingAction,
              )
            : CustomEmptyWidget(
                emptyBtnAction: () => controller.loginAction(),
                emptyLabel: Translate.youAreNotLoggedInYet.tr,
                buttonLabel: Translate.login.tr,
              ),
      ),
      onError: (error) => CustomErrorWidget(
        errorText: error ?? "",
        onReload: controller.setWishList,
      ),
    );
  }
}
