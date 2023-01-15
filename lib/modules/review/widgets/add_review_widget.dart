import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../controllers/all_reviews_controller.dart';

class AddReviewWidget extends GetView<AllReviewsController> {
  final int numberOfReviews;
  const AddReviewWidget({
    Key? key,
    this.numberOfReviews = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xff868686),
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Row(
            children: [
              Expanded(
                child: CustomText(
                  '$numberOfReviews ${Translate.reviews.tr}',
                  style: const TextStyle(
                      color: Color(0xff808080),
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
              ),
              TextButton.icon(
                onPressed: () => controller.onTapAddReview(
                    controller.productDetailsModel?.code, context),
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.black12),
                    foregroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(46, 46, 46, 1))),
                icon: const Icon(
                  FontAwesomeIcons.penToSquare,
                  size: 16,
                ),
                label: CustomText(
                  Translate.addReview.tr,
                  style: const TextStyle(
                      color: Color.fromRGBO(46, 46, 46, 1),
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
