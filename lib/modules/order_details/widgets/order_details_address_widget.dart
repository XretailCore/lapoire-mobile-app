import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/localization/translate.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/utils/theme.dart';
import '../controllers/order_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsAddressWidget extends GetView<OrderDetailsController> {
  final OrderDetailsModel orderDetailsModel;
  const OrderDetailsAddressWidget({
    Key? key,
    required this.orderDetailsModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardAddressBookWidget(
      address: orderDetailsModel.address?.address ?? "",
      firstName: orderDetailsModel.address?.firstName ?? "",
      lastName: orderDetailsModel.address?.lastName ?? "",
      cityName: orderDetailsModel.address?.city?.name ?? "",
      mobileNumer: orderDetailsModel.address?.mobile ?? "",
    );
  }
}

class CardAddressBookWidget extends StatelessWidget {
  final String? address;
  final String? firstName;
  final String? lastName;
  final String? cityName;
  final String? mobileNumer;

  const CardAddressBookWidget({
    Key? key,
    this.address,
    this.firstName,
    this.lastName,
    this.cityName,
    this.mobileNumer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: CustomThemes.appTheme.primaryColor,
          border: Border.all(color: CustomThemes.appTheme.primaryColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              Translate.shippingInformation.tr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            CustomText(
              address ?? '',
              style: const TextStyle(
                color: Color.fromRGBO(209, 209, 209, 1),
                fontSize: 10,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            CustomText(
              "$firstName $lastName",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 9,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomText(
              cityName ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 9,
                color: Colors.white,
              ),
            ),
            CustomText(
              mobileNumer ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 9,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
