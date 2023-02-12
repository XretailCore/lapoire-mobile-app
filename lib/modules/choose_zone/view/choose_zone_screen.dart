import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/components/custom_appbar.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import '../../../core/components/custom_error_widget.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../controllers/choose_zone_controller.dart';

class ChooseZoneScreen extends GetView<ZoneController> {
  const ChooseZoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Translate.zone.tr,
        showBackButton: false,
        showAction: false,
      ),
      body: controller.obx(
          (data) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/delivery_icon.png"),
                      ],
                    ),
                    const SizedBox(height: 50),
                    CustomText(
                      Translate.helloSelectYourZone.tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 15),
                    CustomText(
                      Translate
                          .chooseYourLocationToStartEnjoyingOurDeliveringService
                          .tr,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const CustomText(
                          "Deliver To:",
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1.5,
                                  blurRadius: 1.5,
                                  offset: const Offset(0, 1.5),
                                ),
                              ],
                            ),
                            child: Obx(
                              () => SizedBox(
                                height: 45,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                      isExpanded: true,
                                      dropdownColor: Colors.white,
                                      style: TextStyle(
                                        color: AppColors.redColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        letterSpacing: 0,
                                      ),
                                      onChanged: (newValue) =>
                                          controller.onChooseZone(newValue),
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
                                                color: AppColors.redColor,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          )
                                      ]),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
          onError: (error) => CustomErrorWidget(
                errorText: error ?? "",
                onReload: () => controller.getZones(),
              )),
    );
  }
}
