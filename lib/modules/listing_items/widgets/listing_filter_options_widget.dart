import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import 'package:linktsp_api/data/page_block/models/new_page_block_model.dart';
import '../../../core/components/custom_slider.dart';
import '../../../core/utils/theme.dart';
import '../../home/widgets/home_categories_widget.dart';
import '../controllers/listing_controller.dart';

class ListingFilterOptionwidget extends GetView<ListItemsController> {
  const ListingFilterOptionwidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  controller.categoriesScrollController.previousPage();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: CustomThemes.appTheme.primaryColor,
                      shape: BoxShape.circle),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      FontAwesomeIcons.caretLeft,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Obx(()=> CustomSlider(
                    showTitleAndButton: false,
                    showIndicator: false,
                    autoPlay: false,
                    viewportFraction: 0.4,
                    height: 30,
                    controller: controller.categoriesScrollController,
                    sliderImages: [
                      for (var item in controller.categoriesList)
                        Center(
                          child: CategoryWidget(
                            textStyle: TextStyle(
                                color: controller.categoryName.value.toLowerCase()==item.name!.toLowerCase()?AppColors.redColor:CustomThemes.appTheme.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0),

                            onTap: () async {
                              controller.categoryName.value= item.name!;
                              controller.filterModel = item.filterModel!;
                              await controller.getList(fromCategories: true);
                            },
                            category: ItemItem(
                              id: item.id,
                              name: item.name,
                              filterModel: item.filterModel,
                              listTypeId: item.listTypeID,
                              listTypeName: item.listTypeName,
                            ),
                            index: controller.categoriesList.indexOf(item),
                          ),
                        )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 5),
              InkWell(
                onTap: () {
                  controller.categoriesScrollController.nextPage();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: CustomThemes.appTheme.primaryColor,
                      shape: BoxShape.circle),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      FontAwesomeIcons.caretRight,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
