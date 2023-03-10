import 'package:flutter/material.dart';
import 'package:imtnan/core/components/star_widget.dart';
import 'custom_text.dart';

class OfferBannerWidget extends StatelessWidget {
  final String offerText;
  final Color backgroundColor;
  final Color textColor;
  final double? size;

  const OfferBannerWidget(
      {Key? key,
      required this.offerText,
      required this.backgroundColor,
      required this.textColor,
      this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(size ?? 50, size ?? 50),
          painter: RPSCustomPainter(backgroundColor),
        ),
        SizedBox(
          height: 50,
          width: 40,
          child: Center(
            child: CustomText(
              offerText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 9,
                color: textColor,
              ),
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
