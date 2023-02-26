import 'package:flutter/material.dart';

import 'custom_text.dart';

class CardSettingsMenuItemWidget extends StatelessWidget {
  final String? itemTitle;
  final Function()? itemAction;
  const CardSettingsMenuItemWidget({
    Key? key,
    this.itemAction,
    this.itemTitle,
    required this.icon,
  }) : super(key: key);
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return InkWell(
      onTap: itemAction,
      child: SizedBox(
          height: 55,
          width: double.infinity,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(color: primaryColor, width: 1.5),
            ),
            elevation: 0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      icon,
                      color: primaryColor,
                    ),
                    const SizedBox(width: 10),
                    CustomText(
                      itemTitle ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.chevron_right,
                      color: primaryColor,
                      size: 30.0,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
