import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../../core/utils/theme.dart';

import '../../../core/components/custom_error_widget.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/components/text_button_widget.dart';
import '../../../core/localization/translate.dart';
import '../controllers/pre_booking_policy_controller.dart';

class PreBookingPolicyWidget extends GetView<PreBookingPolicyController> {
  const PreBookingPolicyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: .4.sh,
              width: .99.sw,
              child: SingleChildScrollView(
                child: HtmlWidget(
                  state ?? '',
                ),
              ),
            ),
            Row(
              children: [
                Obx(
                  () => Checkbox(
                    fillColor: MaterialStateColor.resolveWith((states) =>
                        controller.isAgree
                            ? Theme.of(context).primaryColor
                            : Colors.grey),
                    value: controller.isAgree,
                    onChanged: (v) {
                      controller.isAgree = v ?? false;
                    },
                  ),
                ),
                Expanded(
                  child: CustomText(
                    Translate
                        .iHaveReadAndAgreedOnTheTermsAndConditionsOfTheApp.tr,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Obx(
                () => TextButtonWidget(
                  padding: const EdgeInsets.symmetric(horizontal: 90),
                  backgroundColor: controller.isAgree ? null : Colors.grey,
                  text: 'Agree',
                  onPressed: () async =>
                      controller.onTapAgree(controller.isAgree),
                ),
              ),
            ),
          ],
        ),
      ),
      onError: (e) => CustomErrorWidget(
        errorText: e,
        onReload: controller.getPreBookingPolicy,
      ),
      onLoading: Center(
        child: CircularProgressIndicator(
            color: CustomThemes.appTheme.primaryColor),
      ),
    );
  }
}
