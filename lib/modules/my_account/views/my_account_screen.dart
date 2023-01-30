import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/localization/translate.dart';
import '../widgets/header_account_widget.dart';
import '../controllers/my_account_controller.dart';
import '../widgets/menu_component_widget.dart';
import '../widgets/meun_item_widget.dart';

class MyAccountScreen extends GetView<MyAccountController> {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const HeaderAccountWidget(),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: ListView(
                children: [
                  MenuComponentWidget(
                    children: [
                      MenuItemWidget(
                        icon: "assets/images/profile.svg",
                        title: Translate.profile.tr,
                        onTap: controller.goToProfile,
                      ),
                      const SizedBox(height: 4),
                      MenuItemWidget(
                        icon: "assets/images/location.svg",
                        title: Translate.addressBook.tr,
                        onTap: controller.goToAddressBook,
                      ),
                      const SizedBox(height: 4),
                      MenuItemWidget(
                        icon: "assets/images/food.svg",
                        title: Translate.myOrders.tr,
                        onTap: controller.goToMyOrders,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  MenuComponentWidget(
                    children: [
                      MenuItemWidget(
                        icon: "assets/images/settings.svg",
                        title: Translate.settings.tr,
                        onTap: controller.goToSettings,
                      ),
                      const SizedBox(height: 4),
                      MenuItemWidget(
                        icon: "assets/images/language.svg",
                        title: Translate.language.tr,
                        onTap: controller.goToLanguage,
                      ),
                      const SizedBox(height: 4),
                      MenuItemWidget(
                        icon: "assets/images/call.svg",
                        title: Translate.contactUs.tr,
                        onTap: controller.goToContactUs,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  MenuComponentWidget(
                    children: [
                      MenuItemWidget(
                        icon: "assets/images/share.svg",
                        title: Translate.share.tr,
                        onTap: () => controller.shareAction(context),
                      ),
                      const SizedBox(height: 4),
                      MenuItemWidget(
                        icon: "assets/images/star.svg",
                        title: Translate.rateApp.tr,
                        onTap: () => controller.sendToRateApp(context),
                      ),
                      const SizedBox(height: 4),
                      Obx(
                        () => controller.userSharedPrefrenceController.isUser
                            ? MenuItemWidget(
                                icon: "assets/images/signout.svg",
                                title: Translate.signOut.tr,
                                onTap: () => controller.signOut(context),
                              )
                            : MenuItemWidget(
                                icon: "assets/images/signout.svg",
                                title: Translate.login.tr,
                                onTap: controller.goToSign,
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
    );
  }
}
