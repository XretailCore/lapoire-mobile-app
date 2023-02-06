import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/data/list/models/new_list_model.dart' as new_model;
import 'package:linktsp_api/data/list/models/new_list_model.dart';
import 'package:linktsp_api/data/page_block/models/new_page_block_model.dart';
import 'package:linktsp_api/linktsp_api.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/components/custom_loaders.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/routes.dart';
import '../../../core/utils/strings.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../../settings/controller/language_controller.dart';
import 'filter_controller.dart';

class ListItemsController extends GetxController
    with StateMixin<NewListingDataModel> {
  final refreshController = RefreshController(initialRefresh: false);
  final searchController = TextEditingController(text: '');
  final CarouselController categoriesScrollController = CarouselController();
  RxString categoryName="".obs;
  final products = <new_model.ListingItem>[];
  int pageIndex = 1;
  FilterModel filterModel = FilterModel();
  NewListingDataModel listingDataModel = NewListingDataModel();
  List<Item> categoriesList = [];

  @override
  void onInit() {
    super.onInit();
    final arguments = (Get.arguments ?? {}) as Map;
    filterModel = (arguments[Arguments.filterModel] ?? FilterModel());
    categoryName.value = (arguments[Arguments.categoryAppBarTitle] ?? "");
    if (filterModel.listType == null) {
      change(null, status: RxStatus.empty());
    } else {
      _getfilterOptions();
      getList();
    }
  }

  Future<void> _getfilterOptions() async {
    final filterController = Get.find<FilterController>();

    await filterController.getFilterOptions(filterModel);
  }

  Future<void> getList(
      {bool isRefresh = false,
      bool showLoader = false,
      bool fromCategories = false}) async {
    final _languageController = Get.find<LanguageController>();
    final languageId = _languageController.getLanguageIdByName();
    if (showLoader) change(null, status: RxStatus.loading());
    try {
      if(fromCategories) openLoadingDialog(Get.context!);
      final filterController = Get.find<FilterController>();
      final userSharedPrefrenceController =
          Get.find<UserSharedPrefrenceController>();
      final categories = await LinkTspApi.instance.menu.getMenu(
          version: 3, customerID: userSharedPrefrenceController.getUserId);
      categoriesList = categories.items ?? [];
      if (fromCategories) {
        pageIndex = 1;
        products.clear();
      }
      listingDataModel = await LinkTspApi.instance.list.getListingWithCategory(
        version: 3,
        listModel: ListModel(
          listType: filterModel.listType.toString(),
          listTypeId:
              filterModel.listType == null || filterModel.listTypeId == null
                  ? null
                  : filterModel.listTypeId!,
          languageId: languageId,
          pageIndex: pageIndex,
          rowCount: 30,
          keyword: searchController.text.trim().isEmpty
              ? null
              : searchController.text.trim(),
          minPrice:
              int.parse(filterController.minPriceController.value.text) == 0 || fromCategories
                  ? null
                  : int.parse(filterController.minPriceController.value.text),
          maxPrice:
              int.tryParse(filterController.maxPriceController.value.text) == 0 || fromCategories
                  ? null
                  : int.tryParse(
                      filterController.maxPriceController.value.text),
          categoryIDs: filterController.allSelectedCategories,
          sortProp: filterController.sortProp.value == ""
              ? null
              : filterController.sortProp.value,
          sizeIDs: filterController.sizesIds,
          zoneId: userSharedPrefrenceController.getCurrentZone?.id,
          sortBy: filterController.sortProp.value,
          customerId: userSharedPrefrenceController.getUserId,
        ),
      );
      pageIndex++;
      isRefresh ? products.clear() : null;
      products.addAll(listingDataModel.items!);
      if (products.isNotEmpty) {
        change(listingDataModel, status: RxStatus.success());
        if(fromCategories)Get.back();
      } else {
        change(listingDataModel, status: RxStatus.empty());
        if(fromCategories)Get.back();
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> onRefresh({
    bool showLoader = false,
  }) async {
    pageIndex = 1;
    await getList(isRefresh: true, showLoader: showLoader);
    refreshController.refreshCompleted();
  }

  Future<void> onLoadItems() async {
    if (products.length != listingDataModel.length) {
      openLoadingDialog(Get.context!);
      await getList();
      Get.back();
      refreshController.loadComplete();
    }
  }

  void goToFilter({required GlobalKey<ScaffoldState> scaffoldKey}) {
    scaffoldKey.currentState?.openEndDrawer();
  }

  Future<void> onAddTocard(
      {required bool isPreOrder,
      required BuildContext context,
      required double price,
      required int skuId}) async {
    final cartController = Get.find<CartController>();
    return await cartController.onTapAddToCard(
        price: price,
        context: context,
        skuId: skuId,
        quantity: 1,
        isPreOrder: isPreOrder);
  }

  void continueShoppingAction() {
    final dashboardController = Get.find<DashboardController>();
    dashboardController.updateIndex(0);
    Get.offAllNamed(Routes.dashboard);
  }

  Future<void> onCategoryTap(FilterModel filterModel) async {
    this.filterModel = filterModel;
    await onRefresh(showLoader: true);
  }

  @override
  void onClose() {
    refreshController.dispose();
    searchController.dispose();
    super.onClose();
  }
}
