import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/theme.dart';

class ButtonsRowWidget extends StatelessWidget {
  final VoidCallback? orderDetailsAction;
  final VoidCallback? trackOrderAction;
  final VoidCallback? cancelOrderAction;
  final String? orderStatus;
  const ButtonsRowWidget({
    Key? key,
    this.orderDetailsAction,
    this.trackOrderAction,
    this.orderStatus,
    this.cancelOrderAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: InkWell(
            onTap: orderDetailsAction,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 7),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: CustomThemes.appTheme.primaryColor),
                borderRadius: BorderRadius.circular(5),
              ),
              child: CustomText(
                Translate.details.name.tr,
                style: TextStyle(
                  color: CustomThemes.appTheme.primaryColor,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: InkWell(
            onTap: trackOrderAction,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 7),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: CustomThemes.appTheme.primaryColor),
                borderRadius: BorderRadius.circular(5),
              ),
              child: CustomText(
                Translate.track.name.tr,
                style: TextStyle(
                  color: CustomThemes.appTheme.primaryColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
