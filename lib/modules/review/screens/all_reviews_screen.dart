import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/components/appbar_widget.dart';
import '../../../core/components/custm_product_card.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/components/imtnan_loading_widget.dart';
import '../../../core/localization/translate.dart';
import '../controllers/all_reviews_controller.dart';
import '../widgets/add_review_widget.dart';
import '../widgets/list_of_reviews_widget.dart';
import '../widgets/rating_numbers_widget.dart';

class AllReviwesScreen extends GetView<AllReviewsController> {
  const AllReviwesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarWidget(
        title: Translate.allReviews.tr,
      ),
      body: controller.obx(
          (review) => Column(
                children: [
                  if (controller.productDetailsModel?.selectedProductSku.id !=
                      null)
                    if (controller.productDetailsModel?.selectedProductSku.id !=
                        null)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ProductCardWidget(
                          productId: controller
                              .productDetailsModel!.selectedProductSku.id!,
                          isHorizontal: true,
                          imageHeight: .4.sw,
                          imageWidth: .35.sw,
                          hasOffer: controller.productDetailsModel
                              ?.selectedProductSku.hasDiscount,
                          productName:
                              controller.productDetailsModel?.title ?? "",
                          image: controller.productDetailsModel
                                  ?.selectedProductSku.images.first?.url ??
                              "",
                          brandName: controller.productDetailsModel?.brandName,
                          oldPrice: controller.productDetailsModel
                              ?.selectedProductSku.defaultPrice,
                          price: controller.productDetailsModel
                                  ?.selectedProductSku.finalPrice ??
                              0,
                          isAvailable: controller.productDetailsModel
                                  ?.selectedProductSku.isAvaliable ??
                              false,
                          rate: review?.reviewsAvgRate ?? 0,
                          isBogo: controller.productDetailsModel?.bogoPromoText
                                  ?.isNotEmpty ??
                              true,
                          bogoText:
                              controller.productDetailsModel?.bogoPromoText ??
                                  '',
                          offerPercentage: controller
                                      .productDetailsModel
                                      ?.selectedProductSku
                                      .discounts
                                      .isNotEmpty ??
                                  false
                              ? (controller
                                      .productDetailsModel
                                      ?.selectedProductSku
                                      .discounts
                                      .first
                                      ?.value ??
                                  "")
                              : '',
                        ),
                      ),
                  RatingNumbersWidget(
                    numberOfRatings: review!.reviewsCount!,
                    productRate: review.reviewsAvgRate!,
                  ),
                  AddReviewWidget(numberOfReviews: review.reviewsCount!),
                  ListOfReviewsWidget(reviews: review.items!),
                ],
              ),
          onEmpty: Center(
            child: CustomText(
              Translate.noReviewsYet.tr,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          onLoading: const CustomLoadingWidget()),
    );
  }
}
