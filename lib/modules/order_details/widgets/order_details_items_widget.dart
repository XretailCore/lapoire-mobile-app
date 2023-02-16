import 'package:dotted_line/dotted_line.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/components/custm_product_card.dart';
import '../controllers/order_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderDetailsItemsWidget extends GetView<OrderDetailsController> {
  const OrderDetailsItemsWidget({Key? key, required this.orderDetailsModel})
      : super(key: key);
  final OrderDetailsModel orderDetailsModel;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orderDetailsModel.orderItems?.length ?? 0,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final item = orderDetailsModel.orderItems!.elementAt(index);
        return Column(
          children: [
            ProductCardWidget(
              elevation: 0,
              isHorizontal: true,
              productId: item.skuId!,
              promoText: item.promoText ?? '',
              productName: item.title ?? "",
              image: item.imageUrl ?? "",
              imageHeight: .35.sw,
              imageWidth: .35.sw,
              oldPrice: item.price,
              price: item.finalPrice ?? 0,
              isBogo: !(item.bogoPromoText == null),
              hasOffer: !(item.productDiscountList == null ||
                  item.productDiscountList!.isEmpty),
              offerPercentage: item.productDiscountList == null ||
                      item.productDiscountList!.isEmpty
                  ? ""
                  : item.productDiscountList?.first.value ?? "",
              size: item.size,
              count: item.qty,
              isAvailable: !(item.isOutOfStock ?? false),
              bogoText: item.bogoPromoText ?? '',
            ),
            index!=orderDetailsModel.orderItems!.length-1?const DottedLine(dashColor: AppColors.redColor,) :const SizedBox()
          ],
        );
      },
    );
  }
}
