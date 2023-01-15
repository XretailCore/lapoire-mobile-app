// ignore_for_file: prefer_const_constructors
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:imtnan/core/components/custom_appbar.dart';
import 'package:imtnan/core/components/imtnan_loading_widget.dart';
import 'package:imtnan/core/localization/translate.dart';
import 'package:imtnan/modules/map/controllers/map_controller.dart';
import 'package:imtnan/modules/map/widgets/map_bottom_widget.dart';

import '../../../core/components/custom_error_widget.dart';

class MapScreen extends GetView<MapController> {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> _controller = Completer();
    return Scaffold(
      appBar: CustomTitledAppBar(title: Translate.selectLocation.name.tr),
      body: controller.obx(
        (state) => Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: controller.currentPostion.value,
                          zoom: 18,
                        ),
                        onMapCreated: (GoogleMapController googleController) {
                          _controller.complete(googleController);
                        },
                        onCameraIdle: () {
                          controller.getLocation(
                              lat: controller.lat.value,
                              lng: controller.lng.value);
                        },
                        onCameraMove: (position) {
                          controller.onCameraMove(position);
                        },
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        onTap: (value) {},
                        // markers: Set<Marker>.of(controller.markers),
                      ),
                      Center(
                        child: Image.asset("assets/images/map_marker.png"),
                      ),
                    ],
                  ),
                ),
                MapBottomWidget(
                  address: controller.currentAddress.value,
                  onTap: controller.submitLocationAction,
                ),
              ],
            ),
            // Positioned(
            //   top: 50,
            //   right: 0,
            //   left: 0,
            //   child: MapSearchBarWidget(),
            // ),
          ],
        ),
        onError: (e) => CustomErrorWidget(
          errorText: e,
          onReload: controller.onReady,
        ),
        onLoading: CustomLoadingWidget(),
      ),
    );
  }
}
