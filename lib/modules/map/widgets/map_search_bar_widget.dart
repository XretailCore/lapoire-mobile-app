import '../../../core/components/custom_text.dart';
import '../../../core/components/custom_text_field.dart';
import '../controllers/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MapSearchBarWidget extends GetView<MapController> {
  const MapSearchBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(mainAxisSize: MainAxisSize.min, children: [
        Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                  controller.searchTextFilledController.text.trim().isEmpty
                      ? 10
                      : 0),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                InkWell(
                  child: const Icon(Icons.arrow_back_ios),
                  onTap: () => Get.back(),
                ),
                Expanded(
                  child: CustomTextField(
                    controller: controller.searchTextFilledController,
                    labelText: 'Search Here...',
                    validator: (val) {
                      return null;
                    },
                    onChanged: (String? value) =>
                        controller.searchInZones(value),
                  ),
                )
              ],
            ),
          ),
        ),
        Offstage(
          offstage: controller.searchTextFilledController.text.trim().isEmpty,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.searchZoneMenu.length,
              itemBuilder: (context, index) => Container(
                padding: const EdgeInsets.only(bottom: 5),
                child: InkWell(
                  onTap: () => controller.getSearchResultLocation(
                      context, controller.searchZoneMenu[index].id!),
                  child: Row(
                    children: [
                      CustomText(
                        controller.zoneMenu[index].name,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
