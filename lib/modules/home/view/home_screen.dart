import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/components/imtnan_loading_widget.dart';
import 'package:imtnan/modules/home/widgets/home_ads_widget.dart';
import 'package:imtnan/modules/home/widgets/language_widget.dart';
import 'package:linktsp_api/data/page_block/models/new_page_block_model.dart'
    as model;
import '../../../core/components/custom_error_widget.dart';
import '../../../core/localization/translate.dart';
import '../controllers/home_controller.dart';
import '../widgets/home_categories_widget.dart';
import '../widgets/home_listing_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/components/location_widget.dart';
import '../../../core/utils/enums.dart';
import '../../../core/utils/routes.dart';
import '../../../core/utils/theme.dart';
import '../widgets/home_slider_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: 'splash logo tag',
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
            child: Image.asset("assets/images/main_logo.png",
                height: 40, width: 85),
          ),
        ),
        Expanded(
          child: controller.obx(
            (data) {
              return Column(
                children: [
                  DottedLine(dashColor: CustomThemes.appTheme.primaryColor),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 8.0),
                      Expanded(
                        child:
                            LocationWidget(pageName: MapPages.homeScreen.name),
                      ),
                      Row(
                        children: [
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                builder: (BuildContext context) {
                                  return const LanguageWidget();
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.language,
                                  size: 20,
                                  color: CustomThemes.appTheme.primaryColor,
                                ),
                                const SizedBox(width: 8.0),
                                CustomText(
                                  Translate.language.tr,
                                  style: TextStyle(
                                      color:
                                          CustomThemes.appTheme.primaryColor),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              Get.toNamed(Routes.search);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Icon(
                                Icons.search,
                                size: 25,
                                color: CustomThemes.appTheme.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          HomeAd(items: controller.homeTopBanner.items ?? []),
                          const HomeCategoriesWidget(),
                          const SizedBox(height: 10),
                          HomeListingWidget(
                            onAllProductsPressed: () =>
                                controller.goToListingWithId(
                                    filterModel: model.FilterModel(listType: 5),
                                    name: Translate.bestSeller.tr),
                            key: UniqueKey(),
                            items: controller.bestSellers.items ?? [],
                            title: Translate.bestSeller.tr,
                          ),
                          ExtendedImage.network(
                            controller.firstAd.items?[0].imageUrl ?? "",
                            cacheHeight: 800,
                            height: .5.sw,
                            width: double.infinity,
                            enableMemoryCache: false,
                            fit: BoxFit.fitWidth,
                            filterQuality: FilterQuality.high,
                            clearMemoryCacheWhenDispose: true,
                            enableLoadState: false,
                          ),
                          const SizedBox(height: 16),
                          HomeAdsWidget(
                            items: controller.secondAd.items,
                            carouselController: controller.carouselController,
                          ),
                          const SizedBox(height: 14),
                          HomeListingWidget(
                            onAllProductsPressed: () =>
                                controller.goToListingWithId(
                                    filterModel: model.FilterModel(listType: 4),
                                    name: Translate.newArrivals.tr),
                            isYellow: true,
                            key: UniqueKey(),
                            items: controller.newArrivals.items ?? [],
                            title: Translate.newArrivals.tr,
                          ),
                          const SizedBox(height: 14),
                          HomeAdsWidget(
                            items: controller.thirdAd.items,
                            carouselController:
                                controller.secondScrollController,
                          ),
                          const SizedBox(height: 16),
                          HomeListingWidget(
                            onAllProductsPressed: () =>
                                controller.goToListingWithId(
                                    filterModel: model.FilterModel(listType: 6),
                                    name: Translate.offers.tr),
                            key: UniqueKey(),
                            items: controller.offers.items ?? [],
                            title: Translate.offers.tr,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            onLoading: const CustomLoadingWidget(),
            onError: (e) => CustomErrorWidget(
              errorText: e,
              onReload: controller.init,
            ),
          ),
        ),
      ],
    );
  }
}
