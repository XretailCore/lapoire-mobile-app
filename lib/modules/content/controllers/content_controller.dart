import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/utils/helper_functions.dart';
import '../../../core/utils/strings.dart';

class ContentPagesController extends GetxController
    with StateMixin<ContentPageModel> {
  String? htmlData;
  String? contentPageTitle;
  int? contentPageId;

  @override
  void onInit() {
    super.onInit();
    getConctent();
  }

  Future<void> getConctent() async {
    var args = (Get.arguments ?? {}) as Map;
    contentPageTitle = args[Arguments.contentPageTitle] ?? "";
    contentPageId = args[Arguments.contentPageId];

    if (contentPageId != null) {
      await getConctentPageData(contentPageId!);
    } else {
      change(null, status: RxStatus.empty());
    }
  }

  Future<void> getConctentPageData(int contentPageId) async {
    await HelperFunctions.errorRequestsHandler<ContentPageModel>(
      loadingFunction: () async {
        change(null, status: RxStatus.loading());
        final contentPage = await LinkTspApi.instance.contentPage
            .getContentPage(id: contentPageId);
        return contentPage;
      },
      onSuccessFunction: (contentPage) async {
        if (contentPage.id != null) {
          htmlData = contentPage.content;
          change(contentPage, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.empty());
        }
      },
      onDioErrorFunction: (e, m) async {
        change(null, status: RxStatus.error(m));
      },
      onUnexpectedErrorFunction: (e, m) async {
        change(null, status: RxStatus.error(m));
      },
      onApiErrorFunction: (e, m) async {
        change(null, status: RxStatus.error(e.message.toString()));
      },
    );
    return;
  }
}
