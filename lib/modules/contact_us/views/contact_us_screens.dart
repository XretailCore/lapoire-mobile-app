import 'package:imtnan/core/components/custom_appbar.dart';
import 'package:imtnan/core/utils/theme.dart';
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
        body: controller.obx((contactInfo) {
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset("assets/images/no_image_logo.png",
                    height: 200, width: 200),
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
                      child: SvgPicture.asset('assets/images/facebook.svg'),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () async {
                        final url = instagram?.url ?? '';
                        controller.launchUrl(url: url, context: context);
                      },
                      child: SvgPicture.asset(
                        'assets/images/instagram.svg',
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
                        color: CustomThemes.appTheme.primaryColor,
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
        }));
  }
}
