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
import '../../../core/components/custom_text_field.dart';
import '../../../core/localization/translate.dart';
import '../../../core/shimmer_loader/listing_shimmer.dart';
import '../../../core/utils/theme.dart';
import '../controller/search_controller.dart';

class SearchScreen extends GetView<SearchController> {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: Translate.search.tr, showAction: false, showBackButton: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 5.0, end: 15),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              height: 40.0,
              child: CustomSearchTextField(
                controller: controller.searchController,
                labelText: Translate.search.tr,
                validator: (val) {
                  return null;
                },
                onTap: () => controller.onRefresh(showLoader: true),
                onSave: (searchText) => controller.onRefresh(showLoader: true),
              ),
            ),
          ),
          Expanded(
            child: controller.obx(
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
                  enablePullUp: data != null &&
                          controller.searchList.length == data.length
                      ? false
                      : true,
                  child: GridView.builder(
                    physics: const ScrollPhysics(),
                    itemCount: controller.searchList.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(15),
                    itemBuilder: (context, index) {
                      final product = controller.searchList[index];
                      return ProductCardWidget(
                        isHorizontal: false,
                        key: UniqueKey(),
                        productId: product.id!,
                        imageHeight: .22.sw,
                        imageWidth: .22.sw,
                        image: product.imageUrl ?? "",
                        promoText: product.promoText ?? "",
                        brandName: product.brandName ?? "",
                        productName: product.title ?? "",
                        isAvailable: !(product.isOutOfStock ?? false),
                        onAddToCart: () => controller.onTapAddToCard(
                          context: context,
                          skuId: product.id!,
                          price: product.finalPrice ?? 0,
                          quantity: 1,
                          isPreOrder: product.preOrder ?? false,
                        ),
                        hasOffer:
                            product.productDiscountList?.isNotEmpty ?? false,
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1 / 1.5,
                          crossAxisSpacing: 15,
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                    ),
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
          ),
        ],
      ),
    );
  }
}
