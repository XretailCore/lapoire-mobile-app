import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:linktsp_api/data/list/models/new_list_model.dart' as new_model;

import '../../../core/components/custom_loaders.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/routes.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../../settings/controller/language_controller.dart';

class SearchController extends GetxController
    with StateMixin<new_model.NewListingDataModel> {
  TextEditingController searchController = TextEditingController();
  final refreshController = RefreshController(initialRefresh: false);
  new_model.NewListingDataModel searchProducts =
      new_model.NewListingDataModel();
  RxList<new_model.ListingItem> searchList = <new_model.ListingItem>[].obs;
  RxInt pageIndex = 1.obs;

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.empty());
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

  Future<void> getListWithSearch(
      {bool showLoader = false, bool isRefresh = false}) async {
    final userSharedPrefrenceController =
        Get.find<UserSharedPrefrenceController>();
    final LanguageController languageController =
        Get.find<LanguageController>();
    final languageId = languageController.getLanguageIdByName();
    try {
      if (searchController.text.trim().isNotEmpty) {
        FocusScope.of(Get.context!).unfocus();
        showLoader
            ? change(null, status: RxStatus.loading())
            : change(null, status: RxStatus.success());
        searchProducts = await LinkTspApi.instance.list.getListingWithCategory(
          listModel: ListModel(
            keyword: searchController.text.trim(),
            pageIndex: pageIndex.value,
            languageId: languageId,
            zoneId: userSharedPrefrenceController.getCurrentZone?.id,
          ),
          version: 3,
        );
        pageIndex.value++;
        if (searchProducts.items!.isNotEmpty) {
          isRefresh ? searchList.clear() : null;
          for (int i = 0; i < searchProducts.items!.length; i++) {
            searchList.add(searchProducts.items![i]);
          }
          change(searchProducts, status: RxStatus.success());
        } else {
          change(searchProducts, status: RxStatus.empty());
        }
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> onRefresh({bool showLoader = false}) async {
    change(null, status: RxStatus.empty());
    pageIndex.value = 1;
    getListWithSearch(isRefresh: true, showLoader: showLoader);
    refreshController.refreshCompleted();
  }

  Future<void> onClearSearchText() async {
    if (searchController.text.trim().isNotEmpty) {
      pageIndex.value = 1;
      searchController.clear();
      searchProducts.items?.clear();
      change(null, status: RxStatus.empty());
    }
  }

  Future onLoadItems() async {
    openLoadingDialog(Get.context!);
    await getListWithSearch();
    Get.back();
    refreshController.loadComplete();
  }

  void continueShoppingAction() {
    final dashboardController = Get.find<DashboardController>();
    dashboardController.updateIndex(2);
    Get.offAllNamed(Routes.dashboard);
  }

  @override
  void onClose() {
    refreshController.dispose();
    searchController.dispose();
    super.onClose();
  }
}
