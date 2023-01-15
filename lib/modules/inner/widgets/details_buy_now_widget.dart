import 'package:flutter/material.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/components/text_button_widget.dart';
import '../../../core/localization/translate.dart';

class DetailsBuyNowWidget extends StatelessWidget {
  const DetailsBuyNowWidget({
    Key? key,
    required this.details,
    required this.onTap,
  }) : super(key: key);

  final OneClickOrderDetailsModel? details;

  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Material(
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text.rich(TextSpan(
                    text: Translate.cashOnDeliveryFees.tr,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    children: <InlineSpan>[
                      TextSpan(
                        text: '  ${Translate.egp.tr}',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      ),
                      TextSpan(
                        text: '  ${details?.codFees.toString()}',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      )
                    ])),
                const SizedBox(height: 8),
                Text.rich(TextSpan(
                    text: Translate.shipmentfees.tr,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    children: <InlineSpan>[
                      TextSpan(
                        text: '  ${Translate.egp.tr}',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      ),
                      TextSpan(
                        text: '  ${details?.shipmentFees}',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      )
                    ])),
                const SizedBox(height: 8),
                Text.rich(TextSpan(
                    text: Translate.address.tr,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    children: <InlineSpan>[
                      TextSpan(
                        text: '  ${details?.address}',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      )
                    ])),
                const SizedBox(height: 8),
                Text.rich(TextSpan(
                    text: Translate.buyNowTotal.tr,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    children: <InlineSpan>[
                      TextSpan(
                        text: '  ${Translate.egp.tr}',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      ),
                      TextSpan(
                        text: '  ${details?.total}',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      )
                    ])),
                const SizedBox(height: 20),
                Center(
                    child: SizedBox(
                        width: 200,
                        child: TextButtonWidget(
                            onPressed: onTap, text: Translate.confirm.tr))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
