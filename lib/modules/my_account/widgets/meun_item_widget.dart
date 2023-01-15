import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/components/custom_text.dart';

class MenuItemWidget extends StatelessWidget {
  final String icon;
  final String? title;
  final VoidCallback? onTap;
  const MenuItemWidget({
    Key? key,
    required this.icon,
    this.onTap,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 30,
              child: SvgPicture.asset(
                icon,
                width: 20,
                height: 20,
              ),
            ),
            const SizedBox(width: 10),
            CustomText(
              title ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: primaryColor,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right,
              color: primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
