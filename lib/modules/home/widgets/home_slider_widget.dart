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
                    onTap: () => controller.goToListingWithId(
                      filterModel: items[index].filterModel ?? FilterModel(),
                      name: items[index].name ?? "",
                    ),
                    child: ExtendedImage.network(
                      items[index].imageUrl ?? "",
                      //cacheHeight: 800,
                      enableMemoryCache: false,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      clearMemoryCacheWhenDispose: true,
                      enableLoadState: false,
                    ),
                  ),
                  Center(
                    child: CustomText(
                      items[index].description,
                      style: const TextStyle(
                        color: Colors.white,
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
                height: 0.7.sh,
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  elevation: 3,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0))),
                  child: CustomSlider(
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
