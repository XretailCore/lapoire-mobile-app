import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/theme.dart';
import '../controllers/filter_controller.dart';
import 'categories_filter_widget.dart';

class SizesWidgetFilter extends GetView<FilterController> {
  const SizesWidgetFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWithDivider(title: Translate.size.tr),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(
                    controller.sizes.length,
                    (index) {
                      final size = controller.sizes[index];
                      return Obx(
                        () => InkWell(
                          onTap: () => controller.checkSize(size.id!),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 8),
                            decoration: BoxDecoration(
                              color: controller.sizesIds.contains(size.id)
                                  ? CustomThemes.appTheme.primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(30.0),
                              border: Border.all(
                                color: CustomThemes.appTheme.primaryColor
                                    .withOpacity(.6),
                              ),
                            ),
                            child: CustomText(
                              size.title ?? "",
                              style: TextStyle(
                                fontSize: 14,
                                color: controller.sizesIds.contains(size.id)
                                    ? Colors.white
                                    : CustomThemes.appTheme.primaryColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
