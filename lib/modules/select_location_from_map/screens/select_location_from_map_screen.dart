import '../../../core/components/custom_appbar.dart';
import '../../../core/localization/translate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/select_location_from_map_controller.dart';
import '../widgets/address_map_bottom_widget.dart';

class SelectLocationFromMapScreen
    extends GetView<SelectLocationFromMapController> {
  const SelectLocationFromMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Translate.selectLocation.name.tr,showBackButton: true,showAction: false),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: (googleMapController) {
                    controller.mapController.complete(googleMapController);
                  },
                  initialCameraPosition: CameraPosition(
                    target: controller.defaultLatLng,
                    zoom: 18,
                  ),
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  onCameraMove: (position) {
                    controller.addressModel
                      ..latitude = position.target.latitude
                      ..longitude = position.target.longitude;
                  },
                  onCameraIdle: () async {
                    await controller.onCameraIdle();
                  },
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 45),
                    child: Image.asset("assets/images/map_marker.png"),
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => AddressMapBottomWidget(
              address: controller.showAddressName,
              onTap: controller.submitLocationAction,
            ),
          ),
        ],
      ),
    );
  }
}
