import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/helper_functions.dart';
import '../controllers/address_details_controller.dart';

class ZoneWidget extends GetView<AddressDetailsController> {
  const ZoneWidget({Key? key, required this.cities}) : super(key: key);
  final List<CityModel> cities;
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Obx(
      () => DropdownSearch<CityModel>(
        itemAsString: (item) {
          return item?.name ?? "";
        },
        showSearchBox: true,
        dropdownSearchTextAlign: TextAlign.center,
        dropdownButtonBuilder: (_) {
          return Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Icon(
              Icons.arrow_drop_down,
              color: primaryColor,
            ),
          );
        },
        onPopupDismissed: () {
          controller.searchZoneTEController.text = '';
        },
        searchFieldProps: TextFieldProps(
          controller: controller.searchZoneTEController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(5),
            hintText: Translate.searchHere.tr,
            hintStyle: const TextStyle(fontSize: 13),
            focusedBorder: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(),
          ),
        ),
        selectedItem: controller.selectedZone,
        filterFn: (city, filter) =>
            HelperFunctions.cityFilterByName(filter ?? '', city?.name ?? ''),
        dropdownSearchDecoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: primaryColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
        emptyBuilder: (_, __) {
          return Center(
            child: CustomText(
              Translate.noDataFound.tr,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          );
        },
        dropdownBuilder: (context, item) {
          if (controller.selectedZone?.name?.isEmpty ?? true) {
            return CustomText(
              Translate.selectCity.tr,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13, color: primaryColor),
            );
          } else {
            return CustomText(
              item?.name ?? "",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13, color: primaryColor),
            );
          }
        },
        onChanged: (newValue) async {
          await controller.onChangeZone(newValue, context);
        },
        items: cities,
      ),
    );
  }
}
