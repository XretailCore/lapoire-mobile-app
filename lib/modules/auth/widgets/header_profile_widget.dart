import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/components/custom_text.dart';
import '../controllers/profile_controller.dart';
import '../../../core/localization/translate.dart';

class HeaderProfileWidget extends GetView<ProfileController> {
  const HeaderProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
      color: primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          CustomText(
            Translate.hiThere.tr,
            style: const TextStyle(color: Colors.white, fontSize: 17),
          ),
          const SizedBox(height: 8),
          CustomText(
            controller.getEmail,
            style: const TextStyle(
                color: Colors.white, fontSize: 13, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
