import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/components/custom_button.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/routes.dart';
import '../../../core/utils/theme.dart';
import '../../../core/utils/validator.dart';
import '../controllers/add_review_controller.dart';

Future<void> openAddReviewDialog(BuildContext context,
    {required bool isUser, required String productCode}) async {
  if (isUser) {
    final addreviewController = Get.find<AddReviewController>();
    addreviewController.productCode = productCode;
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          contentPadding: EdgeInsets.all(0),
          content: AddReviewWidget(),
        );
      },
    );
  } else {
    Get.toNamed(Routes.sign);
  }
}

class AddReviewWidget extends GetView<AddReviewController> {
  const AddReviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: AppColors.highlighter,
      ),
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                CustomText(
                  Translate.addReview.tr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: primaryColor),
                ),
                Divider(color: primaryColor,thickness: 1.5),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  Translate.rateProduct.tr,
                  style: const TextStyle(
                      fontSize: 13, color: AppColors.redColor),
                ),
                const SizedBox(height: 8),
                RatingBar(
                  minRating: 1,
                  initialRating: controller.rate,
                  glowColor: primaryColor,
                  unratedColor: primaryColor,
                  itemSize: 20,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                    full: const Icon(
                      Icons.star,
                      color: AppColors.primaryColor,
                    ),
                    half: const Icon(
                      Icons.star_half,
                      color: AppColors.primaryColor,
                    ),
                    empty: const Icon(
                      Icons.star_border,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  onRatingUpdate: (double value) =>
                      controller.onUpdateRate(value),
                ),
                const SizedBox(height: 15),
                // TextFormFieldWidget(
                //   hint: Translate.describeYourExperience.tr,
                //   hintStyle: TextStyle(
                //     fontSize: 11,
                //     color: primaryColor,
                //     fontWeight: FontWeight.w400,
                //   ),
                //   textEditingController: controller.reviewTEC,
                //   validator: CustomValidator.multiLineTextValidation,
                //   minLines: 2,
                //   maxLines: 5,
                //   backgroundColor: AppColors.highlighter,
                //   contentPadding: const EdgeInsets.all(8),
                //   autovalidateMode: AutovalidateMode.disabled,
                //   autocorrect: true,
                //   enableSuggestions: true,
                //   textInputAction: TextInputAction.done,
                //   textInputType: TextInputType.multiline,
                // ),
                CustomTextField(
                  labelText: Translate.describeYourExperience.name.tr,
                  controller: controller.reviewTEC,
                  validator: CustomValidator.requiredValidation,
                  borderColor: CustomThemes.appTheme.primaryColor,
                  maxLines: 5,
                  labelColor: CustomThemes.appTheme.primaryColor,
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: CustomBorderButton(
                    title: Translate.post.tr,
                    color: AppColors.redColor,
                    radius: 30.0,
                    onTap: () => controller.postReviewAction(context),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
