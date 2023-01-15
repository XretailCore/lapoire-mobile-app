import 'package:imtnan/core/components/imtnan_loading_widget.dart';

import '../../../core/utils/theme.dart';
import '../widgets/listing_grid_widget.dart';
import '../../../core/components/custom_appbar.dart';
import '../widgets/listing_filter_options_widget.dart';
import 'filter_screen.dart';
import '../../../core/components/custom_empty_widget.dart';
import '../../../core/components/custom_error_widget.dart';
import '../../../core/localization/translate.dart';
import '../controllers/listing_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListItemsScreen extends GetView<ListItemsController> {
  ListItemsScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawerEnableOpenDragGesture: false,
      endDrawer: const FilterScreen(),
      floatingActionButton: controller.filterModel.listType != null
          ? FloatingActionButton(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: const Icon(
                Icons.filter_alt,
                size: 30,
              ),
              backgroundColor: CustomThemes.appTheme.primaryColor,
              onPressed: () {
                controller.goToFilter(scaffoldKey: scaffoldKey);
              },
            )
          : Container(),
      appBar:
          CustomAppBar(title: controller.categoryName ?? "", showSearch: true),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Expanded(
                      child: controller.obx(
                        (data) => Column(
                          children: [
                            const ListingFilterOptionwidget(),
                            ListingGridWidget(length: data?.length ?? 0),
                          ],
                        ),
                        onError: (e) => CustomErrorWidget(
                          errorText: e,
                          onReload: controller.onInit,
                        ),
                        onEmpty: Center(
                          child: CustomEmptyWidget(
                            emptyLabel: Translate.noItems.tr,
                            buttonLabel: Translate.continueShopping.tr,
                            emptyBtnAction: () =>
                                controller.continueShoppingAction(),
                          ),
                        ),
                        onLoading: const CustomLoadingWidget(),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
