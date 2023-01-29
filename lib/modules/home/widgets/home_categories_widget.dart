import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import '../../../core/components/custom_slider.dart';
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
      child: SizedBox(
        height: 100.0,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    Translate.enjoyCategories.tr,
                    style: const TextStyle(
                      color: AppColors.redColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 32,
                        fontFamily: "Bayshore"
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    controller.categoriesScrollController.previousPage();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: CustomThemes.appTheme.primaryColor,
                        shape: BoxShape.circle),
                    child: const Icon(
                      FontAwesomeIcons.caretLeft,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CustomSlider(
                    showTitleAndButton: false,
                    showIndicator: false,
                    autoPlay: false,
                    viewportFraction:0.4,
                    ratio: 0.4,
                    controller: controller.categoriesScrollController,
                    sliderImages: [
                      for (var item in controller.categories.items!)
                        CategoryWidget(
                          category: item,
                          index: controller.categories.items!.indexOf(item),
                        )
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    controller.categoriesScrollController.nextPage();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: CustomThemes.appTheme.primaryColor,
                        shape: BoxShape.circle),
                    child: const Icon(
                      FontAwesomeIcons.caretRight,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
        textAlign: TextAlign.start,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: CustomThemes.appTheme.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 12.0),
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
