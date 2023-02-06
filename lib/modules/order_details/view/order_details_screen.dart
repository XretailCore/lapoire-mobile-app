import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/components/custom_appbar.dart';
import '../../../core/components/custom_error_widget.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/components/imtnan_loading_widget.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/theme.dart';
import '../controllers/order_details_controller.dart';
import '../widgets/order_details_address_widget.dart';
import '../widgets/order_details_buttons_widget.dart';
import '../widgets/order_details_items_widget.dart';
import '../widgets/order_details_summary_widget.dart';

class OrderDetailsScreen extends GetView<OrderDetailsController> {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Translate.orderDetails.name.tr,
        showBackButton: true,
      ),
      body: controller.obx(
        (orderDetailsModel) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CustomText(
                        formattedDate(orderDetailsModel?.date ?? ""),
                        style: TextStyle(
                          color: CustomThemes.appTheme.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      CustomText(
                        "${Translate.orderNo.tr}. #${orderDetailsModel?.orderNo}",
                        style: const TextStyle(
                          color: AppColors.redColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                      color: CustomThemes.appTheme.primaryColor, thickness: 1)
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  OrderDetailsItemsWidget(
                      orderDetailsModel: orderDetailsModel!),
                  const SizedBox(height: 8),
                  if (orderDetailsModel.address != null)
                    OrderDetailsAddressWidget(
                        addressModel: orderDetailsModel.address!),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: PaymentSummaryWidget(orderDetailsModel: orderDetailsModel),
            ),
            const SizedBox(height: 8),
            OrderDetailsSummaryWidget(orderDetailsModel: orderDetailsModel),
            Container(
                color: AppColors.highlighter,
                child: Column(
                  children: [
                    OrderDetailsButtonsWidget(
                        orderDetailsModel: orderDetailsModel),
                    const SizedBox(height: 8),
                  ],
                )),
          ],
        ),
        onLoading: const CustomLoadingWidget(),
        onError: (e) => CustomErrorWidget(
          errorText: e,
          onReload: controller.getOrderDetails,
        ),
      ),
    );
  }
}

String formattedDate(String date) {
  var inputFormat = DateFormat('dd/MM/yyyy');
  DateTime dateTime = inputFormat.parse(date);
  return DateFormat('MMM. dd- yyyy').format(dateTime);
}
