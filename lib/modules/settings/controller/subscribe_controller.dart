import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/localization/translate.dart';
import '../../../core/utils/helper_functions.dart';

class SubscribeController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailTEC = TextEditingController(text: '');

  Future<void> onTapSubscribe(BuildContext context) async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    await HelperFunctions.errorRequestsSnakBarHandler(
      context,
      loadingFunction: () async {
        await HelperFunctions.errorHandler(context, () async {
          final email = emailTEC.text;
          await LinkTspApi.instance.account.subscribe(email: email);
          HelperFunctions.showSnackBar(
              message: Translate.successed.tr,
              context: context,
              color: Colors.green);
        });
      },
    );
  }

  @override
  void onClose() {
    emailTEC.dispose();
    super.onClose();
  }
}
