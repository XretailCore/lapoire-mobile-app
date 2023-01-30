import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/utils/theme.dart';
import 'package:popover/popover.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/app_colors.dart';
import '../controllers/filter_controller.dart';

class SortWidget extends GetView<FilterController> {
  const SortWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showPopover(
          context: context,
          bodyBuilder: (context) => SortListItems(),
          direction: PopoverDirection.bottom,
          width: 200,
          height: 245,
          arrowHeight: 5,
          arrowWidth: 20,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: const BoxDecoration(
            color: AppColors.redColor,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          children: [
            CustomText(
              Translate.sortBy.tr,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const FaIcon(
              FontAwesomeIcons.caretDown,
              color: Colors.white,
              size: 12,
            )
          ],
        ),
      ),
    );
  }
}

class SortListItems extends StatelessWidget {
  SortListItems({Key? key}) : super(key: key);
  final controller = Get.find<FilterController>();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            for (var item in controller.sortList)
              InkWell(
                highlightColor: Colors.transparent,
                onTap: () {
                  final sortTitle = item["title"] ?? "";
                  final sortSubTitle = item["subTitle"] ?? "";
                  controller.checkSort(
                      title: sortTitle, sortProp: sortSubTitle);
                  controller.applyFilter(context: context);
                  Get.back();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        color: (controller.sortProp.value == item["subTitle"])
                            ? AppColors.highlighter
                            : Colors.transparent,
                        height: 35,
                        child: Center(
                            child: CustomText(
                          item["title"] ?? '',
                          style: TextStyle(
                              color: (controller.sortProp.value ==
                                      item["subTitle"])
                                  ? AppColors.redColor
                                  : CustomThemes.appTheme.primaryColor),
                        ))),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
