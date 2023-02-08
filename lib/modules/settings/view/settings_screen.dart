import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/components/custom_appbar.dart';
import '../../../core/components/card_settings_menu_item_widget.dart';
import '../../../core/localization/translate.dart';
import '../controller/settings_controller.dart';
import '../widgets/notification_widget.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Translate.settings.tr,showAction: false,showBackButton: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 20, 10, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              CardSettingsMenuItemWidget(
                icon: FontAwesomeIcons.envelopeOpenText,
                itemTitle: Translate.subscribeToOurNewsletter.tr,
                itemAction: controller.goToChangeSubscribeScreen,
              ),
              CardSettingsMenuItemWidget(
                icon: FontAwesomeIcons.solidMessage,
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
              const NotificationWidget(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
