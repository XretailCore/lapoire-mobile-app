import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomThemes {
  CustomThemes();
  static final appTheme = Theme.of(Get.context!),
      _defaultThemeData = ThemeData(
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          primaryColor: const Color(0xff00754D),
          highlightColor: const Color(0xffFCF4CB),
          canvasColor: Colors.white,
          fontFamily: 'Dalton Maag',
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color.fromRGBO(24, 128, 61, 1), //thereby
          ),
          scrollbarTheme: ScrollbarThemeData(
              thumbColor: MaterialStateColor.resolveWith(
                  (states) => const Color.fromRGBO(24, 128, 61, 1))));
  static ThemeData get lightThemeData => _defaultThemeData.copyWith(
      colorScheme: _defaultThemeData.colorScheme
          .copyWith(secondary: const Color.fromRGBO(87, 87, 98, 1)));
  static ThemeData get darkThemeData =>
      _defaultThemeData.copyWith(primaryColor: Colors.black);
}
