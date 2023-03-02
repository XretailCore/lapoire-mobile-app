import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import '../../../core/components/custom_error_widget.dart';
import '../../../core/components/custom_text.dart';
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
    final primary = CustomThemes.appTheme.primaryColor;
    return SizedBox(
      width: .9.sw,
      child: controller.obx(
        (data) => Container(
          color: AppColors.highlighter,
          padding: const EdgeInsets.only(top: 50, right: 20.0, left: 20.0),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.transparent,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: DottedBorder(
                    padding: const EdgeInsets.all(4),
                    borderType: BorderType.Circle,
                    color: primary,
                    child: InkWell(
                      onTap: () => controller.closeFilter(),
                      child: Icon(
                        Icons.clear,
                        color: primary,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
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
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Column(
                    children: [
                      CustomBorderButton(
                        color: AppColors.redColor,
                        title: Translate.apply.name.tr,
                        radius: 30,
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          if (int.parse(
                                      controller.minPriceController.value.text) >
                                  int.parse(
                                      controller.maxPriceController.value.text) ||
                              (int.parse(controller
                                          .minPriceController.value.text) <
                                      controller
                                          .filterParameters.priceRange!.minPrice!
                                          .toInt() ||
                                  int.parse(controller
                                          .maxPriceController.value.text) >
                                      controller
                                          .filterParameters.priceRange!.maxPrice!
                                          .toInt())) {
                            controller.clearFilter(getBack: false);
                            showSnackBarAsBottomSheet(context);
                          } else {
                            controller.applyFilter(context: context);
                            Get.back();
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomBorderButton(
                        radius: 30,
                        color: CustomThemes.appTheme.primaryColor,
                        title: Translate.clearAll.name.tr,
                        onTap: controller.clearFilter,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        onError: (e) => CustomErrorWidget(
          errorText: e,
        ),
      ),
    );
  }
}

void showSnackBarAsBottomSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    barrierColor: Colors.transparent,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 5), () {
        try {
          Navigator.pop(context);
        } on Exception {}
      });
      return Container(
        color: Colors.grey.shade800,
        padding: const EdgeInsets.all(12),
        child: Wrap(
          children: [
            CustomText(
              Translate.validRange.tr,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      );
    },
  );
}
