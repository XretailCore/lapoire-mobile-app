import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/routes.dart';

class PrivacyCheckBoxWidget extends StatefulWidget {
  const PrivacyCheckBoxWidget({
    Key? key,
    required this.onChanged,
  }) : super(key: key);
  final void Function(bool) onChanged;
  @override
  State<PrivacyCheckBoxWidget> createState() => _PrivacyCheckBoxWidgetState();
}

class _PrivacyCheckBoxWidgetState extends State<PrivacyCheckBoxWidget> {
  bool ischecked = false;
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Row(
      children: [
        Checkbox(
          value: ischecked,
          activeColor: primaryColor,
          onChanged: (v) {
            setState(
              () {
                ischecked = v ?? false;
                widget.onChanged(ischecked);
              },
            );
          },
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              Get.toNamed(Routes.termsOfServiceScreen);
            },
            child: CustomText(
              Translate.iHaveReadAndAgreedOnTheTermsAndConditionsOfTheApp.tr,
              softWrap: true,
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: primaryColor,
                  fontSize: 10),
            ),
          ),
        ),
      ],
    );
  }
}
