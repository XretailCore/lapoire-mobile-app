import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/components/custom_error_widget.dart';
import 'package:imtnan/core/utils/theme.dart';

import '../../../core/components/custom_appbar.dart';
import '../../../core/components/imtnan_loading_widget.dart';
import '../controllers/content_controller.dart';

class ContentScreen extends GetView<ContentPagesController> {
  const ContentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: controller.contentPageTitle ?? "",
        showBackButton: true,
        showAction: false,
      ),
      body: controller.obx(
        (data) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HtmlWidget(
                  data?.content ?? "",
                  textStyle:
                      TextStyle(color: CustomThemes.appTheme.primaryColor),
                ),
              ],
            ),
          ),
        ),
        onLoading: const CustomLoadingWidget(),
        onError: (e) => CustomErrorWidget(
          errorText: e,
          onReload: controller.getConctent,
        ),
      ),
    );
  }
}
