import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/theme.dart';
import '../controller/my_addresses_controller.dart';

class EmptyAddressesWidget extends GetView<MyAddressesController> {
  const EmptyAddressesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton.icon(
              onPressed: controller.addNewAddressAction,
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                      CustomThemes.appTheme.primaryColor)),
              icon: const Icon(Icons.add_circle_outline),
              label: CustomText(
                Translate.newAddress.tr,
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: DottedBorder(
            color: CustomThemes.appTheme.primaryColor,
            child: Container(
              height: 100,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    Translate.addNewAddress.tr,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: CustomThemes.appTheme.primaryColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(5),
              topLeft: Radius.circular(5),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: CustomText(
                  Translate.emptyAddresssesMessage.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
