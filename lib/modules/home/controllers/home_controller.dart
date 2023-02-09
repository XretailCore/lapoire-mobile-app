import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/data/page_block/models/new_page_block_model.dart'
    hide Color;
import 'package:linktsp_api/linktsp_api.dart' hide ItemItem;
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/routes.dart';
import '../../../core/utils/strings.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../dashboard/controller/dashboard_controller.dart';

class HomeController extends GetxController with StateMixin {
  final CarouselController carouselController = CarouselController();
  final refreshController = RefreshController(initialRefresh: false);
  final CarouselController scrollController = CarouselController();
  final CarouselController categoriesScrollController = CarouselController();
  ItemItem productItem = ItemItem();

  final RxBool? hideButtons = false.obs;
  NewPageBlockModel? homeModel;
  final sliderPageIndex = 0.obs;
  var homeTopBanner = DataItem(),
      categories = DataItem(),
      bestSellers = DataItem(),
      newArrivals = DataItem(),
      offers = DataItem(),
      firstAd = DataItem(),
      secondAd = DataItem(),
      thirdAd = DataItem(),
      fourthAd = DataItem();

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    getPageBlock();
    _getCartCounter();
  }

  Future<void> _getCartCounter() async {
    final cartcontroller = Get.find<CartController>();
    cartcontroller.getCart();
  }

  Future<void> getPageBlock({bool hideLoader = false}) async {
    int? userId = Get.find<UserSharedPrefrenceController>().getUserId;
    if (!hideLoader) change(null, status: RxStatus.loading());
    try {
      homeModel = await LinkTspApi.instance.pageBlock
          .getNewPageBlock(customerId: userId, version: 3);
      _getPageBlockItems(homeModel);
      change(null, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error());
    }
  }

  void _getPageBlockItems(NewPageBlockModel? homeModel) {
    homeTopBanner = _getItem("top banner");
    categories = _getItem("Category banner");
    bestSellers = _getItem("best seller");
    newArrivals = _getItem('new arrival');
    offers = _getItem('offers');
    firstAd = _getItem("Poster 1");
    secondAd = _getItem("Poster 2");
  }

  DataItem _getItem(String pageblockName) {
    return homeModel?.items!.firstWhereOrNull((item) =>
            item.name?.toLowerCase() == pageblockName.toLowerCase()) ??
        DataItem();
  }

  void onSliderPageChange(int pageIndex) {
    sliderPageIndex.value = pageIndex;
    // update();
  }

  void goToListingWithId({required FilterModel filterModel, String? name}) {
    Get.toNamed(Routes.listingItems, arguments: {
      Arguments.filterModel: filterModel,
      Arguments.categoryAppBarTitle: name,
      Arguments.categoryName: name ?? "",
    });
  }

  void goToCategories() {
    var dashboardController = Get.find<DashboardController>();
    dashboardController.updateIndex(1);
  }

  void goToSearch() {
    Get.toNamed(
      Routes.listingItems,
    );
  }

  Future<void> goToCart() async {
    final cartcontroller = Get.find<CartController>();
    await cartcontroller.getCart();
    Get.toNamed(Routes.cart);
  }

  Future<void> onTapAddToCard({
    required BuildContext context,
    required int skuId,
    required int quantity,
    required double price,
    required bool isPreOrder,
  }) async {
    final cartController = Get.find<CartController>();
    await cartController.onTapAddToCard(
        isPreOrder: isPreOrder,
        context: context,
        price: price,
        skuId: skuId,
        quantity: quantity);
  }
}
