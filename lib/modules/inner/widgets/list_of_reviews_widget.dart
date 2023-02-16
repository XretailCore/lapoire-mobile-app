import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/components/custom_text.dart';

class ListOfReviewsWidget extends StatelessWidget {
  final List<ItemReviewModel> reviews;

  const ListOfReviewsWidget({Key? key, required this.reviews})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: reviews.length,
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
      itemBuilder: (buildContext, index) {
        final review = reviews.elementAt(index);
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/user_review_icon.png',
                height: 35,
                width: 35,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          review.customerName,
                          style: const TextStyle(
                            color: Color(0xff2E2E2E),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      CustomText(
                        review.date.toString(),
                        style: const TextStyle(
                          color: Color(0xff808080),
                          fontSize: 8,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  RatingBar(
                    glow: false,
                    initialRating: review.rating,
                    itemSize: 15,
                    ignoreGestures: true,
                    updateOnDrag: false,
                    allowHalfRating: true,
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
                    onRatingUpdate: (double value) {},
                  ),
                  const SizedBox(height: 10),
                  CustomText(
                    review.description,
                    style: const TextStyle(
                      color: Color(0xff414141),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                    softWrap: true,
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
