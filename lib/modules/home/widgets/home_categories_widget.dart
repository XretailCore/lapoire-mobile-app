import 'package:imtnan/core/utils/app_colors.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/theme.dart';
import '../controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/data/page_block/models/new_page_block_model.dart';

class HomeCategoriesWidget extends GetView<HomeController> {
  const HomeCategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final language = Get.find<UserSharedPrefrenceController>().getLanguage;

    return Offstage(
      offstage: controller.categories.items?.isEmpty ?? true,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
            child: Row(
              children: [
                CustomText(
                  Translate.enjoyCategories.tr,
                  style: const TextStyle(
                    color: AppColors.redColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                // const Spacer(),
                // InkWell(
                //   onTap: () => controller.goToCategories(),
                //   child: RotatedBox(
                //     quarterTurns: (language == Languages.en.name) ? 0 : 2,
                //     child: SvgPicture.asset(
                //       'assets/images/right_arrow_home.svg',
                //       width: 20,
                //       height: 20,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsetsDirectional.only(start: 10),
            margin: const EdgeInsetsDirectional.only(bottom: 0),
            alignment: AlignmentDirectional.centerStart,
            child: SizedBox(
              height: 50,
              child: ListView.separated(
                itemCount: controller.categories.items?.length ?? 0,
                padding: const EdgeInsetsDirectional.only(end: 10),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final item = controller.categories.items?.elementAt(index);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CategoryWidget(
                      category: item,
                      index: index,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryWidget extends GetView<HomeController> {
  final int index;
  final ItemItem? category;
  const CategoryWidget({
    Key? key,
    this.category,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.goToListingWithId(
        filterModel: category?.filterModel ?? FilterModel(),
        name: category?.name ?? "",
      ),
      child: CustomText(
        category?.name ?? "",
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style:  TextStyle(
          color: CustomThemes.appTheme.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.0
        ),
      ),
      // Stack(
      //   children: [
      //     Container(
      //       color: index > 4
      //           ? CustomThemes.appTheme.primaryColor.withOpacity(.5)
      //           : controller.categoriesColors[index],
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           // Container(
      //           //   padding:
      //           //       const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      //           //   child: Image.network(
      //           //     category?.imageUrl ?? "",
      //           //     width: 50,
      //           //     height: 50,
      //           //   ),
      //           // ),
      //           Row(
      //             children: [
      //               Expanded(
      //                 child:
      //               ),
      //             ],
      //           )
      //         ],
      //       ).animate().fade(duration: 300.ms),
      //     )
      //   ],
      // ),
    );
  }
}
