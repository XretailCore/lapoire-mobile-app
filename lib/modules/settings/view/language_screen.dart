import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/components/appbar_widget.dart';
import '../../../core/components/text_button_widget.dart';
import '../../../core/localization/lanaguages_enum.dart';
import '../../../core/localization/translate.dart';
import '../controller/language_controller.dart';

class LanguageScreen extends GetView<LanguageController> {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBarWidget(
        title: Translate.language.tr,
        elevation: 1,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Icon(
              Icons.language,
              size: 90,
              color: primaryColor,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: TextButtonWidget(
                text: 'English',
                onPressed: () async =>
                    controller.changeLanguage(context, language: Languages.en),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 200,
              child: TextButtonWidget(
                backgroundColor: Colors.grey[800],
                text: 'العربية',
                onPressed: () async =>
                    controller.changeLanguage(context, language: Languages.ar),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
