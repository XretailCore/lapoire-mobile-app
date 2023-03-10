import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/instance_manager.dart';
import 'package:imtnan/core/localization/translate.dart';
import 'package:imtnan/core/utils/helper_functions.dart';
import 'package:imtnan/modules/settings/controller/language_controller.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/localization/lanaguages_enum.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LanguageController languageController =
        Get.find<LanguageController>();
    final userSharedPrefrenceController =
        Get.find<UserSharedPrefrenceController>();
    final language = userSharedPrefrenceController.getLanguage;
    return SizedBox(
      height: 220,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              Translate.selectLanguage.tr,
              textAlign: TextAlign.start,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                languageController.changeLanguage(context,
                    language: Languages.en);
              },
              child: Row(
                children: [
                  CustomText(
                    HelperFunctions.countryFlag("US"),
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const CustomText(
                    'English',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 14),
                  ),
                  const Spacer(),
                  Languages.en.name == language
                      ? const FaIcon(
                          FontAwesomeIcons.solidCircleCheck,
                          size: 20,
                          color: AppColors.primaryColor,
                        )
                      : const FaIcon(
                          FontAwesomeIcons.circle,
                          size: 20,
                          color: Colors.black38,
                        )
                ],
              ),
            ),
            const Divider(
              height: 40,
              color: Colors.black38,
            ),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                languageController.changeLanguage(context,
                    language: Languages.ar);
              },
              child: Row(
                children: [
                  CustomText(
                    HelperFunctions.countryFlag("EG"),
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const CustomText(
                    '??????????????',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 14),
                  ),
                  const Spacer(),
                  Languages.ar.name == language
                      ? const FaIcon(
                          FontAwesomeIcons.solidCircleCheck,
                          size: 20,
                          color: AppColors.primaryColor,
                        )
                      : const FaIcon(
                          FontAwesomeIcons.circle,
                          size: 20,
                          color: Colors.black38,
                        )
                ],
              ),
            ),
            const Divider(
              height: 40,
              color: Colors.black38,
            ),
          ],
        ),
      ),
    );
  }
}
