import 'package:carousel_slider/carousel_slider.dart';
import 'package:imtnan/core/components/custom_button.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import 'package:linktsp_api/data/page_block/models/new_page_block_model.dart';
import '../../../core/components/custm_product_card.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/lanaguages_enum.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
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
    final language = Get.find<UserSharedPrefrenceController>().getLanguage;

    return Offstage(
      offstage: items == null || items!.length<3,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        color: isYellow ? AppColors.highlighter : Colors.white,
        child: Column(
          children: [
            CustomText(
              title,
              maxLines: 1,
              softWrap: true,
              style: TextStyle(
                  color: CustomThemes.appTheme.primaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 32,
                  overflow: TextOverflow.ellipsis,
                  fontFamily:
                      language == Languages.ar.name ? 'Azad' : "Bayshore"),
            ),
            const SizedBox(height: 25),
            CarouselSlider.builder(
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                var item = items![itemIndex];
                return ProductCardWidget(
                  productId: item.id!,
                  elevation: 0,
                  promoText: item.product?.promoText ?? '',
                  isPreOrder: item.product?.preOrder ?? false,
                  imageHeight: .32.sw,
                  productName: item.name ?? "",
                  hideButtonsRow: false,
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
                onPageChanged: (index, reason) {
                  controller.productItem = items![index];
                },
                viewportFraction: 0.5,
                initialPage: 0,
                aspectRatio: 1 / .73,
                enableInfiniteScroll: items!.length <= 1 ? false : true,
                reverse: false,
                autoPlay: false,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.easeOutSine,
                // pauseAutoPlayOnTouch: Duration(seconds: 10),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 150,
              child: CustomBorderButton(
                title: Translate.allProducts.tr.toUpperCase(),
                color: isYellow?AppColors.highlighter:Colors.white,
                borderColor: AppColors.redColor,
                textColor: AppColors.redColor,
                onTap: onAllProductsPressed,
                radius: 30.0,
                fontSize: 14,
                padding: const EdgeInsets.symmetric(
                    horizontal: 15, vertical: 5),
              ),
            ),
            const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }
}
