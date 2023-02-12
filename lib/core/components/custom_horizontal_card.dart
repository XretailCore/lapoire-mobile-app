import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import 'package:linktsp_api/data/list/models/list_model.dart';
import '../../modules/wishlist/controllers/wishlist_controller.dart';
import '../localization/translate.dart';
import '../shimmer_loader/images_shimmer.dart';
import '../utils/theme.dart';
import 'custom_counter.dart';
import 'custom_text.dart';
import 'offer_banner_widget.dart';

class HorizontalProductCard extends StatelessWidget {
  final int productId;
  final String? image;
  final double imageHeight;
  final double? imageWidth;
  final String? brandName;
  final String? productName;
  final double? price;
  final double? oldPrice;
  final bool? hasOffer;
  final bool? showFavorite;
  final bool? isCart;
  final String size;
  final String color;
  final int? count;
  final Function()? onIncrement;
  final Function()? ondecrement;
  final int? colorsCount;
  final Function()? onDelete;
  final Function()? onAddToCart;
  final bool isBogo;
  final double? rate;
  final String offerPercentage;
  final bool isAvailable;
  final int? maxCount;
  final String bogoText;
  final String promoText;
  final bool showDashedLine;

  const HorizontalProductCard({
    Key? key,
    required this.productId,
    this.image,
    required this.imageHeight,
    required this.imageWidth,
    this.brandName = "",
    this.productName = "",
    this.price,
    this.oldPrice,
    this.hasOffer = false,
    this.showFavorite = false,
    this.isCart = false,
    this.color = "",
    this.count,
    this.size = "",
    this.onIncrement,
    this.ondecrement,
    this.colorsCount,
    this.onDelete,
    this.onAddToCart,
    this.isBogo = false,
    this.rate,
    this.offerPercentage = "",
    this.isAvailable = true,
    this.maxCount,
    this.bogoText = '',
    this.promoText = '',
    this.showDashedLine = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Column(
      children: [
        Stack(
          children: [
            Row(
              crossAxisAlignment: !isCart!
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      height: imageHeight,
                      width: imageWidth,
                      child: image == null || image == ""
                          ? Image.asset(
                              'assets/images/no_image_logo.png',
                              width: 150,
                              fit: BoxFit.cover,
                              height: 70,
                            )
                          : CachedNetworkImage(
                              imageUrl: image!,
                              height: 20,
                              imageBuilder: (_, imagwe) => Container(
                                height: imageHeight,
                                width: imageWidth,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    // fit: BoxFit.fitHeight,
                                    image: NetworkImage(image as String),
                                  ),
                                ),
                              ),
                              errorWidget: (_, __, ___) => const Center(
                                child: Icon(Icons.error_outline),
                              ),
                              placeholder: (context, String image) =>
                                  ImagesShimmerLoader(
                                      height: imageHeight, width: imageWidth),
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
                              vertical: 5, horizontal: 0),
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(219, 183, 6, 1),
                          ),
                          child: CustomText(
                            bogoText,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      start: 10,
                      top: 10,
                      child: Offstage(
                        offstage: !hasOffer!,
                        child: OfferBannerWidget(
                          offerText: offerPercentage,
                          textColor: Colors.white,
                          backgroundColor: AppColors.redColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 0),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  productName!,
                                  maxLines: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (size.isNotEmpty)
                                  CustomText(
                                    size,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: AppColors.redColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                SizedBox(height: size.isEmpty ? 0 : 5),
                                price == 0
                                    ? CustomText(
                                        Translate.freeGift.tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: CustomThemes
                                              .appTheme.primaryColor,
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: CustomText(
                                              "$price ${Translate.egp.name.tr}",
                                              style: TextStyle(
                                                fontSize: !isCart! ? 14 : 13,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.redColor,
                                              ),
                                            ),
                                          ),
                                          // const SizedBox(width: 20),
                                          Expanded(
                                            child: Offstage(
                                              offstage: !(hasOffer ?? false),
                                              child: CustomText(
                                                "$oldPrice ${Translate.egp.name.tr}",
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: !isCart! ? 14 : 13,
                                                  color: Colors.grey,
                                                  decorationColor: Colors.red,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                const SizedBox(height: 8),
                                isAvailable
                                    ? CustomText(Translate.inStock.tr)
                                    : CustomText(Translate.outOfStock.tr),
                                SizedBox(height: (rate != null) ? 10 : 0),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Offstage(
                                offstage: !(onDelete != null ||
                                    isBogo ||
                                    showFavorite!),
                                child: DottedBorder(
                                  borderType: BorderType.Circle,
                                  color: AppColors.redColor,
                                  child: InkWell(
                                    onTap:onDelete?? () {
                                        var listingItem = ListingItem(
                                          id: productId,
                                          finalPrice: price,
                                        );
                                        final wishlistController =
                                            Get.find<WishlistController>();
                                        wishlistController.onChangeFavorite(
                                            context, false, listingItem);
                                    },
                                    child: const Icon(Icons.clear,
                                        color: AppColors.redColor),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Offstage(
                                offstage: !showFavorite!,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: CustomThemes.appTheme.primaryColor,
                                    border: Border.all(
                                      color: CustomThemes.appTheme.primaryColor,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.shopping_cart,
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (rate != null)
                        RatingBar.builder(
                          allowHalfRating: true,
                          initialRating: rate ?? 0,
                          ignoreGestures: true,
                          itemSize: 18,
                          onRatingUpdate: (double value) {},
                          glowColor: primaryColor,
                          unratedColor: primaryColor,
                          itemBuilder: (BuildContext context, int index) {
                            return (rate ?? 0) > index
                                ? Icon(
                                    Icons.star,
                                    color: primaryColor,
                                  )
                                : Icon(
                                    Icons.star_border_outlined,
                                    color: primaryColor,
                                  );
                          },
                        ),
                      SizedBox(height: count == null ? 0 : 5),
                      SizedBox(height: (isCart == true) ? 10 : 0),
                      Offstage(
                        offstage: !isCart!,
                        child: onIncrement == null
                            ? Container()
                            : Row(
                                children: [
                                  CounterWidget(
                                    count: count ?? 1,
                                    increment: onIncrement!,
                                    decrement: count == null || count == 1
                                        ? () {}
                                        : ondecrement!,
                                    maxCount:
                                        price == 0 ? count ?? 1 : maxCount,
                                  ),
                                ],
                              ),
                      ),
                      isCart! ? const SizedBox(height: 8.0) : const SizedBox(),
                    ],
                  ),
                )),
              ],
            ),
            PositionedDirectional(
              end: 10,
              top: 10,
              child: Offstage(
                offstage: !(price == 0.0),
                child: Image.asset(
                  "assets/images/gift.png",
                  color: CustomThemes.appTheme.primaryColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        if (showDashedLine)
          const DottedLine(
            dashColor: AppColors.redColor,
          )
      ],
    );
  }
}
