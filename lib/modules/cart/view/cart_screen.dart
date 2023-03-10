import 'package:imtnan/core/components/custom_text.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/routes.dart';
import '../../../core/components/custm_product_card.dart';
import '../../../core/components/custom_button.dart';
import '../../../core/components/custom_empty_widget.dart';
import '../../../core/components/custom_error_widget.dart';
import '../../../core/components/imtnan_loading_widget.dart';
import '../../../core/components/no_internet_widget.dart';
import '../../../core/localization/translate.dart';
import '../controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomConnectivityAlertWidget(
      onlineWidget: controller.obx(
        (data) => Column(
          children: [
            Expanded(
              flex: 7,
              child: ListView.builder(
                controller: controller.scrollController,
                padding: const EdgeInsets.all(10),
                shrinkWrap: true,
                itemCount: data!.items!.length,
                itemBuilder: (context, index) {
                  final item = data.items?[index];
                  return ProductCardWidget(
                    elevation: 0,
                    isCart: true,
                    imageHeight: .35.sw,
                    imageWidth: .35.sw,
                    showDashedLine: index != data.items!.length - 1,
                    productId: item!.id!,
                    promoText: item.promoText ?? '',
                    hasOffer: (item.productDiscountList ?? []).isNotEmpty,
                    offerPercentage: (item.productDiscountList ?? []).isEmpty
                        ? ""
                        : item.productDiscountList?.first.value ?? "",
                    productName: item.title!,
                    image: item.imageUrl!,
                    brandName: item.brandName,
                    oldPrice: item.price!,
                    price: item.finalPrice!,
                    count: item.qty!,
                    maxCount: item.maxQty ?? 1,
                    size: item.size!,
                    color: item.color!,
                    isHorizontal: true,
                    isAvailable: !(item.isOutOfStock ?? false),
                    isBogo: item.freeBogo ?? false,
                    bogoText: item.bogoPromoText ?? '',
                    onIncrement:
                        data.items![index].qty == data.items![index].maxQty
                            ? () {}
                            : () => controller.increase(data.items![index].id!,
                                data.items![index].qty!, context),
                    onDecrement: () => controller.decrease(
                        data.items![index].id!,
                        data.items![index].qty!,
                        context),
                    onDelete: data.items![index].freeBogo ?? false
                        ? null
                        : () =>
                            controller.deleteFromCart(data.items![index].id!),
                  );
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 48),
                child: Column(
                  children: [
                   const Divider(color: AppColors.primaryColor,thickness: 2.0),
                    Obx(
                      () => Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                    "${data.items!.length} ${Translate.items.tr}"),
                                const SizedBox(height: 4.0),
                                CustomText(
                                    "${Translate.total.tr} ${controller.total.value.toStringAsFixed(controller.total.value.truncateToDouble() == controller.total.value ? 0 : 1)} ${Translate.egp.tr}"),
                              ],
                            ),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: CustomBorderButton(
                                radius: 50,
                                color: AppColors.redColor,
                                title: Translate.buyNow.tr,
                                onTap: () async =>
                                    controller.onTapCheckOut(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        onLoading: const CustomLoadingWidget(),
        onEmpty: CustomEmptyWidget(
          emptyBtnAction: () => Get.offAllNamed(Routes.dashboard),
          emptyLabel: Translate.yourBasketIsEmpty.tr,
        ),
        onError: (e) => CustomErrorWidget(
          errorText: e,
          onReload: controller.getCart,
        ),
      ),
    );
  }
}
