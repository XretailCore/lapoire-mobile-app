import 'package:carousel_slider/carousel_controller.dart';
import 'package:extended_image/extended_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imtnan/core/components/custom_button.dart';
import 'package:imtnan/core/components/custom_slider.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/lanaguages_enum.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/theme.dart';
import '../controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/data/page_block/models/new_page_block_model.dart';

class HomeAdsWidget extends GetView<HomeController> {
  final List<ItemItem>? items;
  final CarouselController carouselController;

  const HomeAdsWidget({
    Key? key,
    this.items,
    required this.carouselController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final language = Get.find<UserSharedPrefrenceController>().getLanguage;

    return Offstage(
      offstage: items == null || items!.isEmpty,
      child: Padding(
        padding: (items?.length ?? 0) > 1
            ? const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5)
            : const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: Row(
          children: [
            if (items!.length > 1)
              InkWell(
                onTap: () {
                  carouselController.previousPage();
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: CustomThemes.appTheme.primaryColor,
                        shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        language == Languages.ar.name
                            ? FontAwesomeIcons.caretRight
                            : FontAwesomeIcons.caretLeft,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ),
            Expanded(
              child: CustomSlider(
                height: 180,
                viewportFraction: 1.0,
                controller: carouselController,
                showTitleAndButton: false,
                sliderImages: [
                  for (var item in items ?? [])
                    InkWell(
                      onTap: () => controller.goToListingWithId(
                        filterModel: item.filterModel ?? FilterModel(),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 200,
                              width: 200,
                              child: ExtendedImage.network(
                                item.imageUrl ?? "",
                                cacheHeight: 800,
                                enableMemoryCache: false,
                                fit: BoxFit.fitHeight,
                                filterQuality: FilterQuality.high,
                                clearMemoryCacheWhenDispose: true,
                                enableLoadState: false,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  item.name ?? "",
                                  style: const TextStyle(
                                      fontSize: 14, color: AppColors.redColor),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: 100,
                                  child: CustomBorderButton(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    title: Translate.shopNow.tr,
                                    fontSize: 12,
                                    textColor: AppColors.primaryColor,
                                    borderColor: AppColors.primaryColor,
                                    onTap: () {
                                      controller.goToListingWithId(
                                          filterModel: item.filterModel ??
                                              FilterModel());
                                    },
                                    radius: 30.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            if (items!.length > 1)
              InkWell(
                onTap: () {
                  carouselController.nextPage();
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: CustomThemes.appTheme.primaryColor,
                        shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        language == Languages.ar.name
                            ? FontAwesomeIcons.caretLeft
                            : FontAwesomeIcons.caretRight,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
