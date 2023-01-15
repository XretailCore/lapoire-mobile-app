import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/theme.dart';
import '../controllers/filter_controller.dart';

class PriceWidgetFilter extends GetView<FilterController> {
  const PriceWidgetFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomText(
                Translate.price.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            RangeSlider(
              divisions: 100,
              values: RangeValues(
                  controller.minPrice.value, controller.maxPrice.value),
              min: controller.filterParameters.priceRange!.minPrice!,
              max: controller.filterParameters.priceRange!.maxPrice!,
              activeColor: CustomThemes.appTheme.primaryColor,
              inactiveColor: Colors.grey,
              labels: RangeLabels(
                controller.minPrice.value.round().toString(),
                controller.maxPrice.value.round().toString(),
              ),
              onChanged: (values) => controller.changePriceRange(values),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    "${controller.minPrice.value.toStringAsFixed(0)} ${Translate.egp.name.tr}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CustomThemes.appTheme.colorScheme.secondary,
                    ),
                  ),
                  const Spacer(),
                  CustomText(
                    "${controller.maxPrice.value.toStringAsFixed(0)} ${Translate.egp.name.tr}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CustomThemes.appTheme.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
