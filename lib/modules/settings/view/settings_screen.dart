import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/appbar_widget.dart';
import '../../../core/components/card_settings_menu_item_widget.dart';
import '../../../core/localization/translate.dart';
import '../controller/settings_controller.dart';
import '../widgets/notification_widget.dart';
import '../widgets/title_widget.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: Translate.settings.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 20, 10, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitlesWidget(title: Translate.account.tr),
              const SizedBox(height: 10),
              CardSettingsMenuItemWidget(
                icon: Icons.assignment,
                itemTitle: Translate.subscribeToOurNewsletter.tr,
                itemAction: controller.goToChangeSubscribeScreen,
              ),
              CardSettingsMenuItemWidget(
                icon: Icons.security,
                itemTitle: Translate.changePassword.tr,
                itemAction: controller.goToChangePasswordScreen,
              ),
              Visibility(
                visible: controller.userSharedPrefrenceController.isUser,
                child: CardSettingsMenuItemWidget(
                  icon: Icons.person_remove,
                  itemTitle: Translate.deleteAccount.tr.capitalizeFirst,
                  itemAction: controller.deleteAccountPopup,
                ),
              ),
              Visibility(
                visible: controller.userSharedPrefrenceController.isUser,
                child: CardSettingsMenuItemWidget(
                  icon: Icons.person_remove,
                  itemTitle: Translate.deactivateAccount.tr.capitalizeFirst,
                  itemAction: controller.deactivateAccountPopup,
                ),
              ),
              CardSettingsMenuItemWidget(
                icon: Icons.help,
                itemTitle: Translate.aboutUs.tr,
                itemAction: controller.goToAboutScreen,
              ),
              const SizedBox(height: 10),
              TitlesWidget(title: Translate.notifications.tr),
              const SizedBox(height: 10),
              const NotificationWidget(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
