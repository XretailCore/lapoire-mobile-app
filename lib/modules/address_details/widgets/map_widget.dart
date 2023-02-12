import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/address_details_controller.dart';

class MapWidget extends GetView<AddressDetailsController> {
  const MapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final position = LatLng(controller.addressModel.latitude ?? 0,
        controller.addressModel.longitude ?? 0);
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: GoogleMap(
        scrollGesturesEnabled: false,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: false,
        rotateGesturesEnabled: false,
        initialCameraPosition: CameraPosition(target: position, zoom: 18),
        markers: {
          Marker(
            markerId: const MarkerId('1'),
            position: position,
          )
        },
        myLocationButtonEnabled: false,
        myLocationEnabled: false,
      ),
    );
  }
}
