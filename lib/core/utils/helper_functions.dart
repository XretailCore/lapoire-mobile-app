// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/data/exception_api.dart';

import '../components/custom_loaders.dart';
import '../components/custom_text.dart';
import 'theme.dart';

class HelperFunctions {
  static Future<Position> getCurrentLocation() async {
    await Geolocator.requestPermission();
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  static SnackBar customSnackBar(
      {String? message,
      Color? backgroundColor,
      Color textColor = Colors.white,
      SnackBarBehavior? snackBarBehavior,
      Duration duration = const Duration(seconds: 3),
      bool hasCloseBtn = false}) {
    return SnackBar(
      padding: const EdgeInsets.all(10),
      content: Row(
        children: [
          Expanded(
            child: CustomText(
              message ?? '',
              softWrap: true,
              maxLines: 3,
              style: TextStyle(
                  color: textColor,
                  fontFamily: 'Gilroy',
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          hasCloseBtn
              ? IconButton(
                  iconSize: 18,
                  color: Colors.white,
                  onPressed: () {
                    ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
                  },
                  icon: const FaIcon(FontAwesomeIcons.xmark))
              : const SizedBox.shrink()
        ],
      ),
      backgroundColor: backgroundColor ?? CustomThemes.appTheme.primaryColor,
      behavior: snackBarBehavior ?? SnackBarBehavior.fixed,
      duration: hasCloseBtn ? const Duration(hours: 1) : duration,
    );
  }

  static void showSnackBar(
      {required String message,
      required BuildContext context,
      Color color = Colors.red,
        Duration duration = const Duration(seconds: 3),
      bool hasCloseBtn = false}) {
    final snackBar = HelperFunctions.customSnackBar(
        message: message,
        duration: duration,
        textColor: Colors.white,
        backgroundColor: color,
        hasCloseBtn: hasCloseBtn);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  RxList<String> setDaysList() {
    var daysList = List<String>.generate(30, (i) => (i + 1).toString());
    return daysList.obs;
  }

  RxList<String> setMonthList() {
    var monthList = List<String>.generate(12, (i) => (i + 1).toString());
    return monthList.obs;
  }

  RxList<String> setYearsList() {
    var yearList = [
      for (var i = 1930; i < DateTime.now().year; i += 1) i.toString()
    ];
    return yearList.obs;
  }

  static void showSnakeBar(
      String snakeBartitle,
      String snakeBarMessage,
      Color messageLabelColor,
      Icon snakeBarIcon,
      Color snakeBarBackgroundColor) {
    Get.snackbar('', '',
        titleText: CustomText(snakeBartitle),
        messageText: CustomText(
          snakeBarMessage,
          style: TextStyle(color: messageLabelColor),
        ),
        colorText: Colors.black,
        snackPosition: SnackPosition.TOP,
        snackStyle: SnackStyle.FLOATING,
        icon: snakeBarIcon,
        barBlur: 20,
        backgroundColor: snakeBarBackgroundColor);
  }

  static Future<void> errorHandler(
      BuildContext context, Future<void> Function() function) async {
    try {
      return await function();
    } on ExceptionApi catch (e) {
      HelperFunctions.showSnackBar(
          message: e.message ?? "", context: context, hasCloseBtn: true);
      return;
    } catch (e) {
      HelperFunctions.showSnackBar(
          message: e.toString(), context: context, hasCloseBtn: true);
      return;
    }
  }

  static Future<T?> errorRequestsHandler<T>(
      {required Future<T> Function() loadingFunction,
      String? apiErrorMessage,
      String? dioErrorMessage,
      String? unexpectedErrorMessage,
      Future<void> Function(T result)? onSuccessFunction,
      Future<void> Function(ExceptionApi e, String defaultErrorMessage)?
          onApiErrorFunction,
      Future<void> Function(DioError e, String defaultErrorMessage)?
          onDioErrorFunction,
      Future<void> Function(dynamic e, String defaultErrorMessage)?
          onUnexpectedErrorFunction,
      Future<void> Function()? onFinallyFunction}) async {
    try {
      final result = await loadingFunction();

      if (onSuccessFunction != null) {
        await onSuccessFunction(result);
      }
      return result;
    } on ExceptionApi catch (e) {
      final defaultErrorMessage = apiErrorMessage ?? 'Can\'t Connect To Server';
      if (onApiErrorFunction != null) {
        await onApiErrorFunction(e, defaultErrorMessage);
      }
    } on DioError catch (e) {
      final defaultErrorMessage = dioErrorMessage ?? 'Can\'t Connect To Server';
      if (onDioErrorFunction != null) {
        await onDioErrorFunction(e, defaultErrorMessage);
      }
    } catch (e) {
      final defaultErrorMessage = unexpectedErrorMessage ?? 'Unexpected Error';
      if (onUnexpectedErrorFunction != null) {
        await onUnexpectedErrorFunction(e, defaultErrorMessage);
      }
    } finally {
      if (onFinallyFunction != null) {
        onFinallyFunction();
      }
    }
    return null;
  }

  static Future<T?> errorRequestsSnakBarHandler<T>(BuildContext context,
      {required Future<T> Function() loadingFunction,
      String? apiErrorMessage,
      String? dioErrorMessage,
      String? unexpectedErrorMessage,
      Future<void> Function(T result)? onSuccessFunction,
      bool? hasCloseBtn,
      Future<void> Function()? onFinallyFunction}) async {
    try {
      openLoadingDialog(context);

      final result = await loadingFunction();

      Get.back();

      if (onSuccessFunction != null) {
        await onSuccessFunction(result);
      }
      return result;
    } on ExceptionApi catch (e) {
      Get.back();
      HelperFunctions.showSnackBar(
          message: e.message.toString(),
          context: context,
          hasCloseBtn: hasCloseBtn ?? false);
    } on DioError {
      final defaultErrorMessage = dioErrorMessage ?? 'Can\'t Connect To Server';
      Get.back();
      HelperFunctions.showSnackBar(
          message: defaultErrorMessage,
          context: context,
          hasCloseBtn: hasCloseBtn ?? false);
    } catch (e) {
      final defaultErrorMessage = unexpectedErrorMessage ?? 'Unexpected Error';
      Get.back();
      HelperFunctions.showSnackBar(
          message: defaultErrorMessage,
          context: context,
          hasCloseBtn: hasCloseBtn ?? false);
    } finally {
      if (onFinallyFunction != null) {
        onFinallyFunction();
      }
    }
    return null;
  }
  static Future<void> vibrate() async {
    bool canVibrate = await Vibrate.canVibrate;
    if (canVibrate) {
      Vibrate.vibrate();
    }
  }
  static Future<String?> getDeviceToken() async {
    try {
      return await FCMConfig.instance.messaging.getToken();
    } catch (e) {
      print(e);
    }
    return null;
  }

  static bool cityFilterByName(String filter, String cityName) {
    return cityName.toLowerCase().contains(filter.toLowerCase());
  }

  static String countryFlag(String countryCode) {
    int flagOffset = 0x1F1E6;
    int asciiOffset = 0x41;

    int firstChar = countryCode.codeUnitAt(0) - asciiOffset + flagOffset;
    int secondChar = countryCode.codeUnitAt(1) - asciiOffset + flagOffset;

    return String.fromCharCode(firstChar) + String.fromCharCode(secondChar);
  }
}

void customSnackBar(String? title, String message, {Color? bgcolor}) =>
    Get.snackbar(
      title ?? "",
      message,
      backgroundColor: bgcolor,
      colorText: Colors.white,
      duration: const Duration(milliseconds: 2500),
      snackPosition: SnackPosition.TOP,
      snackStyle: SnackStyle.FLOATING,
      animationDuration: const Duration(milliseconds: 2500),
      barBlur: 20,
      isDismissible: true,
    );
