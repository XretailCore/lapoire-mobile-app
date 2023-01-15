import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      appBar: CustomTitledAppBar(title: Translate.stores.tr),
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
                                color: Color(0xff4D4D4D),
                                fontWeight: FontWeight.bold,
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
                        CustomButton(
                          color: CustomThemes.appTheme.primaryColor,
                          textColor: Colors.white,
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
                    const SizedBox(height: 30),
                    Column(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: CustomText(
                            Translate.searchByCity.tr,
                            style: const TextStyle(
                                color: Color(0xff4D4D4D),
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            color: Colors.black12,
                            elevation: 0,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10.0, 0, 10, 0),
                              child: Obx(() => DropdownButtonHideUnderline(
                                    child: DropdownButton<CityModel?>(
                                        style: TextStyle(
                                            color: CustomThemes
                                                .appTheme.colorScheme.secondary,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            letterSpacing: 0),
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
                                        ]),
                                  )),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomButton(
                          color: CustomThemes.appTheme.primaryColor,
                          textColor: Colors.white,
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
