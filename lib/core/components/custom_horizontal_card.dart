import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import 'package:linktsp_api/data/list/models/list_model.dart';
import '../../modules/wishlist/controllers/wishlist_controller.dart';
import '../localization/translate.dart';
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
  final bool? isReview;
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
    this.isReview = false,
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
                  : CrossAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      height: imageHeight,
                      width: imageWidth,
                      child: image == null || image == ""
                          ? Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Image.asset(
                                'assets/images/logo_white.png',
                                fit: BoxFit.fitHeight,
                              ),
                            )
                          : ExtendedImage.network(
                              image ?? "",
                              cacheHeight: 800,
                              enableMemoryCache: false,
                              fit: BoxFit.fitWidth,
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.red,
                              width: .5,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                            color: AppColors.highlighter,
                          ),
                          child: CustomText(
                            bogoText,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.redColor,
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      end: 10,
                      top: 10,
                      child: Offstage(
                        offstage: !promoText.isNotEmpty,
                        child: OfferBannerWidget(
                          offerText: promoText,
                          textColor: Colors.white,
                          backgroundColor: CustomThemes.appTheme.primaryColor,
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
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                const SizedBox(height: 5),
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
                                              "${price!.toStringAsFixed(price!.truncateToDouble() == price ? 0 : 1)} ${Translate.egp.name.tr}",
                                              style: TextStyle(
                                                fontSize: !isCart! ? 14 : 13,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.redColor,
                                              ),
                                            ),
                                          ),
                                          // const SizedBox(width: 20),
                                          Expanded(
                                            child: Offstage(
                                              offstage: !(hasOffer ?? false),
                                              child: CustomText(
                                                "${oldPrice!.toStringAsFixed(oldPrice!.truncateToDouble() == oldPrice ? 0 : 1)} ${Translate.egp.name.tr}",
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w600,
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
                                if (count != null && !isCart!)
                                  CustomText(
                                    "${Translate.qty.tr}: $count",
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                if ((count == null || isCart!) && !isReview!)
                                  isAvailable
                                      ? CustomText(
                                          Translate.inStock.tr,
                                          style: const TextStyle(
                                              color: AppColors.primaryColor),
                                        )
                                      : CustomText(
                                          Translate.outOfStock.tr,
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
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
                                    onTap:
                                        () async{
                                          Get.defaultDialog(
                                            barrierDismissible: false,
                                            contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                                            titlePadding: const EdgeInsets.only(top: 20),
                                            title: Translate.deleteItem.tr.capitalizeFirst ?? '',
                                            titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                            middleText: Translate.areYouWantToDeleteThisItem.tr,
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
                                                onPressed: onDelete ??(){
                                                  var listingItem = ListingItem(
                                                    id: productId,
                                                    finalPrice: price,
                                                  );
                                                  final wishlistController =
                                                  Get.find<WishlistController>();
                                                  wishlistController.onChangeFavorite(
                                                      context, false, listingItem);
                                                  Navigator.of(Get.context!, rootNavigator: true).pop();
                                                },
                                                child: Text(
                                                  Translate.yes.tr.toUpperCase(),
                                                  style: const TextStyle(
                                                      fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                    child: const Padding(
                                      padding: EdgeInsets.all(3.0),
                                      child: Icon(Icons.clear,
                                          size: 16, color: AppColors.redColor),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Offstage(
                                offstage: !showFavorite!,
                                child: InkWell(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  onTap: !isAvailable ? null : onAddToCart,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: !isAvailable
                                          ? Colors.grey
                                          : CustomThemes.appTheme.primaryColor,
                                      border: Border.all(
                                        color: !isAvailable
                                            ? Colors.grey
                                            : CustomThemes
                                                .appTheme.primaryColor,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Icon(
                                        Icons.shopping_cart,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (rate != null)
                        RatingBar(
                          allowHalfRating: true,
                          initialRating: rate ?? 0,
                          ignoreGestures: true,
                          itemSize: 18,
                          onRatingUpdate: (double value) {},
                          glowColor: primaryColor,
                          unratedColor: primaryColor,
                          ratingWidget: RatingWidget(
                            full: Icon(Icons.star, color: primaryColor),
                            half: Icon(Icons.star_half, color: primaryColor),
                            empty: Icon(Icons.star_border, color: primaryColor),
                          ),
                        ),
                      SizedBox(height: count == null ? 0 : 5),
                      SizedBox(height: (isCart == true) ? 10 : 0),
                      Offstage(
                        offstage: !isCart!,
                        child: onIncrement == null
                            ? Container()
                            : Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 0),
                                    child: CounterWidget(
                                      count: count ?? 1,
                                      increment: onIncrement!,
                                      decrement: count == null || count == 1
                                          ? () {}
                                          : ondecrement!,
                                      maxCount:
                                          price == 0 ? count ?? 1 : maxCount,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
            PositionedDirectional(
              end: 10,
              top: 15,
              child: Offstage(
                offstage: !(price == 0.0),
                child: FaIcon(
                  FontAwesomeIcons.gift,
                  size: 20,
                  color: CustomThemes.appTheme.primaryColor,
                ),
              ),
            ),
          ],
        ),
        if (showDashedLine)
          const DottedLine(
            dashColor: AppColors.redColor,
          )
      ],
    );
  }
}
