import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/components/text_button_widget.dart';
import '../../../core/localization/translate.dart';
import '../controllers/checkout_confirmation_controller.dart';

class CheckoutConfirmationScreen
    extends GetView<CheckoutConfirmationController> {
  const CheckoutConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            SvgPicture.asset('assets/images/confirm-image.svg'),
            const SizedBox(height: 20),
            CustomText(
              Translate.yourOrderHasBeenPlaced.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(139, 139, 139, 1),
              ),
            ),
            const SizedBox(height: 8),
            CustomText(
              Translate.successed.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(139, 139, 139, 1),
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
                      style: TextStyle(color: primaryColor, fontSize: 11),
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                      Translate
                          .weAreGettingYourOrderReadyToBeShippedWeWillNotifyYouWithDeliveryDate
                          .tr,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 11,
                        height: 1.5,
                        color: Color.fromRGBO(161, 161, 161, 1),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButtonWidget(
                      text: Translate.trackYourOrder.tr,
                      onPressed: () async => await controller.goToTrackOrder(),
                    ),
                    TextButtonWidget(
                      backgroundColor: Colors.grey[800],
                      text: Translate.continueShopping.tr,
                      onPressed: controller.onTapContinueShopping,
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
