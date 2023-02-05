import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imtnan/core/localization/translate.dart';
import 'package:imtnan/core/utils/app_colors.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/utils/theme.dart';

class LocationPlaceWidget extends StatelessWidget {
  const LocationPlaceWidget({
    Key? key,
    this.title = '',
    this.userName = '',
    this.city = '',
    this.phone = '',
    this.isSelected = false,
    this.isEnableEdit = false,
    required this.onEdit,
    required this.onTap,
    this.checked = false,
    this.showRadioButton = false,
    this.addressName = '',
  }) : super(key: key);
  final String title, phone, userName, city, addressName;
  final bool isSelected, isEnableEdit;
  final VoidCallback onTap;
  final Function()? onEdit;
  final bool checked;
  final bool showRadioButton;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: AlignmentDirectional.topStart,
              margin: const EdgeInsets.only(top: 3),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: isSelected
                    ? CustomThemes.appTheme.primaryColor
                    : Colors.white,
                border: Border.all(
                    color: CustomThemes.appTheme.primaryColor, width: 1.5),
                shape: BoxShape.circle,
              ),
              child: const FaIcon(FontAwesomeIcons.check,
                  color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomText(
                    addressName,
                    style: TextStyle(
                      color: CustomThemes.appTheme.primaryColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  CustomText(
                    title,
                    style: TextStyle(
                      color: CustomThemes.appTheme.primaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  CustomText(
                    userName,
                    style: TextStyle(
                      color: CustomThemes.appTheme.primaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  CustomText(
                    city,
                    style: TextStyle(
                      color: CustomThemes.appTheme.primaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: phone == "" ? 0 : 3),
                  Offstage(
                    offstage: (phone == ""),
                    child: CustomText(
                      phone,
                      style: TextStyle(
                        color: CustomThemes.appTheme.primaryColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            isEnableEdit
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        alignment: AlignmentDirectional.topEnd,
                        onPressed: onEdit,
                        icon: const FaIcon(
                          FontAwesomeIcons.penToSquare,
                          color: AppColors.primaryColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      CustomText(Translate.edit.tr)
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
