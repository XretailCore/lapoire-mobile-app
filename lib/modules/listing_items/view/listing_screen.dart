import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imtnan/core/components/custom_text.dart';
import 'package:imtnan/core/components/imtnan_loading_widget.dart';
import 'package:imtnan/modules/listing_items/view/filter_screen.dart';
import 'package:imtnan/modules/listing_items/widgets/sort_widget.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/theme.dart';
import '../widgets/listing_grid_widget.dart';
import '../../../core/components/custom_appbar.dart';
import '../widgets/listing_filter_options_widget.dart';
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
    return Obx(
      () => (Scaffold(
        key: scaffoldKey,
        endDrawerEnableOpenDragGesture: false,
        endDrawer: const FilterScreen(),
        appBar: CustomAppBar(
            title: controller.categoryName.value,
            showSearch: true,
            showBackButton: true),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(height: 8.0),
                      Expanded(
                        child: controller.obx(
                          (data) => Column(
                            children: [
                              const ListingFilterOptionwidget(),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Spacer(),
                                    controller.filterModel.listType != null
                                        ? InkWell(
                                            onTap: () {
                                              controller.goToFilter(
                                                  scaffoldKey: scaffoldKey);
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 8),
                                              decoration: BoxDecoration(
                                                  color: CustomThemes
                                                      .appTheme.primaryColor,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(30))),
                                              child: Row(
                                                children: [
                                                  CustomText(
                                                    Translate.filter.tr,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const FaIcon(
                                                    FontAwesomeIcons.caretDown,
                                                    color: Colors.white,
                                                    size: 12,
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const SortWidget(),
                                  ],
                                ),
                              ),
                              const Divider(
                                  thickness: 1.0, color: AppColors.redColor),
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
      )),
    );
  }
}
