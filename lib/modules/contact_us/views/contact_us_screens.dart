import 'dart:io';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:imtnan/core/components/custom_appbar.dart';
import 'package:imtnan/core/utils/theme.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../controllers/contact_us_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

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
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 30),
                      InkWell(
                        onTap: () {
                          FlutterPhoneDirectCaller.callNumber(phone ?? '');
                        },
                        child: RowItemWidget(
                          iconData: Icons.call,
                          text: phone ?? '',
                        ),
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: Platform.isIOS
                            ? () {
                                controller.launchMailto(email ?? '');
                              }
                            : () async {
                                final Email _email = Email(
                                  recipients: [email ?? ""],
                                );
                                await FlutterEmailSender.send(_email);
                              },
                        child: RowItemWidget(
                          iconData: Icons.email_rounded,
                          text: email ?? '',
                        ),
                      ),
                      const SizedBox(height: 15),
                      RowItemWidget(
                        iconData: Icons.av_timer_rounded,
                        text: workingHours ?? '',
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              final facebookUrl = facebook?.url ?? '';
                              controller.launchUrl(
                                  url: facebookUrl, context: context);
                            },
                            child:
                                SvgPicture.asset('assets/images/facebook.svg'),
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
                    ],
                  ),
                ),
              ],
            ),
          );
        }));
  }
}

class RowItemWidget extends StatelessWidget {
  const RowItemWidget({Key? key, required this.iconData, required this.text})
      : super(key: key);
  final IconData iconData;
  final String text;
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: primaryColor),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[100]!,
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            color: primaryColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: CustomText(
              text,
              softWrap: true,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
