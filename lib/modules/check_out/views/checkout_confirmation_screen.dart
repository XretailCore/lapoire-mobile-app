import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/components/custom_button.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/lanaguages_enum.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../controllers/checkout_confirmation_controller.dart';

class CheckoutConfirmationScreen
    extends GetView<CheckoutConfirmationController> {
  const CheckoutConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final language = Get.find<UserSharedPrefrenceController>().getLanguage;
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: AppColors.highlighter,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset('assets/images/confirm-image.svg',
                color: AppColors.redColor),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  Translate.yourOrderHasBeenPlaced.tr,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 20,
                    color: primaryColor,
                    height: 1.25,
                    fontFamily: language == Languages.ar.name ? 'Cairo' : "Gilroy",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 24),
                CustomText(
                  '${Translate.orderCode.tr} : ${controller.orderCode}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: AppColors.redColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 16),
                Text(
                  Translate
                      .weAreGettingYourOrderReadyToBeShippedWeWillNotifyYouWithDeliveryDate
                      .tr,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: primaryColor,
                    height: 1.5
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 200),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
