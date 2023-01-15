import '../../../core/components/custm_product_card.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/utils/theme.dart';
import '../controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/data/page_block/models/new_page_block_model.dart';

class HomeListingWidget extends GetView<HomeController> {
  final List<ItemItem>? items;
  final String title;
  final Function()? onViewAll;
  const HomeListingWidget({
    Key? key,
    required this.items,
    this.title = "",
    this.onViewAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: items == null || items!.isEmpty,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              children: [
                CustomText(
                  title,
                  style: TextStyle(
                    color: CustomThemes.appTheme.primaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsetsDirectional.only(start: 15, bottom: 5),
            child: AspectRatio(
              aspectRatio: 1 / .68,
              child: ListView.separated(
                itemCount: items!.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsetsDirectional.only(end: 10),
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemBuilder: (contextt, index) {
                  final item = items![index];
                  return SizedBox(
                    width: .45.sw,
                    child: ProductCardWidget(
                      productId: item.id!,
                      elevation: 2,
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
                      offerPercentage: item.product?.productDiscountList ==
                                  null ||
                              item.product!.productDiscountList!.isEmpty
                          ? ""
                          : item.product!.productDiscountList?.first.value ??
                              "",
                      isAvailable: !(item.product?.isOutOfStock ?? false),
                      bogoText: item.product?.bogoPromoText ?? '',
                      showFavorite: true,
                      onAddToCart: () => controller.onTapAddToCard(
                        context: context,
                        skuId: item.id!,
                        price: item.product?.finalPrice ?? 0,
                        quantity: 1,
                        isHome: true,
                        isPreOrder: item.product?.preOrder ?? false,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
