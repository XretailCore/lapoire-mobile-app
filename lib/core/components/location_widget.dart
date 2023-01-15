import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modules/map/controllers/map_controller.dart';
import '../localization/translate.dart';
import '../utils/routes.dart';
import '../utils/strings.dart';
import '../utils/theme.dart';
import 'custom_text.dart';

class LocationWidget extends GetView<MapController> {
  final String pageName;
  const LocationWidget({Key? key, required this.pageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            Translate.deliverTo.tr,
            style: TextStyle(
              color: CustomThemes.lightThemeData.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () {
              controller.determinePosition();
              controller.getZonesDetails();
              controller.getZones();
              Get.toNamed(Routes.map,
                  arguments: {Arguments.mapPageName: pageName});
            },
            child: Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.location_on,
                    size: 16,
                    color: CustomThemes.lightThemeData.primaryColor,
                  ),
                ),
                const SizedBox(width: 5),
                CustomText(
                  controller.selectedAddress.value,
                  style: const TextStyle(
                    color: Color.fromRGBO(112, 112, 112, 1),
                  ),
                ),
                const SizedBox(width: 10),
                CustomText(
                  Translate.change.tr,
                  style: TextStyle(
                    color: CustomThemes.lightThemeData.primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
