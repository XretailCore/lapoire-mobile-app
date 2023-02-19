import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:imtnan/core/utils/theme.dart';

import '../localization/lanaguages_enum.dart';
import '../utils/custom_shared_prefrenece.dart';

class CustomText extends StatelessWidget {
  final String? title;
  final Color? color;
  final double? fontSize;
  final TextAlign? textAlign;
  final double? textHeight;
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
      this.forceStrutHeight = true, this.textHeight});

  @override
  Widget build(BuildContext context) {
    final language = Get.find<UserSharedPrefrenceController>().getLanguage;
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
            fontWeight: style?.fontWeight ?? FontWeight.w700,
            fontFamily: style?.fontFamily ?? getLanguage(language),
          ) ??
          TextStyle(
            color: color ?? CustomThemes.appTheme.primaryColor,
            fontWeight: fontWeight ?? FontWeight.w700,
            decoration: decoration,
            decorationColor: decorationColor,
            height: textHeight,
            fontFamily: getLanguage(language),
          ),
      strutStyle: StrutStyle(
        forceStrutHeight:
            forceStrutHeight, // apply the same height for both arabic and english
      ),
    );
  }
  String getLanguage(String lang)
  {
    if(lang==Languages.ar.name)
      {
        return "Cairo";
      }
    else{
      return "Gilroy";
    }
  }
}
