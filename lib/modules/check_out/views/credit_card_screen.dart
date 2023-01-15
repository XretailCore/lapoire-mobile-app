import 'package:cowpay/cowpay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/localization/lanaguages_enum.dart';
import 'package:imtnan/core/utils/custom_shared_prefrenece.dart';
import 'package:imtnan/core/utils/theme.dart';

import '../../../core/components/appbar_widget.dart';
import '../controllers/credit_card_controller.dart';

class CreditCardScreen extends GetView<CreditCardController> {
  const CreditCardScreen({Key? key}) : super(key: key);

// Test Data
  // final String token =
  //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiOTUwMDk3ZGJkYWUyNTYyODdkYWIzMmIxNTlhZGJlYmI2YTljZjhlZDkxNTRiZDU3ZGIzNDMyYjczMjYyN2M0MjIzMDI5ZmY1YTBmY2M5OGQiLCJpYXQiOjE2NDA3Njc4NjMuNDYxNTkzLCJuYmYiOjE2NDA3Njc4NjMuNDYxNTk4LCJleHAiOjQ3OTY0NDE0NjMuMzcxNjc5LCJzdWIiOiI3MjYiLCJzY29wZXMiOltdfQ.U9mGRh-IbnjADOM_PNaf6yaiIZw5D3DOFG3forcsdmUaBJWiG8GhDuRQpqli37BWYsh08Dh54GPRh01ioS-M9Q";
  // final String merchantCode = "kxDhho3YdK1t";
  // final String merchantHash =
  //     "\$2y\$10\$gND.bMeTT52YmlUeK1zyg.IUlJvfV14Xgqit.32G8XC8.uQupFTom";

// live Data
  final String token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiY2E1NmI5Y2QyOTk2ZGJiMWJlY2QyYmJmOTljZDFlMWFlZGI1OTkwZTY5NDI2NGFiNGY0MTc5ZjYxOTdhMWIyNmRmNjU3MGU2MGIxNzllNzkiLCJpYXQiOjE2Mzg5NzA4MjIuNDM2MjI2LCJuYmYiOjE2Mzg5NzA4MjIuNDM2MjMsImV4cCI6NDc5NDY0NDQyMi4zOTE4NjMsInN1YiI6Ijg4NiIsInNjb3BlcyI6W119.cmijpp374r_QCxDOXpyE0Z1Ru36ubvdS7pPOpfU9d1VtnsEQ3qhz6L2f7oHmbNHV0tXt1oP5uYVoaxHstVLNyw";
  final String merchantCode = "kxDhho3YdK1t";
  final String merchantHash =
      "\$2y\$10\$gND.bMeTT52YmlUeK1zyg.IUlJvfV14Xgqit.32G8XC8.uQupFTom";

  @override
  Widget build(BuildContext context) {
    final UserSharedPrefrenceController userSharedPrefrenceController =
        UserSharedPrefrenceController();
    final language = userSharedPrefrenceController.getLanguage;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const AppBarWidget(
          title: 'Credit Card',
        ),
        body: Center(
            child: Cowpay(
          mainColor: CustomThemes.appTheme.primaryColor,
          localizationCode: (Languages.en.name == language)
              ? LocalizationCode.en
              : LocalizationCode.ar,
          amount: controller.finalAmount ?? 0,
          paymentOption: controller.paymentOptionID ?? 0,
          customerEmail: userSharedPrefrenceController.getUserEmail ?? '',
          customerMobile: userSharedPrefrenceController.getUserMobile,
          customerName: userSharedPrefrenceController.getUserFirstName,
          description: "",
          customerMerchantProfileId:
              userSharedPrefrenceController.getUserId.toString(),
          merchantReferenceId: controller.merchantGuid ?? '',
          activeEnvironment: CowpayEnvironment.production,
          merchantCode: merchantCode,
          merchantHash: merchantHash,
          token: token,
          onCreditCardSuccess: (val) {
            debugPrint(val.cowpayReferenceId);
            controller.confirmCowpay();
          },
          onError: (val) {
            debugPrint(val.toString());
          },
          onClosedByUser: () {
            debugPrint("closedByUser");
          },
          onFawrySuccess: (val) {
            controller.fawrySuccess();
          },
        )));
  }
}
