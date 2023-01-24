import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../localization/translate.dart';
import '../utils/app_colors.dart';
import 'custom_text.dart';

class CustomBackButton extends StatelessWidget {
  final void Function()? onTap;
  const CustomBackButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap??() =>Get.back(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/back.png"),
          CustomText(
            Translate.back.tr,
            style: const TextStyle(fontSize: 10,color: AppColors.redColor),
          )
        ],
      ),
    );
  }
}
