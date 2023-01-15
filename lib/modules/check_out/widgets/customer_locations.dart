import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/utils/routes.dart';
import '../controllers/customer_location_controller.dart';
import '../controllers/locations.dart';
import 'location_place_widget.dart';

class CustomerLocationsWidget extends StatelessWidget {
  const CustomerLocationsWidget(
      {Key? key, this.isEnableEdit = false, required this.addresses})
      : super(key: key);
  final bool isEnableEdit;
  final List<AddressModel> addresses;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerLocationController>(builder: (controller) {
      return Scrollbar(
        child: ListView.separated(
          itemCount: addresses.length,
          separatorBuilder: (context, index) => const SizedBox(height: 5),
          itemBuilder: (_, index) {
            final address = addresses.elementAt(index);
            return LocationPlaceWidget(
              title: address.address ?? '',
              name: '${address.firstName} ${address.lastName}',
              city: address.city?.name ?? '',
              phone: address.mobile ?? '',
              isSelected: Locations.locationId == address.id,
              isEnableEdit: isEnableEdit,
              showRadioButton: true,
              onTap: () {
                controller.onSelectAddress(context, address);
              },
              onEdit: () {
                Get.toNamed(
                  Routes.selectLocationFromMapScreen,
                  arguments: address,
                );
              },
            );
          },
        ),
      );
    });
  }
}
