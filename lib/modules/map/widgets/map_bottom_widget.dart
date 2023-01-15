import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_button.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/theme.dart';
import '../controllers/map_controller.dart';

class MapBottomWidget extends GetView<MapController> {
  final String? address;
  final Function()? onTap;
  const MapBottomWidget({
    Key? key,
    this.address,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            Translate.deliverHere.name.tr,
            style: TextStyle(
              color: CustomThemes.appTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          // Row(
          //   children: [
          //     const CustomText(
          //       title: "Zone: ",
          //       maxLines: 2,
          //       weight: FontWeight.bold,
          //       overflow: TextOverflow.ellipsis,
          //     ),
          //     Expanded(
          //       child: CustomText(
          //         title: controller.selectedZoneDetailsModel.value
          //                         .coverageArea ==
          //                     null ||
          //                 controller
          //                         .selectedZoneDetailsModel.value.coverageArea
          //                         .toString() ==
          //                     ""
          //             ? "Your Address"
          //             : address!,
          //         maxLines: 2,
          //         weight: FontWeight.bold,
          //         overflow: TextOverflow.ellipsis,
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: CustomThemes.appTheme.primaryColor,
                size: 20,
              ),
              Expanded(
                child: CustomText(
                  address == "" ? Translate.yourAddress.name.tr : address!,
                  maxLines: 2,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          CustomButton(
            title: Translate.deliverHere.name.tr,
            color: CustomThemes.appTheme.primaryColor,
            onTap: onTap,
          )
        ],
      ),
    );
  }
}
