import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../modules/inner/controllers/inner_product_controller.dart';
import '../utils/app_colors.dart';
import '../utils/routes.dart';
import 'custom_text.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    Key? key,
    this.backgroundColor = Colors.white,
    this.title = '',
    this.elevation = 1,
  }) : super(key: key);
  final Color backgroundColor;
  final String title;
  final double elevation;
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return AppBar(
      backgroundColor: backgroundColor,
      foregroundColor: primaryColor,
      elevation: elevation,
      centerTitle: true,
      title: CustomText(
        title,
        style: const TextStyle(fontSize: 17),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class InnerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const InnerAppBar({
    Key? key,
    this.backgroundColor = Colors.white,
    this.title = '',
    this.elevation = 1,
  }) : super(key: key);
  final Color backgroundColor;
  final String title;
  final double elevation;
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final InnerProductController innerController =
        Get.find<InnerProductController>();
    return AppBar(
      backgroundColor: backgroundColor,
      foregroundColor: primaryColor,
      elevation: elevation,
      leading: Visibility(
        visible: innerController.comeFromRelated,
        replacement: IconButton(
          icon: const Icon(
            Icons.home,
            size: 22,
          ),
          onPressed: () {
            Get.offAllNamed(Routes.dashboard);
          },
        ),
        child: InkWell(
          onTap: () {
            if (!innerController.comeFromRelated) {
              Get.back();
            } else {
              innerController.navigateRelated(context);
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/back.png"),
              CustomText(
                "back".tr,
                style: const TextStyle(fontSize: 10,color: AppColors.redColor),
              )
            ],
          ),
        ),
      ),
      centerTitle: true,
      title: CustomText(
        title,
        style: const TextStyle(fontSize: 17),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
