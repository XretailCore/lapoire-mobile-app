import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../controllers/address_details_controller.dart';

class IsDefaultSwitchWidget extends GetView<AddressDetailsController> {
  const IsDefaultSwitchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Obx(
      () => Row(
        children: [
          Switch.adaptive(
            value: controller.isDefaultAddress,
            onChanged: (value) {
              controller.isDefaultAddress = value;
            },
            activeColor: primaryColor,
          ),
          const SizedBox(
            width: 10,
          ),
          CustomText(
            Translate.setAsDefault.tr,
            style: TextStyle(color: primaryColor, fontSize: 14),
          )
        ],
      ),
    );
  }
}
