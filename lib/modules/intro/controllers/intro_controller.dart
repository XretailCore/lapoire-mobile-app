import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/localization/translate.dart';

class IntroController extends GetxController {
  RxInt currentPage = 0.obs;
  bool get isLastPage => currentPage.value == introList.length - 1;
  List introList = [
    {"title": Translate.freshAndDailyBakedPatisserie.tr, "image": "intro_1"},
    {"title": Translate.fastDeliveryToYourPlace.tr, "image": "intro_2"},
  ];
  final pageController = PageController();

  onPageChanged(val) {
    currentPage.value = val;
  }

  @override
  void onClose() {
    currentPage.close();

    pageController.dispose();

    super.onClose();
  }
}
