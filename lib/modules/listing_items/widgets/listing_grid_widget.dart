import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/utils/theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/components/custm_product_card.dart';
import '../../../core/components/custom_empty_widget.dart';
import '../../../core/localization/translate.dart';
import '../controllers/listing_controller.dart';

class ListingGridWidget extends GetView<ListItemsController> {
  final int length;
  const ListingGridWidget({Key? key, required this.length}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshConfiguration(
        footerBuilder: () => const ClassicFooter(
          loadingIcon: SizedBox.shrink(),
          loadingText: '',
        ),
        child: SmartRefresher(
          header: WaterDropHeader(
            refresh: SizedBox(
                width: 25.0,
                height: 25.0,
                child: Platform.isAndroid
                    ? CircularProgressIndicator(
                        strokeWidth: 2.0,
                        color: CustomThemes.appTheme.primaryColor,
                      )
                    : const CupertinoActivityIndicator()),
            complete: const SizedBox.shrink(),
          ),
          controller: controller.refreshController,
          onRefresh: () => controller.onRefresh(),
          onLoading: () => controller.onLoadItems(),
          enablePullUp: controller.products.isEmpty ||
                  controller.products.length == length
              ? false
              : true,
          child: controller.products.isEmpty
              ? Center(
                  child: CustomEmptyWidget(
                    emptyLabel: Translate.noItems.tr,
                    emptyBtnAction: () => Get.back(),
                  ),
                )
              : GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  shrinkWrap: true,
                  itemCount: controller.products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1 / 1.5,
                    crossAxisSpacing: 15,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final product = controller.products[index];
                    return ProductCardWidget(
                      key: UniqueKey(),
                      productId: product.id!,
                      elevation: 2,
                      promoText: product.promoText ?? '',
                      isPreOrder: product.preOrder ?? false,
                      image: product.imageUrl ?? "",
                      productName: product.title ?? "",
                      imageHeight: .32.sw,
                      imageWidth: .22.sw,
                      hasOffer:
                          product.productDiscountList?.isNotEmpty ?? false,
                      offerPercentage: product.productDiscountList!.isEmpty
                          ? ""
                          : product.productDiscountList?[0].value ?? "",
                      showFavorite: true,
                      oldPrice: product.price ?? 0.0,
                      price: product.finalPrice!,
                      isAvailable: !(product.isOutOfStock ?? true),
                      isBogo: !(product.bogoPromoText == null ||
                          product.bogoPromoText == ""),
                      bogoText: product.bogoPromoText ?? "",
                      onAddToCart: () => controller.onAddTocard(
                          isPreOrder: product.preOrder ?? false,
                          context: context,
                          price: product.finalPrice ?? 0,
                          skuId: product.id!),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
