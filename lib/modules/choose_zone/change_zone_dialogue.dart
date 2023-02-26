import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/components/custom_button.dart';
import 'package:imtnan/core/localization/translate.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import 'package:imtnan/core/utils/custom_shared_prefrenece.dart';
import 'package:linktsp_api/linktsp_api.dart';
import '../../core/components/custom_text.dart';
import '../../core/utils/helper_functions.dart';
import '../../core/utils/theme.dart';
import 'controllers/choose_zone_controller.dart';

void openZoneDialog(BuildContext context, {Function()? afterSubmitZoneAction}) {
  var zoneId = UserSharedPrefrenceController().getCurrentZone?.id;
  showDialog(
    barrierDismissible: zoneId != null ? true : false,
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          if (zoneId != null) {
            return true;
          }
          return false;
        },
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          contentPadding: const EdgeInsets.all(0),
          content:
              ChangeZoneWidget(afterSubmitZoneAction: afterSubmitZoneAction),
        ),
      );
    },
  );
}

class ChangeZoneWidget extends GetView<ZoneController> {
  final Function()? afterSubmitZoneAction;

  const ChangeZoneWidget({
    Key? key,
    this.afterSubmitZoneAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var zoneId = UserSharedPrefrenceController().getCurrentZone?.id;
    final primaryColor = CustomThemes.appTheme.primaryColor;
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: AppColors.highlighter,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: zoneId != null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DottedBorder(
                    color: AppColors.primaryColor,
                    borderType: BorderType.Circle,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const FaIcon(
                          FontAwesomeIcons.xmark,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 5),
                CustomText(
                  Translate.selectYourZone.tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 15),
                CustomText(
                  Translate
                      .chooseYourLocationToStartEnjoyingOurDeliveringService.tr,
                  style: const TextStyle(
                    color: AppColors.redColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => DropdownButtonHideUnderline(
                          child: DropdownSearch<CityModel>(
                              itemAsString: (item) {
                                return item?.name ?? "";
                              },
                              searchFieldProps: TextFieldProps(
                                decoration: InputDecoration(
                                  hintText: Translate.searchHere.tr,
                                  hintStyle: TextStyle(
                                      fontSize: 13, color: primaryColor),
                                  contentPadding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: primaryColor),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: primaryColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: primaryColor),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 13,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              dropdownBuilder: (context, item) {
                                if (controller
                                        .selectedZone.value.name?.isEmpty ??
                                    true) {
                                  return CustomText(
                                    Translate.selectYourZone.tr,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 13, color: primaryColor),
                                  );
                                } else {
                                  return CustomText(
                                    item?.name ?? "",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 13, color: primaryColor),
                                  );
                                }
                              },
                              filterFn: (city, filter) =>
                                  HelperFunctions.cityFilterByName(
                                      filter ?? '', city?.name ?? ''),
                              showSearchBox: true,
                              dropdownSearchTextAlign: TextAlign.center,
                              dropdownButtonBuilder: (_) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10.0),
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    color: primaryColor,
                                  ),
                                );
                              },
                              emptyBuilder: (_, __) {
                                return Center(
                                  child: CustomText(
                                    Translate.noDataFound.tr,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 13, color: primaryColor),
                                  ),
                                );
                              },
                              selectedItem: controller.selectedZone.value,
                              popupBackgroundColor: AppColors.highlighter,
                              dropdownSearchDecoration: InputDecoration(
                                labelStyle: TextStyle(
                                    fontSize: 13, color: primaryColor),
                                suffixStyle: TextStyle(
                                    fontSize: 13, color: primaryColor),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: primaryColor),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: primaryColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: primaryColor),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                              ),
                              onChanged: (newValue) =>
                                  controller.onChangeZone(newValue),
                              items: controller.feedbackMenu),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Obx(
                  () => Column(
                    children: [
                      CustomBorderButton(
                        title: Translate.confirm.tr,
                        color: controller.selectedZone.value.id == null
                            ? Colors.grey
                            : AppColors.primaryColor,
                        radius: 30.0,
                        onTap: controller.selectedZone.value.id == null
                            ? null
                            : () => controller.onSubmitNewZone(
                                afterSubmitZoneAction: afterSubmitZoneAction,
                                context: context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
