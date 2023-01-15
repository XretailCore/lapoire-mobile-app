import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/theme.dart';

showFlexibleUpdateDialog(BuildContext context, Function()? onTap) {
  Get.defaultDialog(
    barrierDismissible: false,
    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
    titlePadding: const EdgeInsets.only(top: 20),
    title: Translate.update.tr.capitalizeFirst ?? '',
    titleStyle: TextStyle(
        fontSize: (Platform.isIOS) ? 20.sm : 18.sm,
        fontWeight: FontWeight.bold),
    middleText: Translate.thereIsaNewVersion.tr,
    middleTextStyle: TextStyle(
        fontSize: (Platform.isIOS) ? 16.sm : 14.sm,
        fontWeight: FontWeight.normal),
    actions: [
      OutlinedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          side:
              BorderSide(color: CustomThemes.appTheme.primaryColor, width: 1.5),
          elevation: 1,
        ),
        onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        child: CustomText(
          Translate.cancelbtn.name.tr.toUpperCase(),
          style: TextStyle(
              color: CustomThemes.appTheme.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: CustomThemes.appTheme.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        onPressed: onTap,
        child: Text(
          Translate.update.tr.toUpperCase(),
          style: TextStyle(
              fontSize: (Platform.isIOS) ? 16.sm : 14.sm,
              fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}

showForceUpdateDialog(BuildContext context, Function()? onTap) {
  Get.defaultDialog(
    onWillPop: () async => false,
    barrierDismissible: false,
    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
    titlePadding: const EdgeInsets.only(top: 20),
    title: Translate.update.tr.capitalizeFirst ?? '',
    titleStyle: TextStyle(
        fontSize: (Platform.isIOS) ? 20.sm : 18.sm,
        fontWeight: FontWeight.bold),
    middleText: Translate.thereIsaNewVersion.tr,
    middleTextStyle: TextStyle(
        fontSize: (Platform.isIOS) ? 16.sm : 14.sm,
        fontWeight: FontWeight.normal),
    actions: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: CustomThemes.appTheme.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        onPressed: onTap,
        child: Text(
          Translate.update.tr.toUpperCase(),
          style: TextStyle(
              fontSize: (Platform.isIOS) ? 16.sm : 14.sm,
              fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}
