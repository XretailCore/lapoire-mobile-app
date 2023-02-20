import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/theme.dart';
import '../controllers/filter_controller.dart';
import 'categories_filter_widget.dart';

class PriceWidgetFilter extends GetView<FilterController> {
  const PriceWidgetFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleWithDivider(title: Translate.price.tr),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    Translate.from.tr,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  PriceFiled(
                    controller: controller.minPriceController.value,
                    onChanged: (min) {},
                  ),
                  CustomText(
                    Translate.to.tr,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  PriceFiled(
                    controller: controller.maxPriceController.value,
                    onChanged: (max) {},
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

class PriceFiled extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  const PriceFiled({Key? key, this.controller, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 45.0,
      decoration: BoxDecoration(
        border: Border.all(color: CustomThemes.appTheme.primaryColor),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0.0),
                child: TextField(
                  onChanged: onChanged,
                  controller: controller,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: CustomThemes.appTheme.primaryColor,
                      fontWeight: FontWeight.w600),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            CustomText(' ${Translate.egp.tr}'),
          ],
        ),
      ),
    );
  }
}
