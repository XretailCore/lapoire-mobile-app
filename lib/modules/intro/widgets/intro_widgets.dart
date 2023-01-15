import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/utils/theme.dart';
import '../controllers/intro_controller.dart';

class IntroWidget extends GetView<IntroController> {
  final String assetName;
  final double? width;
  final String text;
  final int index;
  const IntroWidget({
    Key? key,
    required this.assetName,
    this.width,
    required this.text,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Card(
        elevation: 2,
        margin: const EdgeInsets.all(0),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25))),
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25))),
          child: Column(
            children: [
              Image.asset('assets/images/$assetName.png', width: width),
              const SizedBox(height: 20),
              DotsIndicator(
                dotsCount: 2,
                position: double.parse(controller.currentPage.value.toString()),
                decorator: DotsDecorator(
                  activeColor: CustomThemes.appTheme.primaryColor,
                  color: CustomThemes.appTheme.colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 10),
              CustomText(
                text,
                style: const TextStyle(
                  color: Color.fromRGBO(77, 77, 77, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    });
  }
}
