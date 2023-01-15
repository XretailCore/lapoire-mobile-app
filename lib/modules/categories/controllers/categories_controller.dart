import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/helper_functions.dart';
import 'package:linktsp_api/data/page_block/models/new_page_block_model.dart'
    hide Color;
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/routes.dart';
import '../../../core/utils/strings.dart';

class CategoriesController extends GetxController with StateMixin<List<Item>?> {
  final List<Color> categoriesColors = [
    const Color(0xffE99A3E),
    const Color(0xff5BB479),
    const Color(0xff9AC555),
    const Color(0xffD83935),
    const Color(0xffCB6BA4),
  ];
  @override
  void onReady() {
    super.onReady();
    init();
  }

  Future<void> init() async {
    final controller = Get.find<UserSharedPrefrenceController>();
    int? _customerId = controller.getUserId;
    await HelperFunctions.errorRequestsHandler<MenuModel>(
      loadingFunction: () async {
        change(null, status: RxStatus.loading());
        final categories = await LinkTspApi.instance.menu
            .getMenu(version: 3, customerID: _customerId);
        if ((categories.items ?? []).isEmpty) {
          change(categories.items, status: RxStatus.empty());
          return categories;
        }
        change(categories.items, status: RxStatus.success());
        return categories;
      },
      onDioErrorFunction: (e, m) async {
        change(null, status: RxStatus.error(m));
      },
      onUnexpectedErrorFunction: (e, m) async {
        change(null, status: RxStatus.error(m));
      },
      onApiErrorFunction: (e, m) async {
        change(null, status: RxStatus.error(e.message.toString()));
      },
    );
  }

  void goToListingWithId(
      {required String? categoryName, required FilterModel filterModel}) {
    Get.toNamed(Routes.listingItems, arguments: {
      Arguments.categoryAppBarTitle: categoryName ?? "",
      Arguments.categoryName: categoryName ?? "",
      Arguments.filterModel: filterModel,
    });
  }
}
