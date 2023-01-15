import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:get/get.dart';
import 'package:imtnan/modules/order_details/controllers/order_details_controller.dart';

import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/routes.dart';
import '../../../core/utils/strings.dart';
import '../../cart/controllers/cart_controller.dart';
import 'shipping_information_controller.dart';

class CheckoutConfirmationController extends GetxController {
  String? orderCode;

  final facebookAppEvents = FacebookAppEvents();

  @override
  void onInit() {
    super.onInit();
    purchaseCheckoutFBEvent();
  }

  Future<void> purchaseCheckoutFBEvent() async {
    final cartController = Get.find<CartController>();
    final shippingInformationController =
        Get.find<ShippingInformationController>();
    facebookAppEvents.logPurchase(
      amount: shippingInformationController.checkoutReviewModel.total ?? 0,
      currency: 'EGP',
      parameters: {
        'fb_content_type': 'product_group',
        'fb_content_id': '${cartController.cartItemsIds}',
        'fb_num_items': cartController.cartItemsIds.length,
      },
    );
  }

  void onTapContinueShopping() {
    final UserSharedPrefrenceController _userSharedPrefrenceController =
        Get.find<UserSharedPrefrenceController>();
    _userSharedPrefrenceController.removeCart();
    final cartController = Get.find<CartController>();

    cartController.getCart();
    Get.offAllNamed(Routes.dashboard);
  }

  Future<void> goToTrackOrder() async {
    final orderDetailsController = Get.find<OrderDetailsController>();
    orderDetailsController.isCheckoutCancel.value = true;
    Get.offAllNamed(
      Routes.orderDetails,
      arguments: {
        Arguments.orderNo: orderCode,
        Arguments.isCheckoutCancel: true,
      },
    );
  }
}
