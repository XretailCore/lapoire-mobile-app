import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/localization/translate.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/helper_functions.dart';

class FeedbackOrderController extends GetxController {
  final feedbackTextController = TextEditingController(text: '');
  final selectedFeedback = Rx<ComplaintLookupModel?>(null);
  final feedbackMenu = <ComplaintLookupModel>[].obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onReady() {
    super.onReady();
    getFeedbackList();
  }

  Future<void> getFeedbackList() async {
    await HelperFunctions.errorRequestsSnakBarHandler(
      Get.context!,
      loadingFunction: () async {
        final feedbackList =
            await LinkTspApi.instance.lookUp.getComplaintLookup();
        feedbackMenu.addAll(feedbackList);
        if (feedbackMenu.isNotEmpty) {
          selectedFeedback.value = feedbackMenu.first;
        }
      },
    );
  }

  Future<void> addOrderFeedbackAction(
      {int? orderId, required BuildContext context}) async {
    await HelperFunctions.errorRequestsSnakBarHandler<void>(context,
        loadingFunction: () async {
      Get.back();
      final userId = Get.find<UserSharedPrefrenceController>().getUserId;
      await LinkTspApi.instance.complaint.saveComplaint(
        complaintModel: ComplaintModel(
          customerId: userId,
          complaintReasonId: selectedFeedback.value?.id,
          orderId: orderId,
          content: feedbackTextController.text,
        ),
      );
    }, onSuccessFunction: (_) async {
      feedbackTextController.clear();
      HelperFunctions.showSnackBar(
        context: context,
        message: Translate.feedbackSuccessMsg.name.tr,
        color: Theme.of(context).primaryColor,
      );
    });
  }

  @override
  void onClose() {
    feedbackTextController.dispose();
    selectedFeedback.close();
    feedbackMenu.close();
    super.onClose();
  }
}
