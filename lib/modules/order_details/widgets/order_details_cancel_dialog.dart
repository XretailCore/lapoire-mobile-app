import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imtnan/core/utils/app_colors.dart';

import '../../../core/components/custom_button.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/theme.dart';
import '../controllers/cancel_order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';

Future<void> openCancelOrderSheet(
  BuildContext context, {
  required bool isCheckoutCancel,
  required OrderDetailsModel orderDetailsModel,
}) async {
  return await showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return CancelDialogWidget(
        isCheckoutCancel: isCheckoutCancel,
        orderDetailsModel: orderDetailsModel,
      );
    },
  );
}

class CancelDialogWidget extends GetView<CancelOrderController> {
  final bool isCheckoutCancel;
  final OrderDetailsModel orderDetailsModel;
  const CancelDialogWidget(
      {Key? key,
      required this.isCheckoutCancel,
      required this.orderDetailsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.topCenter,
      insetPadding: const EdgeInsets.only(top: 70.0,left: 16.0,right: 16.0),
      backgroundColor: AppColors.highlighter,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  Translate.cancelOrder.name.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: CustomThemes.appTheme.primaryColor,
                  ),
                ),
              ],
            ),
            const Divider(color: AppColors.primaryColor,thickness: 1.5),
            const SizedBox(height: 20),
            Obx(() => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CustomThemes.appTheme.primaryColor,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<CancelReasonLookupModel?>(
                      isExpanded: true,
                      dropdownColor: Colors.white,
                      icon: FaIcon(FontAwesomeIcons.angleDown,size: 16,color: CustomThemes.appTheme.primaryColor,),
                      style: TextStyle(
                        color: CustomThemes.appTheme.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0,
                      ),
                      onChanged: (newValue) {
                        controller.selectedReason.value =
                            newValue as CancelReasonLookupModel;
                      },
                      value: controller.selectedReason.value,
                      items: controller.cancelReasonsMenu
                          .map(
                            (element) =>
                                DropdownMenuItem<CancelReasonLookupModel>(
                              child: CustomText(
                                element.name ?? '',
                              ),
                              value: element,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                )),
            const SizedBox(height: 20),
            CustomTextField(
              labelText: Translate.message.name.tr,
              controller: controller.cancelReasonTextController,
              validator: (val) {
                return null;
              },
              borderColor: CustomThemes.appTheme.primaryColor,
              maxLines: 5,
              labelColor: CustomThemes.appTheme.primaryColor,
            ),
            const SizedBox(height: 10),
            CustomBorderButton(
              title: Translate.submit.name.tr,
              color: AppColors.redColor,
              radius: 30.0,
              onTap: () => controller.cancelOrderAction(
                context: context,
                orderDetailsModel: orderDetailsModel,
                isCheckout: isCheckoutCancel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
