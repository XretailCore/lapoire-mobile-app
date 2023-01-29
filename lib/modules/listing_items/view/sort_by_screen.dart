import '../../../core/components/custom_error_widget.dart';
import '../widgets/sort_widget.dart';
import '../controllers/filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SortByScreen extends GetView<FilterController> {
  const SortByScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (data) => Container(
        color: Colors.white,
        child: Row(
          children: const[
            // const FilterTabsWidget(),
            SortWidget(),
            // Expanded(
            //     child: Column(
            //       children: const [
            //         //DropdownButton(items: items, onChanged: onChanged),
            //         // CategoriesWidgetFilter(),
            //         // SizedBox(height: 15),
            //         // SizesWidgetFilter(),
            //         // SizedBox(height: 15),
            //         // PriceWidgetFilter(),
            //         // SizedBox(height: 15),
            //
            //         SizedBox(height: 10),
            //       ],
            //     ),
            //
            // ),
            // Container(
            //   margin: const EdgeInsets.all(15),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: CustomBorderButton(
            //           color: CustomThemes.appTheme.primaryColor,
            //           title: Translate.apply.name.tr,
            //           onTap: () => controller.applyFilter(context: context),
            //         ),
            //       ),
            //       const SizedBox(width: 10),
            //       Expanded(
            //         child: CustomBorderButton(
            //           color: Colors.white,
            //           title: Translate.clear.name.tr,
            //           textColor: CustomThemes.appTheme.primaryColor,
            //           onTap: controller.clearFilter,
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
      onError: (e) => CustomErrorWidget(
        errorText: e,
      ),
    );
  }
}
