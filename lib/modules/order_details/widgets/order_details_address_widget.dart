import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/localization/translate.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/utils/theme.dart';
import '../controllers/order_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsAddressWidget extends GetView<OrderDetailsController> {
  final AddressModel addressModel;
  const OrderDetailsAddressWidget({
    Key? key,
    required this.addressModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardAddressBookWidget(
      address: addressModel.address?? "",
      firstName: addressModel.firstName ?? "",
      lastName: addressModel.lastName ?? "",
      cityName: addressModel.city?.name ?? "",
      mobileNumer: addressModel.mobile ?? "",
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
    final primary=CustomThemes.appTheme.primaryColor;
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: CustomThemes.appTheme.primaryColor),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FaIcon(FontAwesomeIcons.locationDot,color: primary,size: 16.0),
            const SizedBox(width: 16.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  Translate.shippingInformation.tr,
                  style:  TextStyle(
                    color: primary,
                    fontSize: 15,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                CustomText(
                  address ?? '',
                  style:  TextStyle(
                    color: primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                CustomText(
                  "$firstName $lastName",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:  TextStyle(
                    fontSize: 12,
                    color: primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                CustomText(
                  cityName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                CustomText(
                  mobileNumer ?? '',
                  style: TextStyle(
                    color: primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
