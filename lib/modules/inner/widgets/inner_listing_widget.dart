import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/data/sku/models/inner_product/inner_product_model.dart';
import '../../../core/components/custm_product_card.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/lanaguages_enum.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/theme.dart';
import '../controllers/inner_product_controller.dart';

class InnerListingWidget extends GetView<InnerProductController> {
  final List<ProductModel>? items;
  final String title;
  final Function()? onViewAll;

  const InnerListingWidget({
    Key? key,
    required this.items,
    this.title = "",
    this.onViewAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final language=  Get.find<UserSharedPrefrenceController>().getLanguage;
    return Visibility(
        visible: items != null && items!.length>=3,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  title,
                  style: TextStyle(
                      color: CustomThemes.appTheme.primaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 28,
                      fontFamily: language == Languages.ar.name ?'Azad':"Bayshore"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          CarouselSlider(
            items: [
              for (var item in items!)
                ProductCardWidget(
                  productId: item.id!,
                  isPreOrder: item.preOrder,
                  elevation: 0,
                  promoText: item.promoText,
                  imageHeight: .3.sw,
                  productName: item.name,
                  image: item.imageUrl,
                  oldPrice: item.price,
                  price: item.finalPrice,
                  isBogo: (item.bogoPromoText.isNotEmpty),
                  hasOffer: (item.productDiscountList.isNotEmpty),
                  offerPercentage: item.productDiscountList.isEmpty
                      ? ""
                      : item.productDiscountList.first.value,
                  isAvailable: !(item.isOutOfStock),
                  bogoText: item.bogoPromoText,
                  showFavorite: true,
                  onAddToCart: () => controller.onTapAddToCard(
                    context: context,
                    price: item.price,
                    skuId: item.id!,
                    quantity: 1,
                  ),
                )
            ],
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
            ),
          ),
        ],
      ),
    );
  }
}
