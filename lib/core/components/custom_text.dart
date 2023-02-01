import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imtnan/core/utils/theme.dart';

class CustomText extends StatelessWidget {
  final String? title;
  final Color? color;
  final double? fontSize;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final int? maxLines;

  final TextDecoration? decoration;

  final Color? decorationColor;
  final TextStyle? style;
  final String? data;
  final bool softWrap;
  final bool? forceStrutHeight;

  // ignore: use_key_in_widget_constructors
  const CustomText(this.data,
      {@Deprecated('use data property instead') this.title,
      @Deprecated('use style property instead') this.color,
      @Deprecated('use style property instead') this.fontSize,
      this.textAlign,
      @Deprecated('use style property instead') this.fontWeight,
      this.overflow,
      this.maxLines,
      @Deprecated('use style property instead') this.decoration,
      @Deprecated('use style property instead') this.decorationColor,
      this.style,
      this.softWrap = false,
      this.forceStrutHeight = true});

  @override
  Widget build(BuildContext context) {
    return Text(
      data ?? '',
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
      style: style?.copyWith(
              color: style?.color ?? CustomThemes.appTheme.primaryColor,
              fontSize: style?.fontSize?.sm,
              height: style?.height ?? 1,
              fontWeight: style?.fontWeight ?? FontWeight.w700) ??
          TextStyle(
            color: color ?? CustomThemes.appTheme.primaryColor,
            fontWeight: fontWeight ?? FontWeight.w700,
            decoration: decoration,
            decorationColor: decorationColor,
          ),
      strutStyle: StrutStyle(
        forceStrutHeight:
            forceStrutHeight, // apply the same height for both arabic and english
      ),
    );
  }
}
