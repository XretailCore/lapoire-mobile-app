import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/app_colors.dart';
import '../controllers/filter_controller.dart';

class SortWidget extends GetView<FilterController> {
  const SortWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: AppColors.redColor,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: DropdownButton<Map<String, String>>(
                elevation: 0,
                isDense: true,
                alignment: Alignment.center,
                iconEnabledColor: Colors.white,
                underline: const SizedBox(),
                items: [
                  for (var item in controller.sortList)
                    DropdownMenuItem(
                        child: CustomText(item["title"] ?? ''), value: item)
                ],
                onChanged: (value) {
                  final sortTitle = value?["title"] ?? "";
                  final sortSubTitle = value?["subTitle"] ?? "";
                  controller.checkSort(
                      title: sortTitle, sortProp: sortSubTitle);
                  controller.applyFilter(context: context);
                },
                hint: CustomText(
                  Translate.sortBy.tr,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: CustomText(
            //     Translate.sortBy.tr,
            //     style: const TextStyle(
            //       fontSize: 16,
            //       fontWeight: FontWeight.w600,
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 10),
            // Column(
            //   children: List.generate(
            //     controller.sortList.length,
            //     (index) {
            //       final sortTitle = controller.sortList[index]["title"];
            //       final sortSubTitle = controller.sortList[index]["subTitle"];
            //       return InkWell(
            //         onTap: () => controller.applyFilter(
            //           context: context,
            //         ),
            //         child: SizedBox(
            //           height: 30,
            //           child: Row(
            //             children: [
            //               Theme(
            //                 data: ThemeData(
            //                   primarySwatch: Colors.blue,
            //                   unselectedWidgetColor:
            //                       (controller.selectedSorts.contains(sortTitle))
            //                           ? CustomThemes.appTheme.primaryColor
            //                           : Colors.black,
            //                 ),
            //                 child: Checkbox(
            //                   shape: const CircleBorder(),
            //                   value: (controller.selectedSorts
            //                       .contains(sortTitle)),
            //                   onChanged: (v) => controller.checkSort(
            //                       title: sortTitle ?? "",
            //                       sortProp: sortSubTitle ?? ""),
            //                   activeColor: CustomThemes.appTheme.primaryColor,
            //                 ),
            //               ),
            //               CustomText(
            //                 sortTitle,
            //               )
            //             ],
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
    );
  }
}
