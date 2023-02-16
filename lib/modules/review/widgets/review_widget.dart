import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:linktsp_api/data/reviews/models/review_model.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/utils/app_colors.dart';

class ReviewWidget extends StatelessWidget {
  final ItemReview review;
  const ReviewWidget({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: .5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 25,
                backgroundImage: AssetImage("assets/images/logo.png"),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        review.customerName ?? "",
                        style: const TextStyle(
                          color: Color(0xff2E2E2E),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    RatingBar(
                      glow: false,
                      initialRating: review.rating ?? 0,
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
                  ],
                ),
                CustomText(
                  review.date.toString(),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                CustomText(
                  review.description ?? "",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
