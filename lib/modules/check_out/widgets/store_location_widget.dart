import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imtnan/core/utils/theme.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/utils/app_colors.dart';

class StoreLocationWidget extends StatelessWidget {
  const StoreLocationWidget({
    Key? key,
    this.title = '',
    this.description = '',
    this.phone = '',
    this.latitude,
    this.longitude,
    this.checked = false,
    this.showRadioButton = false,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);
  final String title, description, phone;
  final double? latitude, longitude;

  final bool checked;
  final bool showRadioButton, isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final primary=CustomThemes.appTheme.primaryColor;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Radio<bool>(
              value: true,
              activeColor: AppColors.primaryColor,
              fillColor: MaterialStateColor.resolveWith(
                      (states) => Theme.of(context).primaryColor),
              groupValue: isSelected,
              onChanged: (v) {
                onTap();
              },
            ),
            Expanded(
              child: Row(

                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomText(
                           title,
                          style:  TextStyle(
                            fontSize: 14,
                            color:  primary,
                          ),

                        ),
                        const SizedBox(height: 3),
                        CustomText(
                           description,
                          softWrap: true,
                          style:  TextStyle(
                            fontSize: 14,
                            color:  primary,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: phone == "" ? 0 : 3),
                        Offstage(
                          offstage: (phone == ""),
                          child: CustomText(
                             phone,
                            style:  TextStyle(
                              fontSize: 14,
                              color: primary,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await openMap(latitude, longitude);
                    },
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(Translate.viewMap.tr,
                          softWrap: true,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: (Platform.isIOS) ? 14.sm : 12.sm,
                            fontWeight: FontWeight.bold,
                            color: AppColors.redColor,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> openMap(double? latitude, double? longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    // ignore: deprecated_member_use
    if (await canLaunch(googleUrl)) {
      // ignore: deprecated_member_use
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
