import 'package:cowpay/core/helpers/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modules/choose_zone/change_zone_dialogue.dart';
import '../../modules/map/controllers/map_controller.dart';
import '../localization/translate.dart';
import '../utils/theme.dart';
import 'custom_text.dart';

class LocationWidget extends GetView<MapController> {
  final String pageName;

  const LocationWidget({Key? key, required this.pageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          controller.determinePosition();
          controller.getZonesDetails();
          controller.getZones();
          openZoneDialog(context);
        },
        child: Row(
          children: [
            InkWell(
              onTap: () {},
              child: Icon(
                Icons.location_on,
                size: 20,
                color: CustomThemes.lightThemeData.primaryColor,
              ),
            ),
            const SizedBox(width: 5),
            SizedBox(
              width:
                  controller.selectedAddress.value.isNotEmpty ? 0.30.sw : 0.0,
              child: CustomText(
                controller.selectedAddress.value,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color.fromRGBO(112, 112, 112, 1),
                ),
              ),
            ),
            const SizedBox(width: 3),
            CustomText(
              Translate.change.tr,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: CustomThemes.lightThemeData.primaryColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
