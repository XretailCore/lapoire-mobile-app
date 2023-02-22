import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/components/custom_button.dart';
import 'package:imtnan/core/localization/translate.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import 'package:imtnan/core/utils/custom_shared_prefrenece.dart';
import '../../core/components/custom_text.dart';
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
                      child: DottedBorder(
                        color: AppColors.primaryColor,
                        strokeWidth: 1.5,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(30.0),
                        child: Obx(
                          () => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: SizedBox(
                              height: 45,
                              child: DropdownButtonHideUnderline(
                                child: controller.selectedZone.value.id == null
                                    ? DropdownButton(
                                        isExpanded: true,
                                        dropdownColor: AppColors.highlighter,
                                        style: TextStyle(
                                          color: CustomThemes
                                              .appTheme.colorScheme.secondary,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 0,
                                        ),
                                        hint: CustomText(
                                            Translate.selectYourZone.tr),
                                        iconEnabledColor:
                                            AppColors.primaryColor,
                                        onChanged: (newValue) =>
                                            controller.onChangeZone(newValue),
                                        items: [
                                          for (var data
                                              in controller.feedbackMenu)
                                            DropdownMenuItem(
                                              value: data,
                                              child: CustomText(
                                                data.name ??
                                                    Translate.selectYourZone.tr,
                                                style: const TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            )
                                        ],
                                      )
                                    : DropdownButton(
                                        isExpanded: true,
                                        dropdownColor: AppColors.highlighter,
                                        style: TextStyle(
                                          color: CustomThemes
                                              .appTheme.colorScheme.secondary,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 0,
                                        ),
                                        iconEnabledColor:
                                            AppColors.primaryColor,
                                        onChanged: (newValue) =>
                                            controller.onChangeZone(newValue),
                                        value: controller.selectedZone.value,
                                        items: [
                                          for (var data
                                              in controller.feedbackMenu)
                                            DropdownMenuItem(
                                              value: data,
                                              child: CustomText(
                                                data.name ??
                                                    Translate.selectYourZone.tr,
                                                style: const TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            )
                                        ],
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Obx(()=> Column(
                  children: [
                    CustomBorderButton(
                        title: Translate.confirm.tr,
                        color:controller.selectedZone.value.id == null?Colors.grey: AppColors.primaryColor,
                        radius: 30.0,
                        onTap: controller.selectedZone.value.id == null
                            ? null
                            : () => controller.onSubmitNewZone(
                                afterSubmitZoneAction: afterSubmitZoneAction),
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
