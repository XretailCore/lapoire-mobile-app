import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/components/custom_back_button.dart';
import 'package:linktsp_api/data/list/models/list_model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../../core/components/custom_error_widget.dart';
import '../../../core/components/custom_slider.dart';
import '../../../core/components/imtnan_loading_widget.dart';
import '../../../core/components/offer_banner_widget.dart';
import '../../../core/utils/app_colors.dart';
import '../../wishlist/controllers/wishlist_controller.dart';
import '../controllers/inner_product_controller.dart';
import '../widgets/body_widget.dart';
import '../widgets/favoriate_button_widget.dart';
import '../widgets/panel_widget.dart';

class InnerProductScreen extends GetView<InnerProductController> {
  const InnerProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PanelController panelController = PanelController();
    return WillPopScope(
      onWillPop: () async {
        if (!controller.comeFromRelated) {
          return true;
        } else {
          var isNavigate = controller.navigateRelated(context);
          return isNavigate;
        }
      },
      child: Scaffold(
        body: controller.obx(
          (product) {
            return Scaffold(
              body: SlidingUpPanel(
                controller: panelController,
                footer: Container(
                  color: Colors.transparent,
                  height: 60.0,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    color: Colors.white,
                    child: PanelWidget(selectdProduct: product),
                  ),
                ),
                minHeight: MediaQuery.of(context).size.height * 0.4,
                maxHeight: MediaQuery.of(context).size.height * 0.8,
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.all(0),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  topRight: Radius.circular(18.0),
                ),
                body: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  color: AppColors.highlighter,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      const SizedBox(height: 32.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomBackButton(
                              onTap: () {
                                if (!controller.comeFromRelated) {
                                  Get.back();
                                } else {
                                  controller.navigateRelated(context);
                                }
                              },
                            ),
                            Column(
                              children: [
                                Obx(
                                  () => Container(
                                    decoration: const BoxDecoration(
                                      color: AppColors.redColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: FavoriateButtonWidget(
                                        isInner: true,
                                        key: UniqueKey(),
                                        iconSize: 20,
                                        defaultValue:
                                            Get.find<WishlistController>()
                                                .isFavorite(product!
                                                    .selectedProductSku.id!),
                                        onFavoraite: (v) {
                                          var listingItem = ListingItem(
                                            id: product.selectedProductSku.id,
                                            finalPrice: product
                                                .selectedProductSku.finalPrice,
                                          );
                                          final wishlistController =
                                              Get.find<WishlistController>();
                                          wishlistController.onChangeFavorite(
                                              context, v, listingItem);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Container(
                                  padding: const EdgeInsets.all(9),
                                  decoration: BoxDecoration(
                                      color: AppColors.redColor,
                                      border: Border.all(
                                        color: AppColors.redColor,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50))),
                                  child: InkWell(
                                    onTap: () => controller.onTapShareProduct(
                                        product?.selectedProductSku.id),
                                    child: const Icon(
                                      Icons.share,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          product!.selectedProductSku.images.isEmpty
                              ? Image.asset("assets/images/logo_white.png")
                              : Obx(
                                  () => CustomSlider(
                                    pageIndex: controller.pageIndex.value,
                                    onPageChanged: (index, reason) {
                                      controller.updateIndex(index);
                                    },
                                    isInner: true,
                                    showTitleAndButton: false,
                                    indicatorColor: AppColors.redColor,
                                    ratio: 1.15,
                                    showIndicator: true,
                                    sliderImages: [
                                      for (var image
                                          in product.selectedProductSku.images)
                                        Image.network(image?.url ?? ""),
                                    ],
                                  ),
                                ),
                          PositionedDirectional(
                            start: 30,
                            top: 30,
                            child: Offstage(
                              offstage: controller.isNotHaveDiscount(),
                              child: OfferBannerWidget(
                                size: 60,
                                textColor: Colors.white,
                                backgroundColor: AppColors.redColor,
                                offerText: controller.isHaveDiscount()
                                    ? ((product.selectedProductSku.discounts
                                            .first?.value) ??
                                        '')
                                    : '',
                              ),
                            ),
                          ),
                          PositionedDirectional(
                            end: 30,
                            top: 30,
                            child: Offstage(
                              offstage: (product.promoText ?? '').isEmpty,
                              child: OfferBannerWidget(
                                  size: 60,
                                  textColor: Colors.white,
                                  backgroundColor: AppColors.primaryColor,
                                  offerText: (product.promoText) ?? ''),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                panelBuilder: (scrollController) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Center(
                          child: Container(
                              color: Colors.grey[300], width: 70, height: 3),
                        ),
                      ),
                      Expanded(
                        child: BodyWidget(
                          scrollController: scrollController,
                          innerProductController: controller,
                          selectdProduct: product,
                          selectedSize: product.sizes.firstWhere((element) =>
                              element?.id == product.selectedProductSku.sizeId),
                          selectedColor: product.colors.firstWhere((element) =>
                              element?.id ==
                              product.selectedProductSku.colorId),
                          imagesUrl: product.selectedProductSku.images
                              .map((image) => image?.url)
                              .toList(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
          onLoading: const CustomLoadingWidget(),
          onError: (e) => CustomErrorWidget(
            errorText: e,
            onReload: controller.onStartAction,
          ),
        ),
      ),
    );
  }
}
