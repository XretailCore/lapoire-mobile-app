import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../controllers/stores_controller.dart';

class DistanceWidget extends GetView<StoresController> {
  final TextStyle? textStyle;
  final Color? activeColor;
  const DistanceWidget({Key? key, this.textStyle, this.activeColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: controller.distances
          .map(
            (e) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => Radio<int>(
                    activeColor: activeColor,
                    value: e,
                    groupValue: controller.selectedDistance,
                    onChanged: (val) => controller.selectedDistance = val!,
                  ),
                ),
                CustomText(
                  '$e ${Translate.km.tr}',
                  style: textStyle,
                  softWrap: true,
                )
              ],
            ),
          )
          .toList(growable: false),
    );
  }
}
