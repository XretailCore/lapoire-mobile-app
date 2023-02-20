import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../controllers/my_account_controller.dart';
import '../widgets/meun_item_widget.dart';

class MyAccountScreen extends GetView<MyAccountController> {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Container(
            height: 90.0,
            decoration: const BoxDecoration(color: AppColors.highlighter),
            child:  Get.find<UserSharedPrefrenceController>().isUser
                ? Obx(()=>
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                            "${Translate.hello.tr} ${Get.find<UserSharedPrefrenceController>().getUserFirstName}"),
                        const SizedBox(height: 8),
                        CustomText(
                          Get.find<UserSharedPrefrenceController>().getUserEmail,
                          style: const TextStyle(color: AppColors.redColor),
                        )
                      ],
                    ),
                )
                : Center(child: CustomText(Translate.hello.tr,style: const TextStyle(fontSize: 24.0),))),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 40),
              child: Theme(
                data: Theme.of(context).copyWith(
                    colorScheme:
                        ColorScheme.fromSwatch(accentColor: Colors.white)),
                child: ListView(
                  children: [
                    MenuItemWidget(
                      icon: FontAwesomeIcons.solidCircleUser,
                      title: Translate.account.tr,
                      onTap: controller.goToProfile,
                    ),
                    const SizedBox(height: 4),
                    MenuItemWidget(
                      icon: FontAwesomeIcons.locationDot,
                      title: Translate.myAddresses.tr,
                      onTap: controller.goToAddressBook,
                    ),
                    const SizedBox(height: 4),
                    MenuItemWidget(
                      icon: FontAwesomeIcons.boxOpen,
                      title: Translate.myOrders.tr,
                      onTap: controller.goToMyOrders,
                    ),
                    const SizedBox(height: 4),
                    MenuItemWidget(
                      icon: FontAwesomeIcons.gear,
                      title: Translate.settings.tr,
                      onTap: controller.goToSettings,
                    ),
                    const SizedBox(height: 4),
                    MenuItemWidget(
                      icon: FontAwesomeIcons.language,
                      title: Translate.language.tr,
                      onTap: controller.goToLanguage,
                    ),
                    const SizedBox(height: 4),
                    MenuItemWidget(
                      icon: FontAwesomeIcons.store,
                      title: Translate.stores.tr,
                      onTap: controller.goToBranches,
                    ),
                    const SizedBox(height: 4),
                    MenuItemWidget(
                      icon: FontAwesomeIcons.phone,
                      title: Translate.contactUs.tr,
                      onTap: controller.goToContactUs,
                    ),
                    const SizedBox(height: 4),
                    MenuItemWidget(
                      icon: FontAwesomeIcons.shareNodes,
                      title: Translate.share.tr,
                      onTap: () => controller.shareAction(context),
                    ),
                    const SizedBox(height: 4),
                    MenuItemWidget(
                      icon: FontAwesomeIcons.solidStar,
                      title: Translate.rateApp.tr,
                      onTap: () => controller.sendToRateApp(context),
                    ),
                    const SizedBox(height: 4),
                    Obx(
                      () => controller.userSharedPrefrenceController.isUser
                          ? MenuItemWidget(
                              icon: FontAwesomeIcons.signOut,
                              title: Translate.logOut.tr,
                              onTap: () => controller.signOut(context),
                            )
                          : MenuItemWidget(
                              icon: FontAwesomeIcons.signIn,
                              title: Translate.login.tr,
                              onTap: controller.goToSign,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
