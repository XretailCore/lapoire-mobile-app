import 'package:flutter/material.dart';
import 'package:imtnan/core/components/star_widget.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import '../utils/theme.dart';
import 'custom_text.dart';

class OfferBannerWidget extends StatelessWidget {
  final String offerText;
  final Color backgroundColor;
  final Color textColor;

  const OfferBannerWidget({
    Key? key,
    required this.offerText,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: const Size(50, 50),
          painter: RPSCustomPainter(backgroundColor),
        ),
        SizedBox(
          height: 30,
          width: 30,
          child: CustomText(
            offerText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 10,
              color: textColor,
            ),
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
