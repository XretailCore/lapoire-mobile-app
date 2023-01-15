import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/utils/theme.dart';

class LocationPlaceWidget extends StatelessWidget {
  const LocationPlaceWidget({
    Key? key,
    this.title = '',
    this.name = '',
    this.city = '',
    this.phone = '',
    this.isSelected = false,
    this.isEnableEdit = false,
    required this.onEdit,
    required this.onTap,
    this.checked = false,
    this.showRadioButton = false,
  }) : super(key: key);
  final String title, phone, name, city;
  final bool isSelected, isEnableEdit;
  final VoidCallback onTap;
  final Function()? onEdit;
  final bool checked;
  final bool showRadioButton;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 1.5,
        margin: const EdgeInsets.all(0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: isSelected
                    ? CustomThemes.appTheme.primaryColor
                    : CustomThemes.appTheme.colorScheme.secondary),
          ),
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
                    border: Border.all(
                        color: CustomThemes.appTheme.primaryColor, width: 1.5),
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? CustomThemes.appTheme.primaryColor
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomText(
                        title,
                        style: TextStyle(
                          color: CustomThemes.appTheme.primaryColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),
                      CustomText(
                        name,
                        style: TextStyle(
                          color: CustomThemes.appTheme.primaryColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),
                      CustomText(
                        city,
                        style: TextStyle(
                          color: CustomThemes.appTheme.primaryColor,
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                isEnableEdit
                    ? IconButton(
                        padding: const EdgeInsets.all(0),
                        alignment: AlignmentDirectional.topEnd,
                        onPressed: onEdit,
                        icon: FaIcon(
                          FontAwesomeIcons.penToSquare,
                          color: CustomThemes.appTheme.colorScheme.secondary,
                          size: 20,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
