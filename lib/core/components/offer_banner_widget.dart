import 'package:flutter/material.dart';
import 'custom_text.dart';

class OfferBannerWidget extends StatelessWidget {
  final String offerText;
  const OfferBannerWidget({
    Key? key,
    required this.offerText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(0),
      shadowColor: const Color.fromRGBO(255, 7, 7, 1),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 7, 7, 1),
        ),
        child: CustomText(
          offerText,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 10,
            color: Colors.white,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
