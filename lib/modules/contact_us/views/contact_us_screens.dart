import 'package:cowpay/core/helpers/screen_size.dart';
import 'package:imtnan/core/components/custom_appbar.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/app_colors.dart';
import '../controllers/contact_us_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../enum/contact_us_info.dart';

class ContactUsScreen extends GetView<ContactUsController> {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Translate.contactUs.tr,
        showBackButton: true,
        showAction: false,
      ),
      body: controller.obx(
        (contactInfo) {
          final phone =
              getSelectedContactInfo(contactInfo, ContactInfo.hotLine)?.value;
          final email =
              getSelectedContactInfo(contactInfo, ContactInfo.email)?.value;
          final workingHours =
              getSelectedContactInfo(contactInfo, ContactInfo.workingHours)
                  ?.value;
          final facebook =
              getSelectedContactInfo(contactInfo, ContactInfo.facebook);
          final instagram =
              getSelectedContactInfo(contactInfo, ContactInfo.instagram);
          final youTube =
              getSelectedContactInfo(contactInfo, ContactInfo.youTube);

          return Container(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  width: 1.sw,
                  height: 200,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Obx(
                        () => AnimatedPositioned(
                          curve: Curves.linear,
                          duration: const Duration(milliseconds: 300),
                          top: controller.selected.value ? 0 : -200.0,
                          child: Image.asset(
                            "assets/images/no_image_logo.png",
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                CustomText(
                  "${Translate.call.tr} $phone",
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        final facebookUrl = facebook?.url ?? '';
                        controller.launchUrl(
                            url: facebookUrl, context: context);
                      },
                      child: SvgPicture.asset(
                        'assets/images/facebook.svg',
                        color: AppColors.redColor,
                      ),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () async {
                        final url = instagram?.url ?? '';
                        controller.launchUrl(url: url, context: context);
                      },
                      child: SvgPicture.asset(
                        'assets/images/instagram.svg',
                        color: AppColors.redColor,
                      ),
                    ),
                    const SizedBox(width: 15),
                    InkWell(
                      onTap: () async {
                        final url = youTube?.url ?? '';
                        controller.launchUrl(url: url, context: context);
                      },
                      child: SvgPicture.asset(
                        'assets/images/youtube.svg',
                        color: AppColors.redColor,
                        height: 45,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                CustomText(
                  email,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.redColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(height: 16.0),
                CustomText(
                  Translate.openingHours.tr,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16.0),
                CustomText(
                  workingHours?.substring(13, workingHours.length) ?? "",
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          );
        },
      ),
    );
  }
}
