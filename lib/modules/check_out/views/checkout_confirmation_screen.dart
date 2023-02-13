import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/components/custom_button.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/app_colors.dart';
import '../controllers/checkout_confirmation_controller.dart';

class CheckoutConfirmationScreen
    extends GetView<CheckoutConfirmationController> {
  const CheckoutConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: AppColors.highlighter,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.highlighter,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            SvgPicture.asset('assets/images/confirm-image.svg',color: AppColors.redColor),
            const SizedBox(height: 20),
            CustomText(
              Translate.yourOrderHasBeenPlaced.tr,
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(
                fontSize: 20,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 200),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomText(
                      '${Translate.orderCode.tr} : ${controller.orderCode}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.redColor, fontSize: 12,fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                      Translate
                          .weAreGettingYourOrderReadyToBeShippedWeWillNotifyYouWithDeliveryDate
                          .tr,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomBorderButton(
                      color: AppColors.redColor,
                      radius: 20,
                      title: Translate.continueShopping.tr,
                      onTap: controller.onTapContinueShopping,
                    ),
                    const SizedBox(height: 16),
                    CustomBorderButton(
                      color: AppColors.highlighter,
                      title: Translate.trackYourOrder.tr,
                      borderColor: primaryColor,
                      textColor: primaryColor,
                      radius: 20,
                      onTap: () async => await controller.goToTrackOrder(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
