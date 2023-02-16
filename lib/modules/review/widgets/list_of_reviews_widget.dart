import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/components/custom_text.dart';

class ListOfReviewsWidget extends StatelessWidget {
  final List<ItemReview> reviews;
  const ListOfReviewsWidget({Key? key, required this.reviews})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: ListView.separated(
          itemCount: reviews.length,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(5),
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
          itemBuilder: (buildContext, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/user_review_icon.png',
                      height: 35,
                      width: 35,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          CustomText(
                            reviews[index].customerName ?? "",
                            style: const TextStyle(
                              color: Color(0xff2E2E2E),
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const Spacer(),
                          CustomText(
                            reviews[index].date!.toString(),
                            style: const TextStyle(
                              color: Color(0xff808080),
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      RatingBar(
                        glow: false,
                        initialRating: reviews[index].rating ?? 0,
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
                        reviews[index].description ?? "",
                        style: const TextStyle(
                          color: Color(0xff414141),
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
