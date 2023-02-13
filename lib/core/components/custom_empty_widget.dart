import 'package:flutter/material.dart';
import 'package:imtnan/core/components/custom_button.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import '../localization/translate.dart';
import '../utils/theme.dart';
import 'custom_text.dart';

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
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: CustomBorderButton(
                  radius: 40,
                  color: AppColors.redColor,
                  title: buttonLabel ?? Translate.continueShopping.tr,
                  onTap: emptyBtnAction ?? () {},
                ),
              ),
          ],
        ),
      ),
    );
  }
}
