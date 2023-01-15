import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/theme.dart';
import '../controllers/filter_controller.dart';

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomText(
                  Translate.size.tr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                              color: controller.sizesIds.contains(size.id)
                                  ? CustomThemes.appTheme.primaryColor
                                  : Colors.transparent,
                              border: Border.all(
                                color: Colors.grey.withOpacity(.6),
                              ),
                            ),
                            child: CustomText(
                              size.title ?? "",
                              style: TextStyle(
                                fontSize: 12,
                                color: controller.sizesIds.contains(size.id)
                                    ? Colors.white
                                    : Colors.black,
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
