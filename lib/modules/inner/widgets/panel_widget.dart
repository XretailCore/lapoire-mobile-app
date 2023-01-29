import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/app_colors.dart';
import '../controllers/inner_product_controller.dart';
import '../entities/product_entity.dart';

class PanelWidget extends GetView<InnerProductController> {
  const PanelWidget({
    Key? key,
    this.selectdProduct,
  }) : super(key: key);
  final ProductEntity? selectdProduct;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final f = DateFormat('yyyy-MM-dd hh:mm');
    return Container(
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (!(!controller.isAvaliable() && controller.isPreBooking))
                  Expanded(
                    child: TextButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            controller.isAvaliable() || controller.isPreBooking
                                ? primaryColor
                                : Colors.grey,
                          ),

                          foregroundColor: MaterialStateProperty.all(
                            Colors.white,
                          ),
                        ),
                        onPressed: controller.isAvaliable() || controller.isPreBooking
                            ? () async => controller.onTapAddToCard(
                                  context: context,
                                  price: controller
                                      .selectedProduct.selectedProductSku.finalPrice,
                                  quantity: controller.quantity,
                                  skuId: selectdProduct!.selectedProductSku.id!,
                                )
                            : null,
                        child: controller.isPreBooking
                            ? CustomText(Translate.prebooking.tr)
                            : controller.isShowBuyNow()
                                ? CustomText(Translate.addToBasket.tr)
                                : controller.isAvaliable()
                                    ? CustomText(Translate.addToBasket.tr)
                                    : CustomText(Translate.outOfStock.tr)),
                  ),
                const SizedBox(width: 4),
                if (controller.isPreBooking)
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Center(
                        child: CustomText(
                          '${Translate.thisItemWillBeAvailableAt.tr}  ${selectdProduct?.availabilityDate != null ? f.format(selectdProduct!.availabilityDate!) : selectdProduct?.availabilityDate}',
                          style: const TextStyle(fontSize: 11),
                          softWrap: true,
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ),
                if (!controller.isPreBooking && controller.isShowBuyNow())
                  Expanded(
                    child: TextButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          controller.isShowBuyNow() &&
                                  !controller.isPreBooking &&
                                  controller.isAvaliable()
                              ? AppColors.redColor
                              : Colors.grey,
                        ),
                        foregroundColor: MaterialStateProperty.all(
                          Colors.white,
                        ),
                      ),
                      onPressed: controller.isShowBuyNow() &&
                              !controller.isPreBooking &&
                              controller.isAvaliable()
                          ? () => controller.onTapBuyNow(context,
                              skuid: selectdProduct?.selectedProductSku.id,
                              qty: controller.quantity)
                          : null,
                      child: CustomText(Translate.buyNow.tr),
                    ),
                  ),
              ],
            ),
          ),
          CustomText(
            Translate.deliveredWithinMinMaxBusinessDays.trParams(
              params: {
                'Min':
                (selectdProduct?.minDeliveryPeriod).toString(),
                'Max':
                (selectdProduct?.maxDeliveryPeriod).toString(),
                'PeriodName': (selectdProduct?.periodName).toString()
              },
            ),
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
