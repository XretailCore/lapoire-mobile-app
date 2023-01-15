import 'package:imtnan/core/utils/helper_functions.dart';

import '../../../core/utils/strings.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';

class TrackOrderController extends GetxController
    with StateMixin<TrackOrderModel?> {
  bool lastItem = false;
  @override
  void onReady() {
    super.onReady();
    getTrackOrderList();
  }

  Future<void> getTrackOrderList() async {
    await HelperFunctions.errorRequestsHandler<TrackOrderModel>(
      loadingFunction: () async {
        change(null, status: RxStatus.loading());
        final args = Get.arguments as Map;
        final orderCode = args[Arguments.orderNo] as String;
        final trackOrderModel =
            await LinkTspApi.instance.order.trackOrder(orderCode: orderCode);
        return trackOrderModel;
      },
      onSuccessFunction: (trackOrderModel) async {
        change(trackOrderModel, status: RxStatus.success());
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
  }
}
