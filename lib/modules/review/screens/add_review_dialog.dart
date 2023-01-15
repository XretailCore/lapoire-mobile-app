import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/components/text_form_field_widget.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/routes.dart';
import '../../../core/utils/validator.dart';
import '../../check_out/widgets/next_widget.dart';
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
        color: Colors.white,
      ),
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                CustomText(
                  Translate.addReview.tr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: primaryColor),
                ),
                const Spacer(),
                const CloseButton(),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    Translate.rateProduct.tr,
                    style: const TextStyle(
                        fontSize: 13, color: Color.fromRGBO(102, 102, 102, 1)),
                  ),
                  const SizedBox(height: 8),
                  RatingBar.builder(
                    minRating: 1,
                    initialRating: controller.rate,
                    itemSize: 20,
                    itemCount: 5,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: primaryColor,
                    ),
                    onRatingUpdate: (double value) =>
                        controller.onUpdateRate(value),
                  ),
                  const SizedBox(height: 15),
                  TextFormFieldWidget(
                    hint: Translate.describeYourExperience.tr,
                    hintStyle: const TextStyle(
                      fontSize: 11,
                    ),
                    textEditingController: controller.reviewTEC,
                    validator: CustomValidator.multiLineTextValidation,
                    minLines: 2,
                    maxLines: 5,
                    backgroundColor: Colors.white,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    contentPadding: const EdgeInsets.all(8),
                    autovalidateMode: AutovalidateMode.disabled,
                    autocorrect: true,
                    enableSuggestions: true,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.multiline,
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: TextButtonWidget(
                    height: 40,
                    backgroundColor: primaryColor,
                    text: Translate.post.tr,
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
