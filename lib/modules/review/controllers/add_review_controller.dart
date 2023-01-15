import 'package:facebook_app_events/facebook_app_events.dart';

import '../../../core/components/custom_loaders.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/data/exception_api.dart';
import 'package:linktsp_api/linktsp_api.dart';

class AddReviewController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController reviewTEC = TextEditingController();
  double rate = 0;
  String? productCode;

  final facebookAppEvents = FacebookAppEvents();

  Future<void> rateFBEvent(double rate) async {
    facebookAppEvents.logRated(valueToSum: rate);
  }

  Future postReviewAction(BuildContext context) async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (isValid) {
      Get.back();
      openLoadingDialog(Get.context!);
      try {
        final controller = Get.find<UserSharedPrefrenceController>();
        int _customerId = controller.getUserId!;

        bool? success = await LinkTspApi.instance.review.addReview(
          itemReview: ItemReview(
            productCode: productCode,
            rating: rate,
            description: reviewTEC.text,
            customerId: _customerId,
          ),
        );
        if (success == true) {
          rateFBEvent(rate);

          cancelDialog();
          ScaffoldMessenger.of(Get.context!).showSnackBar(
              HelperFunctions.customSnackBar(
                  message: Translate.productHasBeenRatedSuccessfully.tr));
        } else {
          cancelDialog();
          ScaffoldMessenger.of(Get.context!).showSnackBar(
              HelperFunctions.customSnackBar(
                  message: Translate.retry.tr, backgroundColor: Colors.red));
        }
      } on ExceptionApi catch (e) {
        cancelDialog();
        ScaffoldMessenger.of(Get.context!).showSnackBar(
            HelperFunctions.customSnackBar(
                message: e.message, backgroundColor: Colors.red));
      } catch (e) {
        cancelDialog();
        ScaffoldMessenger.of(Get.context!).showSnackBar(
            HelperFunctions.customSnackBar(
                message: e.toString(), backgroundColor: Colors.red));
      }
    }
  }

  void onUpdateRate(double value) {
    rate = value;
  }

  void cancelDialog() {
    reviewTEC.clear();
    rate = 1;
    Get.back();
  }

  @override
  void onClose() {
    reviewTEC.dispose();
    super.onClose();
  }
}
