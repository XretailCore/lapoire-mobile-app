import '../../../core/components/custom_error_widget.dart';
import '../../../core/components/custom_text.dart';
import '../widgets/sort_widget.dart';

import '../../../core/components/custom_button.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/theme.dart';
import '../controllers/filter_controller.dart';
import '../widgets/categories_filter_widget.dart';
import '../widgets/price_filter_widget.dart';
import '../widgets/sizes_filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterScreen extends GetView<FilterController> {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .9,
      child: controller.obx(
            (data) => Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              // const FilterTabsWidget(),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.only(bottom: 10),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey)),
                ),
                child: Row(
                  children: [
                    CustomText(
                      Translate.filter.tr,
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () => controller.closeFilter(),
                      child: const Icon(Icons.clear),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: const [
                      CategoriesWidgetFilter(),
                      SizedBox(height: 15),
                      SizesWidgetFilter(),
                      SizedBox(height: 15),
                      PriceWidgetFilter(),
                      SizedBox(height: 15),
                      SortWidget(),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomBorderButton(
                        color: CustomThemes.appTheme.primaryColor,
                        title: Translate.apply.name.tr,
                        onTap: () => controller.applyFilter(context: context),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomBorderButton(
                        color: Colors.white,
                        title: Translate.clear.name.tr,
                        textColor: CustomThemes.appTheme.primaryColor,
                        onTap: controller.clearFilter,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        onError: (e) => CustomErrorWidget(
          errorText: e,
        ),
      ),
    );
  }
}
