import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/theme.dart';
import '../controllers/filter_controller.dart';

class SortWidget extends GetView<FilterController> {
  const SortWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomText(
                Translate.sortBy.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: List.generate(
                controller.sortList.length,
                (index) {
                  final sortTitle = controller.sortList[index]["title"];
                  final sortSubTitle = controller.sortList[index]["subTitle"];
                  return InkWell(
                    onTap: () => controller.applyFilter(
                      context: context,
                    ),
                    child: SizedBox(
                      height: 30,
                      child: Row(
                        children: [
                          Theme(
                            data: ThemeData(
                              primarySwatch: Colors.blue,
                              unselectedWidgetColor:
                                  (controller.selectedSorts.contains(sortTitle))
                                      ? CustomThemes.appTheme.primaryColor
                                      : Colors.black,
                            ),
                            child: Checkbox(
                              shape: const CircleBorder(),
                              value: (controller.selectedSorts
                                  .contains(sortTitle)),
                              onChanged: (v) => controller.checkSort(
                                  title: sortTitle ?? "",
                                  sortProp: sortSubTitle ?? ""),
                              activeColor: CustomThemes.appTheme.primaryColor,
                            ),
                          ),
                          CustomText(
                            sortTitle,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
