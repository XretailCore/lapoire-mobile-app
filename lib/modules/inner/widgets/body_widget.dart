import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/utils/theme.dart';
import 'package:linktsp_api/linktsp_api.dart' hide Size;
import 'package:readmore/readmore.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/components/expansion_tile_widget.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/app_colors.dart';
import '../controllers/inner_product_controller.dart';
import '../entities/product_entity.dart';
import 'inner_listing_widget.dart';
import 'list_of_reviews_widget.dart';
import 'select_size_widget.dart';

class BodyWidget extends StatefulWidget {
  const BodyWidget({
    Key? key,
    required this.selectdProduct,
    required this.scrollController,
    this.selectedSize,
    this.selectedColor,
    required this.innerProductController,
    required this.imagesUrl,
  }) : super(key: key);

  final ProductEntity? selectdProduct;
  final SizeModel? selectedSize;
  final ColorModel? selectedColor;
  final InnerProductController innerProductController;
  final ScrollController scrollController;
  final List<String?> imagesUrl;

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  int indexImage = 0;
  int quantity = 1;
  int initialQuantity = 1;
  bool isSaving = false;

  void changeQuantity(int newQuantity) async {
    setState(() {
      isSaving = true;
    });
    setState(() {
      quantity = newQuantity;
      isSaving = false;
      widget.innerProductController.quantity = quantity;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialQuantity = widget.innerProductController.quantity;
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = CustomThemes.appTheme.primaryColor;
    return ListView(
      controller: widget.scrollController,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                widget.selectdProduct?.title ?? '',
                style: TextStyle(
                  color: CustomThemes.appTheme.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  if ((widget.selectdProduct?.isEnableAddReview ?? false))
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RatingBar(
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
                          ratingWidget: RatingWidget(
                            full: Icon(Icons.star, color: primaryColor),
                            half: Icon(Icons.star_half, color: primaryColor),
                            empty: Icon(Icons.star_border, color: primaryColor),
                          ),
                        ),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () => widget.innerProductController
                              .onTapAddReview(
                                  widget.selectdProduct?.selectedProductSku
                                      .skuCode,
                                  context),
                          child: CustomText(
                            Translate.addReview.tr,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.redColor,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  CustomText(
                    '${Translate.skuCode.tr.toUpperCase()} : ',
                    style: const TextStyle(fontSize: 14),
                  ),
                  CustomText(
                    '${widget.selectdProduct?.selectedProductSku.skuCode}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  DottedBorder(
                    dashPattern: const [4, 4],
                    color: AppColors.redColor,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    radius: const Radius.circular(8.0),
                    borderType: BorderType.RRect,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 40,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: IconButton(
                                  padding: const EdgeInsets.all(0),
                                  color: primaryColor,
                                  onPressed:
                                      (isSaving || quantity <= initialQuantity)
                                          ? null
                                          : () => changeQuantity(quantity - 1),
                                  icon: const Icon(
                                    Icons.remove,
                                    color: AppColors.redColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 20,
                                child: CustomText(
                                  quantity == 0 ? "1" : quantity.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: AppColors.redColor),
                                ),
                              ),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: IconButton(
                                  padding: const EdgeInsets.all(0),
                                  color: primaryColor,
                                  onPressed: (isSaving ||
                                          quantity >=
                                              widget
                                                  .selectdProduct!
                                                  .selectedProductSku
                                                  .maxQuantity)
                                      ? null
                                      : () => changeQuantity(quantity + 1),
                                  icon: const Icon(
                                    Icons.add,
                                    color: AppColors.redColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      CustomText(
                        '${widget.selectdProduct?.selectedProductSku.finalPrice.toStringAsFixed(widget.selectdProduct?.selectedProductSku.finalPrice.truncateToDouble() == widget.selectdProduct?.selectedProductSku.finalPrice ? 0 : 1)} ${Translate.egp.tr}',
                        style: const TextStyle(
                            fontSize: 20, color: AppColors.redColor),
                      ),
                      const SizedBox(height: 10),
                      Offstage(
                        offstage:
                            widget.innerProductController.isNotHaveDiscount(),
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
                ],
              ),
              const SizedBox(height: 10),
              CustomText(
                Translate.allPricesIncudeVatDetails.tr,
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
              Column(
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
              const SizedBox(height: 10),
              CustomText(
                '${Translate.size.tr} :',
                style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(65, 65, 65, 1),
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              SelectSizeWidget(
                selectedSize:
                    widget.innerProductController.isCustomerChangedSize
                        ? widget.selectedSize
                        : null,
                selectdProduct: widget.selectdProduct,
                innerProductController: widget.innerProductController,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              widget.selectdProduct!.description!.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: CustomText(
                        Translate.ingredients.tr.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.redColor,
                          fontWeight: FontWeight.w500,
                        ),
                        softWrap: true,
                      ),
                    )
                  : const SizedBox.shrink(),
              SizedBox(
                  height: widget.selectdProduct!.description!.isNotEmpty
                      ? 8.0
                      : 0.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ReadMoreText(
                  widget.selectdProduct?.description ?? '',
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: ' ${Translate.showMore.tr}',
                  trimExpandedText: ' ${Translate.showLess.tr}',
                  moreStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.redColor,
                  ),
                  lessStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.redColor,
                  ),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(
                  height: widget.selectdProduct!.description!.isNotEmpty
                      ? 16.0
                      : 0.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: CustomText(
                  Translate.deliveredWithinMinMaxBusinessDays.trParams(
                    params: {
                      'Min':
                          (widget.selectdProduct?.minDeliveryPeriod).toString(),
                      'Max':
                          (widget.selectdProduct?.maxDeliveryPeriod).toString(),
                      'PeriodName':
                          (widget.selectdProduct?.periodName).toString()
                    },
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.redColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Offstage(
                offstage: (widget.selectdProduct?.details != null),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: ExpansionTileWidget(
                    key: Key(ExpansionTileStatus.ingredientsAndHowToUse.name),
                    initiallyExpanded:
                        widget.innerProductController.expansionTileStatus ==
                            ExpansionTileStatus.ingredientsAndHowToUse,
                    onExpansionChanged: (isExpanded) {
                      if (!isExpanded) {
                        widget.innerProductController.expansionTileStatus =
                            null;
                        return;
                      }
                      widget.innerProductController.expansionTileStatus =
                          ExpansionTileStatus.ingredientsAndHowToUse;
                    },
                    title: Translate.featuresAndBenefits.tr,
                    children: [
                      ReadMoreText(
                        widget.selectdProduct?.details ?? '',
                        trimLines: 4,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: ' ${Translate.showMore.tr}',
                        trimExpandedText: ' ${Translate.showLess.tr}',
                        moreStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.redColor,
                        ),
                        lessStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.redColor,
                        ),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              widget.selectdProduct?.reviews != null &&
                      widget.selectdProduct!.reviews.length >= 2
                  ? Offstage(
                      offstage:
                          !(widget.selectdProduct?.isEnableAddReview ?? false),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ExpansionTileWidget(
                          key: Key(ExpansionTileStatus.reviews.name),
                          initiallyExpanded: widget
                                  .innerProductController.expansionTileStatus ==
                              ExpansionTileStatus.reviews,
                          onExpansionChanged: (isExpanded) {
                            if (!isExpanded) {
                              widget.innerProductController
                                  .expansionTileStatus = null;
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
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () => widget.innerProductController
                                  .onTapAllReviews(widget.selectdProduct),
                              child: CustomText(
                                Translate.allReviews.tr,
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),
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
        SizedBox(height: Platform.isAndroid ? 50 : 80),
      ],
    );
  }
}
