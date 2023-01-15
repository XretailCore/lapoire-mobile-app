import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/components/custom_empty_widget.dart';
import '../../../core/components/custom_error_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../core/components/custm_product_card.dart';
import '../../../core/components/custom_appbar.dart';
import '../../../core/localization/translate.dart';
import '../../../core/shimmer_loader/listing_shimmer.dart';
import '../../../core/utils/theme.dart';
import '../controller/search_controller.dart';

class SearchScreen extends GetView<SearchController> {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SearchAppBar(),
      body: controller.obx(
        (data) => RefreshConfiguration(
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
            enablePullDown: false,
            enablePullUp:
                data != null && controller.searchList.length == data.length
                    ? false
                    : true,
            child: ListView.separated(
              itemCount: controller.searchList.length,
              shrinkWrap: true,
              padding: const EdgeInsets.all(15),
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final product = controller.searchList[index];
                return ProductCardWidget(
                  isHorizontal: true,
                  key: UniqueKey(),
                  productId: product.id!,
                  image: product.imageUrl ?? "",
                  promoText: product.promoText ?? "",
                  brandName: product.brandName ?? "",
                  productName: product.title ?? "",
                  imageHeight: .35.sw,
                  imageWidth: .35.sw,
                  isAvailable: !(product.isOutOfStock ?? false),
                  hasOffer: product.productDiscountList?.isNotEmpty ?? false,
                  offerPercentage: product.productDiscountList!.isEmpty
                      ? ""
                      : product.productDiscountList?.first.value ?? "",
                  showFavorite: true,
                  oldPrice: product.price ?? 0,
                  price: product.finalPrice ?? 0,
                  colorsCount: product.colorCount ?? 1,
                  isBogo: !(product.bogoPromoText == null),
                  bogoText: product.bogoPromoText ?? "",
                );
              },
            ),
          ),
        ),
        onError: (error) => CustomErrorWidget(
          errorText: error,
          onReload: () => controller.onRefresh(showLoader: true),
        ),
        onLoading: const ListingShimmerLoader(),
        onEmpty: CustomEmptyWidget(
          emptyLabel: Translate.noItems.tr,
          buttonLabel: Translate.continueShopping.tr,
          emptyBtnAction: () => controller.continueShoppingAction(),
        ),
      ),
    );
  }
}
