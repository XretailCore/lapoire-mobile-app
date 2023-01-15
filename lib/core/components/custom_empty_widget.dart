import 'package:flutter/material.dart';
import '../localization/translate.dart';
import '../utils/theme.dart';
import 'custom_text.dart';
import 'text_button_widget.dart';

class CustomEmptyWidget extends StatelessWidget {
  final String? emptyLabel;
  final String? buttonLabel;
  final VoidCallback? emptyBtnAction;
  const CustomEmptyWidget({
    Key? key,
    this.emptyBtnAction,
    this.emptyLabel,
    this.buttonLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              emptyLabel ?? '',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: CustomThemes.appTheme.colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 20),
            if (emptyBtnAction != null)
              TextButtonWidget(
                padding: const EdgeInsets.all(10),
                onPressed: emptyBtnAction ?? () {},
                text: buttonLabel ?? Translate.continueShopping.tr,
              ),
          ],
        ),
      ),
    );
  }
}
