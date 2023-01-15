import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/components/custom_button.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/theme.dart';
import '../controllers/feedback_order_controller.dart';

Future<void> openFeedbackOrderSheet(BuildContext context,
    {bool isProduct = false,
    String? productNo,
    required OrderDetailsModel orderDetailsModel}) async {
  return await showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: FeedBackWidget(
          isProduct: isProduct,
          productNo: productNo,
          orderDetailsModel: orderDetailsModel,
        ),
      );
    },
  );
}

class FeedBackWidget extends GetView<FeedbackOrderController> {
  final bool isProduct;
  final String? productNo;
  const FeedBackWidget(
      {Key? key,
      this.isProduct = false,
      this.productNo,
      required this.orderDetailsModel})
      : super(key: key);
  final OrderDetailsModel orderDetailsModel;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  Translate.addFeedback.name.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: CustomThemes.appTheme.primaryColor,
                  ),
                ),
              ],
            ),
            const Divider(thickness: 1.2),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  isProduct
                      ? "${Translate.productCode.name.tr} #$productNo"
                      : "${Translate.orderCode.name.tr} #${orderDetailsModel.orderNo}",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomText(
              "${Translate.reason.name.tr} :",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: CustomThemes.appTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 5),
            Obx(
              () => Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: CustomThemes.appTheme.primaryColor,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<ComplaintLookupModel?>(
                    isExpanded: true,
                    dropdownColor: const Color.fromRGBO(241, 241, 241, 1),
                    style: TextStyle(
                      color: CustomThemes.appTheme.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0,
                    ),
                    onChanged: (newValue) {
                      controller.selectedFeedback.value = newValue;
                    },
                    value: controller.selectedFeedback.value,
                    items: [
                      for (var data in controller.feedbackMenu)
                        DropdownMenuItem(
                          child: CustomText(
                            data.name ?? '',
                          ),
                          value: data,
                        )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              labelText: Translate.message.name.tr,
              controller: controller.feedbackTextController,
              validator: (val) {
                return null;
              },
              borderColor: CustomThemes.appTheme.primaryColor,
              maxLines: 5,
              labelColor: CustomThemes.appTheme.primaryColor,
            ),
            const SizedBox(height: 10),
            CustomButton(
              title: Translate.submit.name.tr,
              color: CustomThemes.appTheme.primaryColor,
              onTap: () => controller.addOrderFeedbackAction(
                orderId: orderDetailsModel.id,
                context: context,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
