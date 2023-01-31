import 'package:carousel_slider/carousel_slider.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import 'package:linktsp_api/data/page_block/models/new_page_block_model.dart';

import '../../../core/components/custm_product_card.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/theme.dart';
import '../controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeListingWidget extends GetView<HomeController> {
  final List<ItemItem>? items;
  final String title;
  final Function()? onViewAll;
  final void Function() onAllProductsPressed;
  final bool isYellow;

  const HomeListingWidget({
    Key? key,
    required this.onAllProductsPressed,
    required this.items,
    this.title = "",
    this.isYellow = false,
    this.onViewAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      color: isYellow ? AppColors.highlighter : Colors.white,
      child: Offstage(
        offstage: items == null || items!.isEmpty,
        child: Column(
          children: [
            CustomText(
              title,
              style: TextStyle(
                  color: CustomThemes.appTheme.primaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 32,
                  fontFamily: "Bayshore"),
            ),
            const SizedBox(height: 10),
            CarouselSlider.builder(
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                final item = items![itemIndex];

                return ProductCardWidget(
                  productId: item.id!,
                  elevation: 0,
                  promoText: item.product?.promoText ?? '',
                  isPreOrder: item.product?.preOrder ?? false,
                  imageHeight: .32.sw,
                  productName: item.name ?? "",
                  hideButtonsRow: true,
                  image: item.imageUrl ?? "",
                  oldPrice: item.product?.price ?? 0.0,
                  price: item.product?.finalPrice ?? 0,
                  isBogo: !(item.product?.bogoPromoText == null),
                  hasOffer: !(item.product?.productDiscountList == null ||
                      item.product!.productDiscountList!.isEmpty),
                  offerPercentage: item.product?.productDiscountList == null ||
                          item.product!.productDiscountList!.isEmpty
                      ? ""
                      : item.product!.productDiscountList?.first.value ?? "",
                  isAvailable: !(item.product?.isOutOfStock ?? false),
                  bogoText: item.product?.bogoPromoText ?? '',
                  showFavorite: true,
                  onAddToCart: () => controller.onTapAddToCard(
                    context: context,
                    skuId: item.id!,
                    price: item.product?.finalPrice ?? 0,
                    quantity: 1,
                    isPreOrder: item.product?.preOrder ?? false,
                  ),
                );
              },
              itemCount: items?.length,
              options: CarouselOptions(
                enlargeCenterPage: true,
                //onPageChanged: onPageChanged,
                viewportFraction: 0.5,
                initialPage: 0,
                aspectRatio: 1 / .68,
                enableInfiniteScroll: items!.length <= 1 ? false : true,
                reverse: false,
                autoPlay: false,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.easeOutSine,
                // pauseAutoPlayOnTouch: Duration(seconds: 10),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                backgroundColor:
                    isYellow ? AppColors.highlighter : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: const BorderSide(
                    width: 2.0,
                    color: Colors.red,
                  ),
                ),
              ),
              onPressed: onAllProductsPressed,
              child: Text(
                Translate.allProducts.tr.toUpperCase(),
                style: TextStyle(
                  fontSize: 16.sm,
                  color: AppColors.redColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getItems(List<ItemItem>? items, BuildContext context) {
    List<Widget> itemsAsWidgets = [];
    for (var item in items!) {
      itemsAsWidgets.add(
        ProductCardWidget(
          productId: item.id!,
          elevation: 0,
          promoText: item.product?.promoText ?? '',
          isPreOrder: item.product?.preOrder ?? false,
          imageHeight: .32.sw,
          productName: item.name ?? "",
          image: item.imageUrl ?? "",
          oldPrice: item.product?.price ?? 0.0,
          price: item.product?.finalPrice ?? 0,
          isBogo: !(item.product?.bogoPromoText == null),
          hasOffer: !(item.product?.productDiscountList == null ||
              item.product!.productDiscountList!.isEmpty),
          offerPercentage: item.product?.productDiscountList == null ||
                  item.product!.productDiscountList!.isEmpty
              ? ""
              : item.product!.productDiscountList?.first.value ?? "",
          isAvailable: !(item.product?.isOutOfStock ?? false),
          bogoText: item.product?.bogoPromoText ?? '',
          showFavorite: true,
          onAddToCart: () => controller.onTapAddToCard(
            context: context,
            skuId: item.id!,
            price: item.product?.finalPrice ?? 0,
            quantity: 1,
            isPreOrder: item.product?.preOrder ?? false,
          ),
        ),
      );
    }
    return itemsAsWidgets;
  }
}
