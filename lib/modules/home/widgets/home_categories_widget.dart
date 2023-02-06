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
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    Translate.enjoyCategories.tr,
                    style: const TextStyle(
                        color: AppColors.redColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 32,
                        fontFamily: "Bayshore"),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      controller.categoriesScrollController.previousPage();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: CustomThemes.appTheme.primaryColor,
                          shape: BoxShape.circle),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          FontAwesomeIcons.caretLeft,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: CustomSlider(
                      showTitleAndButton: false,
                      showIndicator: false,
                      autoPlay: false,
                      viewportFraction: 0.4,
                      height: 30,
                      controller: controller.categoriesScrollController,
                      sliderImages: [
                        for (var item in controller.categories.items!)
                          Center(
                            child: CategoryWidget(
                              category: item,
                              index: controller.categories.items!.indexOf(item),
                            ),
                          )
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      controller.categoriesScrollController.nextPage();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: CustomThemes.appTheme.primaryColor,
                          shape: BoxShape.circle),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          FontAwesomeIcons.caretRight,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
  final void Function()? onTap;

  const CategoryWidget({
    Key? key,
    this.onTap,
    this.category,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      onTap: onTap ??
          () => controller.goToListingWithId(
                filterModel: category?.filterModel ?? FilterModel(),
                name: category?.name ?? "",
              ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
      ),
    );
  }
}
