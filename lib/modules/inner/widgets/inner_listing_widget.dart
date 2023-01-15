import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/data/sku/models/inner_product/inner_product_model.dart';

import '../../../core/components/custm_product_card.dart';
import '../../../core/components/custom_text.dart';
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
    return Offstage(
      offstage: items == null || items!.isEmpty,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
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
          const SizedBox(height: 5),
          Container(
            margin: const EdgeInsetsDirectional.only(start: 15),
            child: AspectRatio(
              aspectRatio: 1 / .68,
              child: ListView.separated(
                itemCount: items!.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemBuilder: (contextt, index) {
                  final item = items![index];
                  return Container(
                    width: .43.sw,
                    margin: const EdgeInsets.only(bottom: 5),
                    child: ProductCardWidget(
                      onCardTap: () {
                        controller.onStartAction(
                            isRelatedProduct: true, skuId: item.id);
                        controller.productsInQueue.add(item.id!);
                      },
                      productId: item.id!,
                      isPreOrder: item.preOrder,
                      elevation: 2,
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
