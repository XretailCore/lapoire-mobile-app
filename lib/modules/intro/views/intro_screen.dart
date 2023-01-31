import '../../../core/components/custom_appbar.dart';
import '../../../core/components/custom_button.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/routes.dart';
import '../../../core/utils/theme.dart';
import '../controllers/intro_controller.dart';
import '../widgets/intro_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class IntroScreen extends GetView<IntroController> {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: CustomThemes.appTheme.primaryColor,
      statusBarBrightness: Brightness.light,
    ));
    return Scaffold(
      appBar: const CustomTitledAppBar(),
      body: Column(
        children: [
          // const SizedBox(height: 20),
          Expanded(
            child: PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.onPageChanged,
              itemCount: controller.introList.length,
              pageSnapping: true,
              clipBehavior: Clip.none,
              allowImplicitScrolling: true,
              itemBuilder: (context, index) {
                final item = controller.introList[index];
                return IntroWidget(
                  assetName: item["image"],
                  text: item["title"],
                  index: index,
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onTap: () {
                      Get.toNamed(Routes.sign);
                    },
                    title: Translate.login.tr,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: CustomButton(
                    onTap: () {
                      Get.toNamed(Routes.sign);
                    },
                    title: Translate.createAccount.tr,
                    color: CustomThemes.appTheme.colorScheme.secondary,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
