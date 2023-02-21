import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
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
                      AppColors.redColor)),
              icon: const Icon(Icons.add_circle_outline),
              label: CustomText(
                Translate.newAddress.tr,
                style: const TextStyle(fontSize: 13,color: AppColors.redColor),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: DottedBorder(
            color: AppColors.redColor,
            child: Container(
              height: 100,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    Translate.addNewAddress.tr,
                    style: const TextStyle(
                      color: AppColors.redColor
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
          decoration: const BoxDecoration(
            color: AppColors.redColor,
            borderRadius:  BorderRadius.only(
              topRight: Radius.circular(5),
              topLeft: Radius.circular(5),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: CustomText(
                  Translate.emptyAddresssesMessage.tr,
                  softWrap: true,
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
