import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imtnan/core/components/custom_button.dart';
import '../../../core/components/custom_slider.dart';
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

class HomeAd extends GetView<HomeController> {
  final List<ItemItem> items;

  const HomeAd({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final language = Get.find<UserSharedPrefrenceController>().getLanguage;
    final List<Widget> sliderImages = items.isEmpty
        ? []
        : List.generate(
            items.length,
            (index) => SizedBox(
              height: 0.65.sh,
              width: double.infinity,
              child: Stack(
                children: [
                  InkWell(
                    highlightColor: Colors.transparent,
                    onTap: () => controller.goToListingWithId(
                      filterModel: items[index].filterModel ?? FilterModel(),
                      name: items[index].name ?? "",
                    ),
                    //Todo : change static image below
                    child: ExtendedImage.asset(
                      "assets/images/home_b3.png",
                      //cacheHeight: 800,
                      enableMemoryCache: false,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      clearMemoryCacheWhenDispose: true,
                      enableLoadState: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 150),
                    child: Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: CustomText(
                        items[index].description,
                        softWrap: true,
                        forceStrutHeight: false,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: language == Languages.ar.name
                                ? 'Cairo'
                                : "Bayshore",
                            fontSize: 36),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 35,
                    right: 0,
                    left: 0,
                    child: Center(
                      child: SizedBox(
                        width: 150.0,
                        child: CustomBorderButton(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 16),
                          title: Translate.orderNow.tr,
                          color: Colors.white,
                          radius: 30.0,
                          fontSize: 14.0,
                          textColor: AppColors.primaryColor,
                          onTap: () => controller.goToListingWithId(
                            filterModel:
                                items[index].filterModel ?? FilterModel(),
                            name: items[index].name ?? "",
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
    return Offstage(
      offstage: items.isEmpty,
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () => SizedBox(
                height: 0.65.sh,
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  elevation: 3,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0))),
                  child: CustomSlider(
                    viewportFraction: 1,
                    ratio: 1,
                    height: .65.sh,
                    sliderImages: sliderImages,
                    controller: controller.carouselController,
                    showIndicator: true,
                    onPageChanged:
                        (int index, CarouselPageChangedReason reason) =>
                            controller.onSliderPageChange(index),
                    pageIndex: controller.sliderPageIndex.value,
                    indicatorColor: CustomThemes.appTheme.primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
