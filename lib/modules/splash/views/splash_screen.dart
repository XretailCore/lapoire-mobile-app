import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:imtnan/core/components/no_internet_widget.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/theme.dart';
import '../controllers/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx(
        (state) => const SplashWidget(),
        onLoading: const SplashWidget(),
        onEmpty: const SplashWidget(),
        onError: (e) => Stack(
          fit: StackFit.expand,
          children: [
            const NoInternetWidget(),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.15,
              left: MediaQuery.of(context).size.width * 0.3,
              right: MediaQuery.of(context).size.width * 0.3,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 13),
                      blurRadius: 25,
                      color: const Color(0xFF5666C2).withOpacity(0.17),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: controller.retryGetToken,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: CustomThemes.appTheme.primaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                    ),
                    child: CustomText(
                      Translate.retry.tr,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SplashWidget extends StatelessWidget {
  const SplashWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset("assets/images/splash_bg_image.png",
              fit: BoxFit.fill),
        ),
        Center(
          child: Image.asset(
            'assets/images/main_logo.png',
            width: 150,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: CustomText(
            'Powered By Link TSP',
            style: TextStyle(
                color: CustomThemes.appTheme.primaryColor, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
