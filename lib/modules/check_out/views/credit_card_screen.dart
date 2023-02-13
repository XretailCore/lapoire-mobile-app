import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/components/appbar_widget.dart';
import '../../../core/localization/translate.dart';
import '../controllers/credit_card_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CreditCardScreen extends GetView<CreditCardController> {
  const CreditCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarWidget(
        title: Translate.creditCard.tr,
      ),
      body: WebView(
        navigationDelegate: (NavigationRequest request) {
          controller.checkPaymentSuccessUrl(request.url);
          return NavigationDecision.navigate;
        },
        allowsInlineMediaPlayback: true,
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: controller.paymentModel?.frame,
      ),
    );
  }
}
