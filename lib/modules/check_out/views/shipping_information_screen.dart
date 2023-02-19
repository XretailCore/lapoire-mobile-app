import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/components/custom_appbar.dart';
import '../../../core/components/custm_product_card.dart';
import '../../../core/components/custom_error_widget.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/app_colors.dart';
import '../../order_details/widgets/order_details_address_widget.dart';
import '../controllers/shipping_information_controller.dart';
import '../widgets/checkout_title_divider_widget.dart';
import '../widgets/custom_stepper_widget.dart';
import '../widgets/final_summary_widget.dart';

class ShoppingInformationScreen extends GetView<ShippingInformationController> {
  const ShoppingInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: CustomAppBar(title: Translate.checkout.tr, showBackButton: true),
      body: controller.obx(
        (shippingInfo) {
          final products = shippingInfo?.items ?? [];
          return Column(
            children: [
              const SizedBox(height: 10),
              const CustomStepperWidget(currentIndex: 2),
              const SizedBox(height: 10),
              CheckOutTitleDividerWidget(
                  title:
                      "${shippingInfo?.items?.length.toString()} ${Translate.items.tr}"),
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
                            cardColor: Colors.white,
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
                    if (shippingInfo?.address?.id != 0)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: OrderDetailsAddressWidget(
                            addressModel: shippingInfo!.address!),
                      ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 4),
                  CustomText(
                    "${Translate.payment.tr}: ${shippingInfo?.paymentOption?.title ?? ''}",
                    style: const TextStyle(color: AppColors.redColor),
                  ),
                  const SizedBox(height: 8),
                  if (shippingInfo?.configDeliveryPeriod?.max != 0 &&
                      shippingInfo?.configDeliveryPeriod?.min != 0)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.redColor,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomText(
                                Translate.deliveredWithinMinMaxBusinessDays
                                    .trParams(
                                  params: {
                                    'Min': shippingInfo
                                            ?.configDeliveryPeriod?.min
                                            .toString() ??
                                        "",
                                    'Max': shippingInfo
                                            ?.configDeliveryPeriod?.max
                                            .toString() ??
                                        "",
                                    'PeriodName': (shippingInfo
                                            ?.configDeliveryPeriod
                                            ?.periodName ??
                                        "")
                                  },
                                ),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 8),
                  FinalCheckoutSummaryWidget(
                    summary: shippingInfo?.summary ?? [],
                    buttonName: Translate.confirm.tr,
                    onTapNext: (isPreOrder) {
                      controller.confirm(context);
                    },
                  ),
                ],
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
