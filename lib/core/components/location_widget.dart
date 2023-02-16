import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:imtnan/modules/choose_zone/controllers/choose_zone_controller.dart';
import '../../modules/choose_zone/change_zone_dialogue.dart';
import '../localization/translate.dart';
import '../utils/theme.dart';
import 'custom_text.dart';

class LocationWidget extends GetView<ZoneController> {
  final String pageName;

  const LocationWidget({Key? key, required this.pageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          controller.getZones();
          openZoneDialog(context);
        },
        child: Row(
          children: [
            Icon(
              Icons.location_on,
              size: 20,
              color: CustomThemes.lightThemeData.primaryColor,
            ),
            const SizedBox(width: 5),
            SizedBox(
              width: controller.selectedZoneName.value.isNotEmpty ?? false
                  ? 0.25.sw
                  : 0.0,
              child: CustomText(
                controller.selectedZoneName.value,
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
