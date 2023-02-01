import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/components/custom_button.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/app_colors.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomBorderButton(
          onTap: orderDetailsAction,
          radius: 20,
          color: AppColors.redColor,
          title: Translate.details.name.tr,
        ),
        const SizedBox(height: 8),
        CustomBorderButton(
          onTap: trackOrderAction,
          radius: 20,
          color: AppColors.redColor,
          title: Translate.track.name.tr,
        ),
      ],
    );
  }
}
