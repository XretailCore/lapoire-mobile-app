import 'package:flutter/material.dart';
import '../../../core/localization/translate.dart';

import '../../../core/components/custom_text.dart';

class RatingNumbersWidget extends StatelessWidget {
  final int numberOfRatings;
  final double productRate;

  const RatingNumbersWidget({
    Key? key,
    this.numberOfRatings = 0,
    this.productRate = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                text: '$productRate',
                style: const TextStyle(
                    color: Color(0xff2E2E2E),
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                      text: ' ${Translate.outOf.tr} 5',
                      style: const TextStyle(
                          color: Color(0xff808080),
                          fontSize: 14,
                          fontWeight: FontWeight.normal)),
                ],
              ),
            ),
          ),
          CustomText(
            '$numberOfRatings ${Translate.ratings.tr}',
            style: const TextStyle(
                color: Color(0xff808080),
                fontSize: 14,
                fontWeight: FontWeight.normal),
          )
        ],
      ),
    );
  }
}
