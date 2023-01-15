import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/utils/theme.dart';
import 'package:linktsp_api/linktsp_api.dart' hide Size;
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/components/expansion_tile_widget.dart';
import '../../../core/components/offer_banner_widget.dart';
import '../../../core/components/quantity_widget.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/app_colors.dart';
import '../../wishlist/controllers/wishlist_controller.dart';
import '../controllers/inner_product_controller.dart';
import '../entities/product_entity.dart';
import 'favoriate_button_widget.dart';
import 'inner_listing_widget.dart';
import 'list_of_reviews_widget.dart';
import 'select_size_widget.dart';

class BodyWidget extends StatefulWidget {
  const BodyWidget({
    Key? key,
    required this.selectdProduct,
    this.selectedSize,
    this.selectedColor,
    required this.innerProductController,
    required this.imagesUrl,
  }) : super(key: key);

  final ProductEntity? selectdProduct;
  final SizeModel? selectedSize;
  final ColorModel? selectedColor;
  final InnerProductController innerProductController;
  final List<String?> imagesUrl;
  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  int indexImage = 0;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return ListView(
      children: [
        Stack(
          children: [
            SizedBox(
              height: .3.sh,
              child: widget.imagesUrl.isEmpty
                  ? Align(
                      child: SvgPicture.asset(
                        'assets/images/etoile_with_name.svg',
                        fit: BoxFit.scaleDown,
                        height: 120,
                        width: 120,
                      ),
                    )
                  : PhotoViewGallery.builder(
                      enableRotation: false,
                      allowImplicitScrolling: true,
                      scrollPhysics: const BouncingScrollPhysics(),
                      onPageChanged: (index) {
                        setState(() {
                          indexImage = index;
                        });
                      },
                      builder: (BuildContext context, int index) {
                        final imageUrl = widget.imagesUrl.elementAt(index);
                        return PhotoViewGalleryPageOptions(
                          basePosition: Alignment.center,
                          imageProvider: NetworkImage(imageUrl ?? ''),
                          maxScale: PhotoViewComputedScale.contained * 1.2,
                          minScale: PhotoViewComputedScale.contained,
                          heroAttributes:
                              PhotoViewHeroAttributes(tag: imageUrl ?? ''),
                        );
                      },
                      itemCount: widget.imagesUrl.length,
                      loadingBuilder: (context, event) => Center(
                        child: SizedBox(
                          width: 20.0,
                          height: 20.0,
                          child: CircularProgressIndicator(
                            color: CustomThemes.appTheme.primaryColor,
                          ),
                        ),
                      ),
                      backgroundDecoration:
                          const BoxDecoration(color: Colors.white),
                    ),
            ),
            PositionedDirectional(
              start: 20,
              top: 0,
              child: Offstage(
                offstage: widget.innerProductController.isNotHaveDiscount(),
                child: OfferBannerWidget(
                  offerText: widget.innerProductController.isHaveDiscount()
                      ? ((widget.selectdProduct?.selectedProductSku.discounts
                              .first?.value) ??
                          '')
                      : '',
                ),
              ),
            ),
            Positioned.directional(
              textDirection: Directionality.of(context),
              top: 0,
              end: 20,
              child: Offstage(
                offstage: widget.innerProductController.isNotHaveBogo(),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(219, 183, 6, 1),
                  ),
                  child: CustomText(
                    widget.selectdProduct?.bogoPromoText ?? '',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Positioned.directional(
              textDirection: Directionality.of(context),
              start: 0,
              end: 0,
              bottom: 5,
              child: Offstage(
                offstage: widget.imagesUrl.length < 2,
                child: Container(
                  color: Colors.transparent,
                  child: DotsIndicator(
                    dotsCount: widget.imagesUrl.length < 2
                        ? 1
                        : widget.imagesUrl.length,
                    position: indexImage.toDouble(),
                    decorator: DotsDecorator(
                        activeColor: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[100],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  if ((widget.selectdProduct?.isEnableAddReview ?? false))
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RatingBar.builder(
                          allowHalfRating: true,
                          initialRating:
                              widget.selectdProduct?.averageRating ?? 0,
                          ignoreGestures: true,
                          itemSize: 18,
                          onRatingUpdate: (double value) {
                            // this widget used for Show only (no update)
                          },
                          glowColor: primaryColor,
                          unratedColor: primaryColor,
                          itemBuilder: (BuildContext context, int index) {
                            return (widget.selectdProduct?.averageRating ?? 0) >
                                    index
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
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => widget.innerProductController
                              .onTapAddReview(
                                  widget.selectdProduct?.selectedProductSku
                                      .skuCode,
                                  context),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(width: 1, color: primaryColor),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 11,
                                  color: primaryColor,
                                ),
                                const SizedBox(width: 4),
                                CustomText(
                                  Translate.addReview.tr,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 11, color: primaryColor),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.redColor,
                        border: Border.all(
                          color: AppColors.redColor,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(50))
                    ),
                    child: IconButton(
                      onPressed: () => widget.innerProductController
                          .onTapShareProduct(
                              widget.selectdProduct?.selectedProductSku.id),
                      icon:  const Icon(Icons.share,color: Colors.white),
                    ),
                  ),
                  Obx(
                    () => FavoriateButtonWidget(
                      key: UniqueKey(),
                      iconSize: 25,
                      defaultValue: Get.find<WishlistController>().isFavorite(
                          widget.selectdProduct!.selectedProductSku.id!),
                      onFavoraite: (v) {
                        var listingItem = ListingItem(
                          id: widget.selectdProduct!.selectedProductSku.id,
                          finalPrice: widget
                              .selectdProduct!.selectedProductSku.finalPrice,
                        );
                        final wishlistController =
                            Get.find<WishlistController>();
                        wishlistController.onChangeFavorite(
                            context, v, listingItem);
                      },
                    ),
                  )
                ],
              ),
              Offstage(
                offstage: (widget.selectdProduct?.promoText ?? '').isEmpty,
                child: CustomText(
                  widget.selectdProduct?.promoText,
                  style: const TextStyle(
                      color: Color.fromRGBO(237, 151, 32, 1), fontSize: 14),
                ),
              ),
              const SizedBox(height: 8),
              CustomText(
                widget.selectdProduct?.title ?? '',
                style: const TextStyle(
                  color: Color.fromRGBO(81, 97, 97, 1),
                  fontSize: 20,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  CustomText(
                    '${Translate.skuCode.tr.toUpperCase()} : ',
                    style: const TextStyle(fontSize: 10),
                  ),
                  CustomText(
                    '${widget.selectdProduct?.selectedProductSku.skuCode}',
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  CustomText(
                    '${Translate.productCode.tr.toUpperCase()} : ',
                    style: const TextStyle(fontSize: 10),
                  ),
                  CustomText(
                    '${widget.selectdProduct?.code}',
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  CustomText(
                    '${widget.selectdProduct?.selectedProductSku.finalPrice} ${Translate.egp.tr}',
                    style: TextStyle(fontSize: 20, color: primaryColor),
                  ),
                  const SizedBox(width: 15),
                  Offstage(
                    offstage: widget.innerProductController.isNotHaveDiscount(),
                    child: CustomText(
                      '${widget.selectdProduct?.selectedProductSku.defaultPrice} ${Translate.egp.tr}',
                      style: const TextStyle(
                          fontSize: 17,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.red,
                          color: Colors.grey),
                    ),
                  ),
                ],
              ),
              CustomText(
                Translate.allPricesIncudeVatDetails.tr,
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
              Offstage(
                offstage: widget.innerProductController.selectedProduct
                        .selectedProductSku.quantityInStock ==
                    0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    CustomText(
                      Translate.availabilityInStock.trParams(
                        params: {
                          'quantity':
                              '${widget.innerProductController.selectedProduct.selectedProductSku.quantityInStock}',
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              CustomText(
                '${Translate.size.tr} :',
                style: const TextStyle(
                    fontSize: 12, color: Color.fromRGBO(65, 65, 65, 1)),
              ),
              const SizedBox(height: 4),
              SelectSizeWidget(
                selectedSize:
                    widget.innerProductController.isCustomerChangedSize
                        ? widget.selectedSize
                        : null,
                selectdProduct: widget.selectdProduct,
                innerProductController: widget.innerProductController,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: primaryColor, width: 1),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      Translate.quantity.tr.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 12, color: Color.fromRGBO(96, 96, 96, 1)),
                    ),
                    QuantityButton(
                      key: UniqueKey(),
                      initialQuantity: widget.innerProductController.quantity,
                      maxQuantity: widget
                              .selectdProduct?.selectedProductSku.maxQuantity ??
                          0,
                      height: 40,
                      onQuantityChange: (v) {
                        widget.innerProductController.quantity = v;
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              CustomText(
                Translate.deliveredWithinMinMaxBusinessDays.trParams(
                  params: {
                    'Min':
                        (widget.selectdProduct?.minDeliveryPeriod).toString(),
                    'Max':
                        (widget.selectdProduct?.maxDeliveryPeriod).toString(),
                    'PeriodName': (widget.selectdProduct?.periodName).toString()
                  },
                ),
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ExpansionTileWidget(
                key: Key(ExpansionTileStatus.featuresAndBenefits.name),
                initiallyExpanded:
                    widget.innerProductController.expansionTileStatus ==
                        ExpansionTileStatus.featuresAndBenefits,
                onExpansionChanged: (isExpanded) {
                  if (!isExpanded) {
                    widget.innerProductController.expansionTileStatus = null;
                    return;
                  }
                  widget.innerProductController.expansionTileStatus =
                      ExpansionTileStatus.featuresAndBenefits;
                },
                title: Translate.featuresAndBenefits.tr,
                children: [
                  CustomText(
                    widget.selectdProduct?.description ?? '',
                    style: const TextStyle(fontSize: 12),
                    softWrap: true,
                  ),
                ],
              ),
              ExpansionTileWidget(
                key: Key(ExpansionTileStatus.ingredientsAndHowToUse.name),
                initiallyExpanded:
                    widget.innerProductController.expansionTileStatus ==
                        ExpansionTileStatus.ingredientsAndHowToUse,
                onExpansionChanged: (isExpanded) {
                  if (!isExpanded) {
                    widget.innerProductController.expansionTileStatus = null;
                    return;
                  }
                  widget.innerProductController.expansionTileStatus =
                      ExpansionTileStatus.ingredientsAndHowToUse;
                },
                title: Translate.ingredientsAndHowToUse.tr,
                children: widget.selectdProduct?.features
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: CustomText('${e?.name ?? ''}: ',
                                          softWrap: true,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                    ),
                                    Expanded(
                                        flex: 5,
                                        child: CustomText(
                                          e?.value ?? '',
                                          softWrap: true,
                                          style: const TextStyle(fontSize: 12),
                                        )),
                                  ],
                                ),
                                const Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList() ??
                    [],
              ),
              Offstage(
                offstage: !(widget.selectdProduct?.isEnableAddReview ?? false),
                child: ExpansionTileWidget(
                  key: Key(ExpansionTileStatus.reviews.name),
                  initiallyExpanded:
                      widget.innerProductController.expansionTileStatus ==
                          ExpansionTileStatus.reviews,
                  onExpansionChanged: (isExpanded) {
                    if (!isExpanded) {
                      widget.innerProductController.expansionTileStatus = null;
                      return;
                    }
                    widget.innerProductController.expansionTileStatus =
                        ExpansionTileStatus.reviews;
                  },
                  title: Translate.reviews.tr,
                  children: [
                    ListOfReviewsWidget(
                      reviews: widget.selectdProduct?.reviews ?? [],
                    ),
                    InkWell(
                      onTap: () => widget.innerProductController
                          .onTapAllReviews(widget.selectdProduct),
                      child: CustomText(
                        Translate.allReviews.tr,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              InnerListingWidget(
                items:
                    widget.innerProductController.product?.relatedItems ?? [],
                title: Translate.relatedItems.tr,
              ),
              const SizedBox(height: 8),
              InnerListingWidget(
                items: widget.innerProductController.product?.recentItems ?? [],
                title: Translate.recentItems.tr,
              ),
              const SizedBox(height: 8),
              InnerListingWidget(
                items: widget.innerProductController.product
                        ?.whoViewedThisViewedThat ??
                    [],
                title: Translate.whoViewedProduct.tr,
              ),
              const SizedBox(height: 8),
              InnerListingWidget(
                items: widget.innerProductController.product
                        ?.whoBoughtThisBoughtThat ??
                    [],
                title: Translate.whoBoughtProducts.tr,
              ),
            ],
          ),
        ),
        SizedBox(height: Platform.isAndroid ? 130 : 160),
      ],
    );
  }
}
