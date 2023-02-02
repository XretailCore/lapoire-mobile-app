import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/utils/app_colors.dart';
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
  return await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
      child: Material(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: AppColors.highlighter,
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
              Divider(thickness: 1.5,color: CustomThemes.appTheme.primaryColor,),
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
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<ComplaintLookupModel?>(
                      borderRadius: BorderRadius.circular(5),
                      isExpanded: true,
                      dropdownColor: const Color.fromRGBO(241, 241, 241, 1),
                      style: TextStyle(
                        color: CustomThemes.appTheme.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0,
                      ),
                      icon: FaIcon(FontAwesomeIcons.angleDown,size: 16,color: CustomThemes.appTheme.primaryColor,),
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
              CustomBorderButton(
                title: Translate.send.name.tr,
                color: AppColors.redColor,
                radius: 20.0,
                onTap: () => controller.addOrderFeedbackAction(
                  orderId: orderDetailsModel.id,
                  context: context,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
