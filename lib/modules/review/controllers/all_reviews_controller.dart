import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/strings.dart';
import '../../inner/entities/product_entity.dart';
import '../screens/add_review_dialog.dart';

class AllReviewsController extends GetxController
    with StateMixin<ReviewModel?> {
  ProductEntity? productDetailsModel;

  @override
  void onReady() {
    super.onReady();
    getProductRate();
  }

  Future<void> getProductRate() async {
    var args = (Get.arguments ?? {}) as Map;
    productDetailsModel = args[Arguments.productDetails] as ProductEntity?;
    final userSharedPrefrenceController =
        Get.find<UserSharedPrefrenceController>();
    final code = productDetailsModel?.code;
    if (code != null) {
      try {
        change(null, status: RxStatus.loading());
        final reviewModel = await LinkTspApi.instance.review.getProductReviews(
          productCode: code,
          zoneId: userSharedPrefrenceController.getCurrentZone?.id,
        );
        if (reviewModel.items!.isNotEmpty) {
          change(reviewModel, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.empty());
        }
      } catch (e) {
        change(null, status: RxStatus.error(e.toString()));
      }
    } else {
      change(null, status: RxStatus.error());
    }
  }

  void onTapAddReview(String? skuCode, BuildContext context) {
    final userSharedPrefrenceController =
        Get.find<UserSharedPrefrenceController>();
    final isUser = userSharedPrefrenceController.isUser;
    openAddReviewDialog(context, isUser: isUser, productCode: skuCode ?? '');
  }
}
