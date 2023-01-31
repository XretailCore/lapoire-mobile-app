import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imtnan/modules/home/widgets/home_ads_widget.dart';
import 'package:linktsp_api/data/page_block/models/new_page_block_model.dart'
    as model;
import '../../../core/components/custom_error_widget.dart';
import '../../../core/components/star_widget.dart';
import '../../../core/localization/translate.dart';
import '../../../core/shimmer_loader/home_shimmer.dart';
import '../../../core/shimmer_loader/images_shimmer.dart';
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
        //const HomeAppBarWidget(),
        Expanded(
          child: controller.obx(
            (data) {
              return Column(
                children: [
                  const SizedBox(height: 24.0),
                  Image.asset("assets/images/main_logo.png",
                      height: 60, width: 85),
                  DottedLine(dashColor: CustomThemes.appTheme.primaryColor),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: LocationWidget(
                          pageName: MapPages.homeScreen.name,
                        ),
                      ),
                      Row(
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
                                color: CustomThemes.appTheme.primaryColor),
                          ),
                          InkWell(
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
                          // const SizedBox(height: 15),
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
                          const SizedBox(height: 16),

                          CachedNetworkImage(
                            imageUrl:
                                controller.firstAd.items?[0].imageUrl ?? "",
                            imageBuilder: (context, imageProvider) => Container(
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    controller.firstAd.items?[0].imageUrl ?? "",
                                  ),
                                ),
                              ),
                            ),
                            placeholder: (context, image) =>
                                const ImagesShimmerLoader(
                              width: double.infinity,
                              height: 200,
                            ),
                          ),
                          const SizedBox(height: 16),
                          HomeAdsWidget(items: controller.firstAd.items),
                          const SizedBox(height: 16),
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
                          const SizedBox(height: 10),
                          HomeAdsWidget(items: controller.secondAd.items),
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
            onLoading: const HomeShimmerLoader(),
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
