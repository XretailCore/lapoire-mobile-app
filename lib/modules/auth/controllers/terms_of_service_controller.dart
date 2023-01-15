import 'package:get/get.dart';
import '../../../core/utils/helper_functions.dart';
import 'package:linktsp_api/linktsp_api.dart';

class TermsOfServiceController extends GetxController with StateMixin<String> {
  @override
  void onReady() {
    super.onReady();
    getConctentPageData();
  }

  Future<void> getConctentPageData() async {
    await HelperFunctions.errorRequestsHandler<String>(
      loadingFunction: () async {
        change(null, status: RxStatus.loading());
        final content = await LinkTspApi.instance.setting.getServiceAgreement();
        return content;
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
      onSuccessFunction: (content) async {
        change(content, status: RxStatus.success());
      },
    );
  }
}
