import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/components/imtnan_loading_widget.dart';
import 'package:linktsp_api/data/page_block/models/new_page_block_model.dart';

import '../../../core/components/custom_error_widget.dart';
import '../controllers/categories_controller.dart';
import '../widgets/categories_widget.dart';

class CategoriesScreen extends GetView<CategoriesController> {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Expanded(
            child: controller.obx(
              (categories) => SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: categories?.length,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      final category = categories?[index];
                      return CategoriesWidgets(
                        image: category?.imgUrl ?? "",
                        index: index,
                        title: category?.name ?? "",
                        onTap: () => controller.goToListingWithId(
                          categoryName: category?.name,
                          filterModel: category?.filterModel ?? FilterModel(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              onLoading: const CustomLoadingWidget(),
              onError: (e) => CustomErrorWidget(
                errorText: e,
                onReload: controller.init,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
