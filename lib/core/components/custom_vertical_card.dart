import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';
import '../../modules/inner/widgets/favoriate_button_widget.dart';
import '../../modules/wishlist/controllers/wishlist_controller.dart';
import '../localization/translate.dart';
import '../utils/app_colors.dart';
import '../utils/theme.dart';
import 'custom_counter.dart';
import 'custom_text.dart';
import 'offer_banner_widget.dart';

class VerticalProductCard extends StatelessWidget {
  final int productId;
  final String? productImage;
  final bool isCart;
  final Function()? onAddToCart;
  final String? brandName;
  final String? productName;
  final double? price;
  final double? oldPrice;
  final bool? hasOffer;
  final bool? showFavorite;
  final bool isBogo;
  final String offerPercentage;

  final bool isAvailable;
  final String bogoText;
  final String promoText;
  final double? imageHeight;
  final Function()? onAddFeedBack;
  final Function()? onDelete;
  final int count;
  final Function()? onIncrement;
  final Function()? onDecrement;
  final String itemSize;
  final bool isPreOrder;

  const VerticalProductCard({
    Key? key,
    required this.productId,
    this.isCart = false,
    this.productImage,
    this.onAddToCart,
    this.brandName = "",
    this.productName = "",
    this.price,
    this.oldPrice,
    this.hasOffer = false,
    this.showFavorite = false,
    this.isBogo = false,
    this.offerPercentage = "",
    this.isAvailable = true,
    this.bogoText = '',
    this.promoText = '',
    this.imageHeight,
    this.onAddFeedBack,
    this.onDelete,
    this.count = 1,
    this.onIncrement,
    this.onDecrement,
    this.itemSize = '',
    this.isPreOrder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  productImage == null || productImage == ""
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: Image.asset(
                              'assets/images/main_logo.png',
                              width: 50,
                            ),
                          ),
                        )
                      : SizedBox(
                          width: double.infinity,
                          child: ExtendedImage.network(
                            productImage!,
                            cacheHeight: 800,
                            enableMemoryCache: false,
                            fit: BoxFit.fitHeight,
                            filterQuality: FilterQuality.high,
                            clearMemoryCacheWhenDispose: true,
                            enableLoadState: false,
                          ),
                        ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Offstage(
                      offstage: !(isBogo && bogoText.isNotEmpty),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(219, 183, 6, 1),
                        ),
                        child: CustomText(
                          bogoText,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 11,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          promoText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color.fromRGBO(237, 151, 32, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: promoText.isEmpty ? 0 : 5),
                        CustomText(
                          productName!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: CustomThemes.appTheme.primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        isBogo && isCart
                            ? CustomText(
                                Translate.freeGift.tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: CustomThemes.appTheme.primaryColor,
                                ),
                              )
                            : Row(
                                children: [
                                  CustomText(
                                    "$price ${Translate.egp.name.tr}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: AppColors.redColor,
                                    ),
                                  ),
                                  const Spacer(),
                                  Offstage(
                                    offstage: !(hasOffer ?? false),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          end: 10),
                                      child: CustomText(
                                        "$oldPrice ${Translate.egp.name.tr}",
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey,
                                          decorationColor: Colors.red,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        const SizedBox(height: 5),
                        if (itemSize.isNotEmpty && isCart)
                          CustomText(
                            itemSize,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: CustomThemes.appTheme.primaryColor,
                            ),
                          ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: (onAddFeedBack == null) ? 0 : 5),
            Offstage(
              offstage: (onAddFeedBack == null),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: onAddFeedBack,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 3),
                      margin: const EdgeInsetsDirectional.only(end: 10),
                      decoration: BoxDecoration(
                        color: CustomThemes.appTheme.primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                      ),
                      child: CustomText(
                        Translate.addFeedback.tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            isBogo && isCart
                ? Container()
                : isCart == true
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            CartCounterWidget(
                              count: count,
                              onIncrement: onIncrement,
                              onDecrement: onDecrement,
                            ),
                            const Spacer(),
                          ],
                        ),
                      )
                    : InkWell(
                        onTap: isAvailable ? onAddToCart : null,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: isPreOrder
                                ? const Color.fromRGBO(199, 209, 66, 1)
                                : isAvailable
                                    ? CustomThemes.appTheme.primaryColor
                                    : Colors.grey.withOpacity(.4),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                !isAvailable
                                    ? Translate.outOfNStock.tr
                                    : isPreOrder
                                        ? Translate.prebooking.tr
                                        : Translate.addToBasket.tr,
                                style: TextStyle(
                                  color:
                                      isAvailable ? Colors.white : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isBogo && isCart
                    ? Image.asset(
                        "assets/images/gift.png",
                        color: CustomThemes.appTheme.primaryColor,
                      )
                    : Offstage(
                        offstage: false,
                        // offstage: !(onDelete != null || hasBogo),
                        child: Visibility(
                          visible: onDelete != null,
                          child: InkWell(
                            onTap: onDelete,
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: CustomThemes.appTheme.primaryColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Icon(
                                Icons.clear,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          replacement: Offstage(
                            offstage: !showFavorite!,
                            child: Obx(
                              () => Container(
                                padding: const EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: CustomThemes.appTheme.primaryColor,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50))),
                                child: FavoriateButtonWidget(
                                  key: UniqueKey(),
                                  iconSize: 25,
                                  defaultValue: Get.find<WishlistController>()
                                      .isFavorite(productId),
                                  onFavoraite: (v) {
                                    var listingItem = ListingItem(
                                      id: productId,
                                      finalPrice: price,
                                    );
                                    final wishlistController =
                                        Get.find<WishlistController>();
                                    wishlistController.onChangeFavorite(
                                        context, v, listingItem);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: CustomThemes.appTheme.primaryColor,
                      ),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(Icons.remove_red_eye_outlined,
                        size: 22, color: CustomThemes.appTheme.primaryColor),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: CustomThemes.appTheme.primaryColor,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(Icons.shopping_cart,
                        size: 22, color: CustomThemes.appTheme.primaryColor),
                  ),
                ),
              ],
            )
          ],
        ),
        Positioned(
          child: Container(
            margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: Row(
              children: [
                Offstage(
                  offstage: !hasOffer!,
                  child: OfferBannerWidget(offerText: offerPercentage),
                ),
              ],
            ),
          ),
        ),
        PositionedDirectional(
          end: 0,
          bottom: 0,
          child: Offstage(
            offstage: !isCart,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: CustomThemes.appTheme.primaryColor,
              ),
              child: CustomText(
                "X $count",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CartCounterWidget extends StatelessWidget {
  final int count;
  final Function()? onIncrement;
  final Function()? onDecrement;

  const CartCounterWidget({
    Key? key,
    this.count = 1,
    this.onIncrement,
    this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 5),
      child: Row(
        children: [
          CounterWidget(
              count: count, increment: onIncrement, decrement: onDecrement),
        ],
      ),
    );
  }
}
