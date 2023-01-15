import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/theme.dart';
import '../controllers/filter_controller.dart';
import '../models/categories_model.dart';

class CategoriesWidgetFilter extends GetView<FilterController> {
  const CategoriesWidgetFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomText(
              Translate.categories.tr,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Obx(
            () => Column(
              children: List<Widget>.generate(
                controller.categories.length,
                (index) {
                  final category = controller.categories[index];
                  final isSelectedCategory =
                      (controller.selectedCategories.isNotEmpty &&
                          controller.selectedCategories.contains(category.id));
                  return Column(
                    children: [
                      SizedBox(
                        height: 30,
                        child: Row(
                          children: [
                            Theme(
                              data: ThemeData(
                                primarySwatch: Colors.blue,
                                unselectedWidgetColor: isSelectedCategory
                                    ? CustomThemes.appTheme.primaryColor
                                    : Colors.black,
                              ),
                              child: Checkbox(
                                value: isSelectedCategory,
                                onChanged: (v) => controller.checkCategory(
                                    index: index, categoryId: category.id!),
                                activeColor: CustomThemes.appTheme.primaryColor,
                              ),
                            ),
                            CustomText(
                              category.title ?? "",
                            )
                          ],
                        ),
                      ),
                      SubCategoriesWidgetFilter(
                        category: category,
                      ),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SubCategoriesWidgetFilter extends GetView<FilterController> {
  final CategoriesFilterModel? category;
  const SubCategoriesWidgetFilter({Key? key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 33),
      child: ListView.separated(
        padding: EdgeInsets.all(5),
        itemCount: category!.children?.length ?? 0,
        separatorBuilder: (context, indexx) => const SizedBox(height: 5),
        shrinkWrap: true,
        itemBuilder: (context, indexx) {
          final subCategory = category?.children?[indexx];
          return SizedBox(
            height: 30,
            child: Row(
              children: [
                Obx(
                  () {
                    final isSelectedSubCategory = controller
                        .selectedsubCategoriesIds
                        .contains(subCategory?.id);
                    return Theme(
                        data: ThemeData(
                          primarySwatch: Colors.blue,
                          unselectedWidgetColor: isSelectedSubCategory
                              ? CustomThemes.appTheme.primaryColor
                              : Colors.black,
                        ),
                        child: Checkbox(
                          value: isSelectedSubCategory,
                          onChanged: (v) => controller.checkSubCategory(
                            subCategoryId: subCategory!.id!,
                            subCategoryName: subCategory.title ?? "",
                          ),
                          activeColor: CustomThemes.appTheme.primaryColor,
                        ));
                  },
                ),
                CustomText(
                  subCategory?.title ?? "",
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
