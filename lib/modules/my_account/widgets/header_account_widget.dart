import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../auth/widgets/account_summary_widget.dart';
import '../controllers/my_account_controller.dart';

class HeaderAccountWidget extends GetView<MyAccountController> {
  const HeaderAccountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
      color: primaryColor,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/imtenan.svg',
            color: Colors.white,
          ),
          Obx(() {
            return Offstage(
              offstage: !controller.userSharedPrefrenceController.isUser,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15),
                  CustomText(
                    Translate.hiThere.tr,
                    style: const TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  const SizedBox(height: 4),
                  CustomText(
                    controller.userSharedPrefrenceController.getUserEmail ?? "",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  const AccountSummaryWidget(),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
