import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imtnan/modules/home/widgets/home_ads_widget.dart';
import 'package:linktsp_api/data/page_block/models/new_page_block_model.dart';
import '../../../core/components/custom_error_widget.dart';
import '../../../core/localization/translate.dart';
import '../../../core/shimmer_loader/home_shimmer.dart';
import '../controllers/home_controller.dart';
import '../widgets/home_categories_widget.dart';
import '../widgets/home_listing_widget.dart';
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
              (data) => SingleChildScrollView(
                child: Column(
                  children: [
                    HomeAd(items: controller.homeTopBanner.items ?? []),
                    const SizedBox(height: 15),
                    const HomeCategoriesWidget(),
                    const SizedBox(height: 10),
                    HomeListingWidget(
                      onAllProductsPressed: (){},
                      key: UniqueKey(),
                      items: controller.bestSellers.items ?? [],
                      title: Translate.bestSeller.tr,
                      onViewAll: () => controller.goToListingWithId(
                        filterModel:
                            controller.bestSellers.items?.first.filterModel ??
                                FilterModel(),
                        name: controller.bestSellers.items?.first.name ?? "",
                      ),
                    ),
                    HomeAdsWidget(items: controller.firstAd.items),
                    HomeListingWidget(
                      onAllProductsPressed: (){},
                      isYellow: true,
                      key: UniqueKey(),
                      items: controller.newArrivals.items ?? [],
                      title: Translate.newArrivals.tr,
                      onViewAll: () => controller.goToListingWithId(
                        filterModel:
                            controller.newArrivals.items?.first.filterModel ??
                                FilterModel(),
                        name: controller.newArrivals.items?.first.name ?? "",
                      ),
                    ),
                    const SizedBox(height: 10),
                    HomeAdsWidget(items: controller.secondAd.items),
                    HomeListingWidget(
                      onAllProductsPressed: (){},
                      key: UniqueKey(),
                      items: controller.offers.items ?? [],
                      title: Translate.offers.tr,
                      onViewAll: () => controller.goToListingWithId(
                        filterModel:
                            controller.offers.items?.first.filterModel ??
                                FilterModel(),
                        name: controller.offers.items?.first.name ?? "",
                      ),
                    ),
                  ],
                ),
              ),
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
