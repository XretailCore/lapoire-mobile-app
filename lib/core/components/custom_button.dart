import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/theme.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  final double? mdw;
  final Color? color;
  final Color? textColor;
  final double? mdh;
  final bool? enabled;
  final IconData? icon;
  final double iconSize;
  final double radius;
  final bool isFixed;
  const CustomButton({
    Key? key,
    this.onTap,
    this.title,
    this.mdw,
    this.mdh,
    this.color,
    this.textColor,
    this.icon,
    this.enabled,
    this.iconSize = 24,
    this.radius = 5,
    this.isFixed = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: enabled ?? true ? onTap : null,
      style: ElevatedButton.styleFrom(
          backgroundColor: color ?? CustomThemes.appTheme.primaryColor,
          fixedSize:
              isFixed ? Size(mdw ?? ScreenUtil().screenWidth, mdh ?? 40) : null,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius))),
      label: CustomText(
        "$title",
        style: TextStyle(color: textColor, fontSize: 14),
      ),
      icon: Icon(
        icon,
        color: Colors.white,
        size: icon == null ? 0 : iconSize,
      ),
    );
  }
}

class CustomBorderButton extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  final double? mdw;
  final Color? color;
  final Color? textColor;
  final double? mdh;
  final bool? enabled;
  final IconData? icon;
  final double iconSize;
  final double radius;
  final bool isFixed;
  final Color? borderColor;
  const CustomBorderButton({
    Key? key,
    this.onTap,
    this.title,
    this.mdw,
    this.mdh,
    this.color,
    this.textColor,
    this.icon,
    this.enabled,
    this.iconSize = 24,
    this.radius = 5,
    this.isFixed = true,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ?? true ? onTap : null,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: CustomText(
          title,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
