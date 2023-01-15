import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/utils/theme.dart';
import '../controllers/filter_controller.dart';

class ListingFilterOptionwidget extends GetView<FilterController> {
  const ListingFilterOptionwidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Offstage(
        offstage: ((controller.subCategories).isEmpty),
        child: Card(
          margin: const EdgeInsets.all(0),
          child: Container(
            height: 48,
            padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10),
            child: ListView.separated(
              itemCount: controller.subCategories.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsetsDirectional.only(end: 10),
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final subCategory = controller.subCategories[index];

                return Obx(
                  () => GestureDetector(
                    onTap: () => controller.applyFilterOnsubCategory(
                      subCategoryId: subCategory.id!,
                      subCategoryName: subCategory.title ?? '',
                      context: context,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      decoration: BoxDecoration(
                        color: (controller.selectedsubCategoriesIds
                                .contains(subCategory.id))
                            ? CustomThemes.appTheme.primaryColor
                            : Colors.transparent,
                        border: Border.all(
                          color: (controller.selectedsubCategoriesIds
                                  .contains(subCategory.id))
                              ? Colors.transparent
                              : CustomThemes.appTheme.primaryColor,
                        ),
                      ),
                      child: CustomText(
                        subCategory.title ?? '',
                        style: TextStyle(
                          color: (controller.selectedsubCategoriesIds
                                  .contains(subCategory.id))
                              ? Colors.white
                              : CustomThemes.appTheme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
