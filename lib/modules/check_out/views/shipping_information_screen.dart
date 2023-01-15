import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/components/appbar_widget.dart';
import '../../../core/components/custm_product_card.dart';
import '../../../core/components/custom_error_widget.dart';
import '../../../core/localization/translate.dart';
import '../controllers/shipping_information_controller.dart';
import '../widgets/custom_stepper_widget.dart';
import '../widgets/final_summary_widget.dart';
import '../widgets/shipping_information_widgets.dart';

class ShoppingInformationScreen extends GetView<ShippingInformationController> {
  const ShoppingInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBarWidget(title: Translate.checkout.tr),
      body: controller.obx(
        (shippingInfo) {
          final products = shippingInfo?.items ?? [];
          return Column(
            children: [
              const SizedBox(height: 10),
              const CustomStepperWidget(currentIndex: 2),
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.separated(
                        itemCount: shippingInfo?.items?.length ?? 0,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final product = products.elementAt(index);
                          return ProductCardWidget(
                            isHorizontal: true,
                            imageHeight: .3.sw,
                            promoText: product.promoText ?? '',
                            productId: product.id!,
                            imageWidth: .3.sw,
                            hasOffer: product.productDiscountList?.isNotEmpty ??
                                false,
                            offerPercentage: product
                                    .productDiscountList!.isEmpty
                                ? ""
                                : product.productDiscountList?[0].value ?? "",
                            productName: product.title ?? '',
                            brandName: product.brandName ?? '',
                            image: product.imageUrl ?? '',
                            count: product.qty,
                            oldPrice: product.price,
                            price: product.finalPrice ?? 0,
                            isBogo: product.freeBogo ?? false,
                            size: product.size,
                            color: product.color,
                            isAvailable: !product.isOutOfStock!,
                            bogoText: product.bogoPromoText ?? '',
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    ShippingInformationWidget(
                      address: shippingInfo?.address,
                      deliveryNote:
                          shippingInfo?.configDeliveryPeriod?.deliveryNote,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              FinalCheckoutSummaryWidget(
                summary: shippingInfo?.summary ?? [],
                buttonName: Translate.confirm.tr,
                onTapNext: (isPreOrder) {
                  controller.confirm(context);
                },
              ),
            ],
          );
        },
        onLoading: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          ),
        ),
        onError: (e) => CustomErrorWidget(
          errorText: e,
          onReload: controller.getCheckOutReview,
        ),
      ),
    );
  }
}
