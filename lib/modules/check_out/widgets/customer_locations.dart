import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/utils/strings.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/utils/app_colors.dart';
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
            return Column(
              children: [
                LocationPlaceWidget(
                  addressName: address.name ?? "",
                  title: address.address ?? '',
                  userName: '${address.firstName} ${address.lastName}',
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
                      arguments: {
                        Arguments.addressModel: address,
                        Arguments.isCheckoutAddress: true,
                      },
                    );
                  },
                ),
                index != addresses.length - 1
                    ? const DottedLine(dashColor: AppColors.redColor)
                    : const SizedBox(),
              ],
            );
          },
        ),
      );
    });
  }
}
