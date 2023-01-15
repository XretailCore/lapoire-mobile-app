import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../../core/components/custom_error_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/components/custom_appbar.dart';
import '../../../core/components/imtnan_loading_widget.dart';
import '../../../core/localization/translate.dart';
import '../controllers/terms_of_service_controller.dart';

class TermsOfSerivceScreen extends GetView<TermsOfServiceController> {
  const TermsOfSerivceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomTitledAppBar(
        title: Translate.termsOfService.tr,
      ),
      body: controller.obx(
        (contentPageModel) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: HtmlWidget(
              contentPageModel ?? '',
              onTapUrl: (url) async {
                final uri = Uri.parse(url);
                final isLaunched = await canLaunchUrl(uri);
                if (isLaunched) await launchUrl(uri);
                return isLaunched;
              },
            ),
          ),
        ),
        onLoading: const CustomLoadingWidget(),
        onError: (e) => CustomErrorWidget(
          errorText: e,
          onReload: controller.getConctentPageData,
        ),
      ),
    );
  }
}
