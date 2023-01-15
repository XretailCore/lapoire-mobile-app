import '../../../core/utils/routes.dart';
import '../../../core/components/custm_product_card.dart';
import '../../../core/components/custom_button.dart';
import '../../../core/components/custom_empty_widget.dart';
import '../../../core/components/custom_error_widget.dart';
import '../../../core/components/imtnan_loading_widget.dart';
import '../../../core/components/no_internet_widget.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/theme.dart';
import '../controllers/cart_controller.dart';
import '../widgets/cart_summary_widget.dart';
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
                child: Scrollbar(
                  controller: controller.scrollController,
                  thumbVisibility: true,
                  child: GridView.builder(
                    controller: controller.scrollController,
                    padding: const EdgeInsets.all(10),
                    shrinkWrap: true,
                    itemCount: data!.items!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.35,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final item = data.items?[index];
                      return ProductCardWidget(
                        isCart: true,
                        imageHeight: .22.sw,
                        imageWidth: .22.sw,
                        productId: item!.id!,
                        promoText: item.promoText ?? '',
                        hasOffer: (item.productDiscountList ?? []).isNotEmpty,
                        offerPercentage:
                            (item.productDiscountList ?? []).isEmpty
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
                        isAvailable: !(item.isOutOfStock ?? false),
                        isBogo: item.freeBogo ?? false,
                        bogoText: item.bogoPromoText ?? '',
                        onIncrement:
                            data.items![index].qty == data.items![index].maxQty
                                ? () {}
                                : () => controller.increase(
                                    data.items![index].id!,
                                    data.items![index].qty!,
                                    context),
                        onDecrement: () => controller.decrease(
                            data.items![index].id!,
                            data.items![index].qty!,
                            context),
                        onDelete: data.items![index].freeBogo ?? false
                            ? null
                            : () => controller
                                .deleteFromCart(data.items![index].id!),
                      );
                    },
                  ),
                ),
              ),
              Card(
                elevation: 5,
                margin: const EdgeInsets.all(0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15)),
                ),
                child: Column(
                  children: [
                    Offstage(
                        offstage: controller.userId == null,
                        child: const CartSummaryWidget()),
                    CustomButton(
                      mdh: 55,
                      title: Translate.checkout.tr,
                      radius: 0,
                      color: CustomThemes.appTheme.primaryColor,
                      onTap: () async => controller.onTapCheckOut(context),
                    ),
                  ],
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
