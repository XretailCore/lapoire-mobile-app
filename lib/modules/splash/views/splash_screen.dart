import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:imtnan/core/components/no_internet_widget.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import 'package:imtnan/modules/splash/views/progres_bar.dart';

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
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
          ),
          const ProgressBarCustom(),
        ],
      ),
    );
  }
}
