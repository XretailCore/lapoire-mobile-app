import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../controllers/signin_controller.dart';

class SocialMediaWidget extends GetView<SigninController> {
  const SocialMediaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(
                color: primaryColor,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: CustomText(
                Translate.or.tr,
                style: TextStyle(color: primaryColor, fontSize: 12,fontWeight: FontWeight.w400),
              ),
            ),
            Expanded(
              child: Divider(
                color: primaryColor,
                thickness: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => controller.onTapSignInWithFacebook(context),
                iconSize: 40,
                icon: const Icon(
                  Icons.facebook,
                  color: Color.fromRGBO(59, 89, 152, 1),
                ),
              ),
              IconButton(
                onPressed: () {
                  controller.onTapSignInWithGoogle(context);
                },
                iconSize: 40,
                icon: SvgPicture.asset(
                  'assets/images/google_login_icon.svg',
                  fit: BoxFit.fill,
                ),
              ),
              Visibility(
                visible: Platform.isIOS,
                child: const SizedBox(
                  width: 10,
                ),
              ),
              Visibility(
                visible: Platform.isIOS,
                child: CircleAvatar(
                  radius: 17,
                  backgroundColor: Colors.black,
                  child: Center(
                    child: IconButton(
                      padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                      onPressed: () {
                        controller.loginWithAppleID(context);
                      },
                      iconSize: 22,
                      icon: const Icon(
                        Icons.apple,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
