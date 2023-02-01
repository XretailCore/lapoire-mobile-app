import 'package:carousel_slider/carousel_slider.dart';
import 'package:cowpay/core/helpers/screen_size.dart';
import 'package:extended_image/extended_image.dart';
import '../../../core/components/custom_slider.dart';
import '../../../core/components/custom_text.dart';
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
    final List<Widget> sliderImages = items.isEmpty
        ? []
        : List.generate(
            items.length,
            (index) => SizedBox(
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
                      "assets/images/home_b1.png",
                      //cacheHeight: 800,
                      enableMemoryCache: false,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      clearMemoryCacheWhenDispose: true,
                      enableLoadState: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 150),
                    child: Align(
                      alignment:
                          AlignmentDirectional.bottomCenter, // <-- SEE HERE
                      child: CustomText(
                        items[index].description,
                        softWrap: true,
                        forceStrutHeight: false,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "Bayshore",
                            fontSize: 36),
                      ),
                    ),
                  ),
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
                height: 0.71.sh,
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  elevation: 3,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0))),
                  child: CustomSlider(
                    viewportFraction: 1,
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
