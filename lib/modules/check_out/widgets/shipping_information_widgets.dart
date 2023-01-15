import 'package:flutter/material.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';

class ShippingInformationWidget extends StatelessWidget {
  const ShippingInformationWidget(
      {Key? key, this.address, this.min, this.max, this.deliveryNote})
      : super(key: key);
  final AddressModel? address;
  final int? min, max;
  final String? deliveryNote;
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Card(
      elevation: 1.5,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: primaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  Translate.shippingInformation.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
                const SizedBox(height: 4),
                CustomText(
                  address?.address?.toUpperCase() ?? "",
                  style: const TextStyle(
                    color: Color.fromRGBO(209, 209, 209, 1),
                    fontSize: 10,
                  ),
                  softWrap: true,
                ),
                CustomText(
                  '${address?.firstName} ${address?.lastName}',
                  softWrap: true,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 9,
                  ),
                ),
                CustomText(
                  address?.city?.name ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                  ),
                ),
                CustomText(
                  address?.mobile ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            CustomText(
              deliveryNote?.toUpperCase(),
              textAlign: TextAlign.start,
              softWrap: true,
              maxLines: 2,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
