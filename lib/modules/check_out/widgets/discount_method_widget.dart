import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../controllers/customer_summary_controller.dart';
import '../controllers/locations.dart';
import 'row_discount_widget.dart';

class DiscountMethodsWidget extends GetView<CustomerSummaryController> {
  const DiscountMethodsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: primaryColor),
      ),
      child: controller.obx(
        (summary) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Offstage(
              offstage: !(summary?.loyaltyPoints?.loyaltyEnabled ?? false),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomText(
                    '${Translate.doYouToPayWithYourIcons.tr} :',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color.fromRGBO(102, 102, 102, 1),
                    ),
                  ),
                  const SizedBox(height: 8),
                  RowDiscountWidget(
                    hintText: Translate.points.tr,
                    textEditingController: controller.pointTEC,
                    isApply:
                        !(summary?.loyaltyPoints?.hasLoyaltyPoints ?? false),
                    onTapApply: () {
                      final points =
                          int.tryParse(controller.pointTEC.text) ?? 0;
                      controller.onTapPointsApply(Locations.locationId, points);
                    },
                    onTapClear: () {
                      final points =
                          int.tryParse(controller.pointTEC.text) ?? 0;
                      controller.onTapPointsClear(Locations.locationId, points);
                    },
                    validator: (points) {
                      return controller.errorloyelty;
                    },
                  ),
                  const SizedBox(height: 2),
                  CustomText(
                    Translate.yourCurrentBalanceIsNPoints.trParams(
                      params: {
                        'N': summary?.loyaltyPoints?.customerLoyaltyPoints
                                ?.toString() ??
                            '0',
                      },
                    ),
                    style: const TextStyle(fontSize: 10),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            CustomText(
              '${Translate.useCoupon.tr} :',
              style: const TextStyle(
                fontSize: 13,
                color: Color.fromRGBO(102, 102, 102, 1),
              ),
            ),
            const SizedBox(height: 8),
            RowDiscountWidget(
              hintText: Translate.enterCouponCode.tr,
              textEditingController: controller.couponTEC
                ..text = summary?.couponInfo?.couponCode?.toString() ?? '',
              isApply: !(summary?.couponInfo?.hasCoupon ?? true),
              onTapApply: () {
                controller.onTapCupoinApply(
                    controller.couponTEC.text,
                    Locations.locationId,
                    int.tryParse(controller.pointTEC.text) ?? 0);
              },
              onTapClear: () {
                controller.onTapCupoinClear(
                    controller.couponTEC.text,
                    Locations.locationId,
                    int.tryParse(controller.pointTEC.text) ?? 0);
              },
              validator: (coupon) {
                return controller.errorCoupon;
              },
            ),
          ],
        ),
      ),
    );
  }
}
