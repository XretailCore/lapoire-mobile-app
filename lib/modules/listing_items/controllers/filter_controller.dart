import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/data/page_block/models/new_page_block_model.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/localization/translate.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/helper_functions.dart';
import '../../settings/controller/language_controller.dart';
import '../models/categories_model.dart';
import 'listing_controller.dart';

class FilterController extends GetxController with StateMixin<FilterDataModel> {
  final pageIndex = 1.obs;
  final categories = <CategoriesFilterModel>[].obs;
  Rx<TextEditingController> minPriceController=TextEditingController(text: "00").obs;
  Rx<TextEditingController> maxPriceController=TextEditingController(text: "00").obs;
  final subCategories = <CategoriesFilterModel>[].obs;
  final selectedCategories = <int>[].obs,
      selectedsubCategoriesIds = <int>[].obs,
      allSelectedCategories = <int>[].obs,
      sizesIds = <int>[].obs;
  final sizes = <BreadCrumb>[].obs;
  final selectedSorts = <String>[].obs;
  final sortProp = "".obs;
  var filterParameters = FilterDataModel();
  final sortList = [
    {"title": Translate.priceLowToHigh.tr, "subTitle": "lowestprice"},
    {"title": Translate.priceHighToLow.tr, "subTitle": "heighestprice"},
    {"title": Translate.bestSellers.tr, "subTitle": "bestseller"},
    {"title": Translate.newArrivals.tr, "subTitle": "newarrivals"},
    {"title": Translate.productNameAZ.tr, "subTitle": "alphaasc"},
    {"title": Translate.productNameZA.tr, "subTitle": "alphadesc"},
  ];

  void closeFilter() {
    selectedCategories.clear();
    Get.back();
  }

  Future<void> getFilterOptions(FilterModel filterModel) async {
    change(null, status: RxStatus.loading());
    final LanguageController _languageController =
        Get.find<LanguageController>();
    final languageId = _languageController.getLanguageIdByName();
    try {
      final _prefs = Get.find<UserSharedPrefrenceController>();
      filterParameters = await LinkTspApi.instance.list.getFilterOptionsData(
        version: 3,
        listModel: ListModel(
          languageId: languageId,
          listType: filterModel.listType.toString(),
          listTypeId:
              filterModel.listType == null || filterModel.listTypeId == null
                  ? null
                  : filterModel.listTypeId!,
          zoneId: _prefs.getCurrentZone?.id,
        ),
      );
      minPriceController.value.text=filterParameters.priceRange!.minPrice!.toInt().toString();
      maxPriceController.value.text=filterParameters.priceRange!.maxPrice!.toInt().toString();
      _getSubCategories();
      sizes.value = filterParameters.sizes ?? <BreadCrumb>[];
      change(filterParameters, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error());
    }
  }

  void _getSubCategories() {
    for (int i = 0; i < filterParameters.categories!.length; i++) {
      categories.add(
        CategoriesFilterModel(
          id: filterParameters.categories![i].id,
          title: filterParameters.categories![i].title,
          children: filterParameters.categories![i].children,
        ),
      );
      for (int x = 0; x < categories[i].children!.length; x++) {
        subCategories.add(
          CategoriesFilterModel(
            id: categories[i].children![x].id,
            title: categories[i].children![x].title,
            children: categories[i].children![x].children,
          ),
        );
      }
    }
  }

  void checkCategory({required int index, required int categoryId}) {
    if (selectedCategories.contains(categoryId)) {
      selectedCategories.remove(categoryId);
    } else {
      selectedCategories.add(categoryId);
    }
  }

  void checkSubCategory({
    required int subCategoryId,
    required String subCategoryName,
  }) {
    selectedsubCategoriesIds.contains(subCategoryId)
        ? selectedsubCategoriesIds.remove(subCategoryId)
        : selectedsubCategoriesIds.add(subCategoryId);
  }

  void applyFilterOnsubCategory({
    required int subCategoryId,
    required String subCategoryName,
    required BuildContext context,
  }) {
    selectedsubCategoriesIds.contains(subCategoryId)
        ? selectedsubCategoriesIds.remove(subCategoryId)
        : selectedsubCategoriesIds.add(subCategoryId);
    applyFilter(context: context, closeSideMenu: false);
  }

  void checkSize(int id) {
    sizesIds.contains(id) ? sizesIds.remove(id) : sizesIds.add(id);
  }

  void checkSort({required String title, required String sortProp}) {
    if (!selectedSorts.contains(sortProp)) {
      selectedSorts.clear();
      selectedSorts.add(title);
      this.sortProp.value = sortProp;
    }
  }

  bool _isFilterApplied({bool isSideMenu = true}) {
    if ((selectedsubCategoriesIds.isEmpty && isSideMenu) &&
        sizesIds.isEmpty &&
        selectedCategories.isEmpty &&
        int.parse(minPriceController.value.text) == filterParameters.priceRange!.minPrice!.toInt() &&
        int.parse(maxPriceController.value.text) == filterParameters.priceRange!.maxPrice!.toInt() &&
        sortProp.value == "") {
      return false;
    } else {
      return true;
    }
  }

  void clearFilter({bool getBack=true}) {
    selectedsubCategoriesIds.clear();
    allSelectedCategories.clear();
    selectedCategories.clear();
    sizesIds.clear();
    selectedSorts.clear();

    sortProp.value = "";
    minPriceController.value.text = filterParameters.priceRange?.minPrice!.toInt().toString() ?? 0.toString();
    maxPriceController.value.text = filterParameters.priceRange?.maxPrice!.toInt().toString() ?? 0.toString();
    if(getBack)
      {
        final listingController = Get.find<ListItemsController>();
        listingController.onRefresh(showLoader: true);
        Get.back();
      }
  }

  void applyFilter({required BuildContext context, bool closeSideMenu = true}) {
    if (!_isFilterApplied(isSideMenu: closeSideMenu)) {
      //if (closeSideMenu) Get.back();
      ScaffoldMessenger.of(context).showSnackBar(
        HelperFunctions.customSnackBar(
          message: Translate.pleaseChooseFilterCriteria.tr,
          snackBarBehavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ),
      );
    } else {
      //if (closeSideMenu) Get.back();
      allSelectedCategories.clear();
      allSelectedCategories.addAll(selectedCategories);
      allSelectedCategories.addAll(selectedsubCategoriesIds);
      final listingController = Get.find<ListItemsController>();
      listingController.onRefresh(showLoader: true);
    }
  }

  @override
  void onClose() {
    minPriceController.close();
    maxPriceController.close();
    pageIndex.close();
    categories.close();
    subCategories.close();
    selectedCategories.close();
    selectedsubCategoriesIds.close();
    allSelectedCategories.close();
    sizesIds.close();
    sizes.close();
    selectedSorts.close();
    sortProp.close();
    super.onClose();
  }
}
