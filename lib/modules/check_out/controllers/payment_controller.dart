import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/utils/shipment_methods.dart';
import 'delivery_controller.dart';

class PaymentController extends GetxController
    with StateMixin<List<PaymentOptionsModel>> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  set isPreOrder(bool isPreOrder) => _isPreOrder = isPreOrder;
  bool _isPreOrder = false;
  int? paymentOptionId;
  final DeliveryController _deliveryController = Get.find<DeliveryController>();

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    try {
      change(null, status: RxStatus.loading());
      final payments = await LinkTspApi.instance.checkOut.getPaymentOptions();
      if (payments.isNotEmpty) {
        if (Platform.isAndroid) {
          payments.removeWhere((element) => element.id == 4);
        }
        if (_isPreOrder ||
            _deliveryController.selectedShipmentMethods ==
                ShipmentMethods.pickAtStore) {
          payments.removeWhere((element) => element.id == 1);
        }

        paymentOptionId = payments.first.id;
      }
      change(payments, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error());
    }
  }
}
