import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imtnan/core/utils/app_colors.dart';

import '../../../core/components/custom_appbar.dart';
import '../../../core/components/custom_button.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/components/imtnan_loading_widget.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/theme.dart';
import '../controllers/stores_controller.dart';
import '../widgets/distance_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:linktsp_api/linktsp_api.dart';

class StoresScreen extends GetView<StoresController> {
  const StoresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: Translate.stores.tr,
        showBackButton: true,
        showAction: false,
      ),
      body: Theme(
        data: ThemeData(
            unselectedWidgetColor: CustomThemes.appTheme.colorScheme.secondary),
        child: controller.obx(
          (markers) => Column(
            children: [
              Expanded(
                child: GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: markers ?? {},
                  initialCameraPosition: const CameraPosition(
                      target: LatLng(30.0444, 31.2357), zoom: 7),
                  onMapCreated: (GoogleMapController _mapController) {
                    controller.mapController.complete(_mapController);
                  },
                ),
              ),
              Container(
                color: AppColors.highlighter,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: CustomText(
                            Translate.findYourNearestBranch.tr,
                            style: const TextStyle(
                                color: Color(0xff666666),
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                        ),
                        DistanceWidget(
                          activeColor: CustomThemes.appTheme.primaryColor,
                          textStyle: TextStyle(
                            color: const Color.fromARGB(255, 70, 67, 67),
                            fontSize: 12.sm,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0,
                          ),
                        ),
                        CustomBorderButton(
                          color: AppColors.redColor,
                          radius: 30,
                          title: Translate.searchByCurrentLocation.tr,
                          onTap: controller.selectedDistance != null
                              ? () => controller.searchByLocationAction(
                                    context,
                                    distance: controller.selectedDistance,
                                  )
                              : null,
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Divider(
                        color: CustomThemes.appTheme.primaryColor,
                        thickness: 1.5),
                    const SizedBox(height: 16),
                    Column(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: CustomText(
                            Translate.searchByCity.tr,
                            style: TextStyle(
                                color: CustomThemes.appTheme.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: double.infinity,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.highlighter,
                              border: Border.all(
                                  color: CustomThemes.appTheme.primaryColor),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10.0, 0, 10, 0),
                              child: Obx(
                                () => DropdownButtonHideUnderline(
                                  child: DropdownButton<CityModel?>(
                                    borderRadius: BorderRadius.circular(30),
                                    icon: FaIcon(FontAwesomeIcons.angleDown,
                                        size: 16.0,
                                        color:
                                            CustomThemes.appTheme.primaryColor),
                                    style: TextStyle(
                                        color: CustomThemes
                                            .appTheme.colorScheme.secondary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        letterSpacing: 0),
                                    dropdownColor: AppColors.highlighter,
                                    onChanged: (city) {
                                      controller.selectedCity = city;
                                    },
                                    value: controller.selectedCity,
                                    items: [
                                      for (var data in controller.allCities)
                                        DropdownMenuItem<CityModel?>(
                                          child: SizedBox(
                                            width: 200,
                                            child: CustomText(
                                              data.name ?? '',
                                            ),
                                          ),
                                          value: data,
                                        )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomBorderButton(
                          color: AppColors.redColor,
                          textColor: Colors.white,
                          radius: 30,
                          title: Translate.searchByCity.tr,
                          onTap: () async => controller.searchByCityAction(
                              context, controller.selectedCity),
                        ),
                        const SizedBox(height: 10),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          onLoading: const CustomLoadingWidget(),
        ),
      ),
    );
  }
}
