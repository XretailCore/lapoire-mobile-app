import 'package:cowpay/core/helpers/screen_size.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';
import '../../modules/inner/widgets/favoriate_button_widget.dart';
import '../../modules/wishlist/controllers/wishlist_controller.dart';
import '../localization/translate.dart';
import '../utils/app_colors.dart';
import '../utils/routes.dart';
import '../utils/strings.dart';
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
  final bool hideButtonsRow;

  const VerticalProductCard({
    Key? key,
    required this.productId,
    this.isCart = false,
    this.productImage,
    this.onAddToCart,
    this.brandName = "",
    this.productName = "",
    this.price,
    this.hideButtonsRow = false,
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
                              'assets/images/no_image_logo.png',
                              width: 150,
                              fit: BoxFit.cover,
                              height: 100,
                            ),
                          ),
                        )
                      : SizedBox(
                          width: double.infinity,
                          height: 150,
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
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                          productName!,
                          maxLines: 2,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: CustomThemes.appTheme.primaryColor,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                    "$price ${Translate.egp.name.tr}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: AppColors.redColor,
                                    ),
                                  ),
                                  Offstage(
                                    offstage: !(hasOffer ?? false),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        CustomText(
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
                                      ],
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
            // isBogo && isCart
            //     ? Container()
            //     : isCart == true
            //         ? Padding(
            //             padding: const EdgeInsets.symmetric(vertical: 5),
            //             child: Row(
            //               children: [
            //                 CartCounterWidget(
            //                   count: count,
            //                   onIncrement: onIncrement,
            //                   onDecrement: onDecrement,
            //                 ),
            //                 const Spacer(),
            //               ],
            //             ),
            //           )
            //         : InkWell(
            //             onTap: isAvailable ? onAddToCart : null,
            //             child: Container(
            //               padding: const EdgeInsets.symmetric(vertical: 10),
            //               decoration: BoxDecoration(
            //                 color: isPreOrder
            //                     ? const Color.fromRGBO(199, 209, 66, 1)
            //                     : isAvailable
            //                         ? CustomThemes.appTheme.primaryColor
            //                         : Colors.grey.withOpacity(.4),
            //               ),
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   CustomText(
            //                     !isAvailable
            //                         ? Translate.outOfNStock.tr
            //                         : isPreOrder
            //                             ? Translate.prebooking.tr
            //                             : Translate.addToBasket.tr,
            //                     style: TextStyle(
            //                       color:
            //                           isAvailable ? Colors.white : Colors.red,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),

            Visibility(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      highlightColor: AppColors.highlighter,
                      customBorder: const CircleBorder(),
                      onTap: () {
                        Get.toNamed(
                          Routes.innerScreen,
                          arguments: {
                            Arguments.skuId: productId,
                          },
                        );
                      },
                      child: Container(
                        height: 35,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.5,
                              color: CustomThemes.appTheme.primaryColor),
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FaIcon(FontAwesomeIcons.eye,
                                size: 15,
                                color: CustomThemes.appTheme.primaryColor),
                          ),
                        ),
                      ),
                    ),
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
                                  padding: const EdgeInsets.all(7),
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
                                    height: 35,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.5,
                                          color: CustomThemes
                                              .appTheme.primaryColor),
                                      color: Colors.transparent,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: FavoriateButtonWidget(
                                        key: UniqueKey(),
                                        iconSize: 15,
                                        defaultValue:
                                            Get.find<WishlistController>()
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
                          ),
                    InkWell(
                      highlightColor: AppColors.highlighter,
                      customBorder: const CircleBorder(),
                      onTap: isAvailable ? onAddToCart : showOutOfStockMessage,
                      child: Container(
                        height: 35,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.5,
                              color: isAvailable
                                  ? CustomThemes.appTheme.primaryColor
                                  : Colors.grey),
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FaIcon(FontAwesomeIcons.cartShopping,
                                size: 15,
                                color: isAvailable
                                    ? CustomThemes.appTheme.primaryColor
                                    : Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              visible: !hideButtonsRow,
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
                  child: OfferBannerWidget(
                    offerText: offerPercentage,
                    textColor: Colors.white,
                    backgroundColor: AppColors.redColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: promoText.isNotEmpty,
          child: Positioned(
            right: 5,
            child: Container(
              margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Row(
                children: [
                  Offstage(
                    offstage: !promoText.isNotEmpty,
                    child: OfferBannerWidget(
                      offerText: promoText,
                      textColor: Colors.white,
                      backgroundColor: CustomThemes.appTheme.primaryColor,
                    ),
                  ),
                ],
              ),
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

void showOutOfStockMessage() {
  Fluttertoast.showToast(
      msg: Translate.outOfStock.tr,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.redColor,
      textColor: Colors.white,
      fontSize: 16.0);
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
