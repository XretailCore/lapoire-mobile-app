import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../localization/lanaguages_enum.dart';
import '../localization/translate.dart';
import '../utils/app_colors.dart';
import '../utils/custom_shared_prefrenece.dart';
import 'custom_text.dart';

class CustomBackButton extends StatelessWidget {
  final void Function()? onTap;
  const CustomBackButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final language = Get.find<UserSharedPrefrenceController>().getLanguage;

    return InkWell(
      onTap: onTap ?? () => Get.back(),
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, right: 12.0, left: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            language == Languages.ar.name
                ? RotatedBox(
                    quarterTurns: 2,
                    child: SvgPicture.asset("assets/images/back.svg"))
                : SvgPicture.asset("assets/images/back.svg"),
            CustomText(
              Translate.back.tr,
              style: const TextStyle(fontSize: 10, color: AppColors.redColor),
            )
          ],
        ),
      ),
    );
  }
}
