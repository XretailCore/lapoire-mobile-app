import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_text.dart';
import '../controllers/cart_controller.dart';

class CartSummaryWidget extends GetView<CartController> {
  const CartSummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final summary = controller.cartSummaryResult.value.summary;
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(),
          child: Column(
              children: List.generate(
                  summary?.length ?? 0,
                  (index) => CartSummaryInfoWidget(
                      title: "${summary?[index].title}:",
                      subTitle:
                          "${summary?[index].value} ${summary?[index].currencySymbol ?? ''}"))),
        );
      },
    );
  }
}

class CartSummaryInfoWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  const CartSummaryInfoWidget(
      {Key? key, required this.title, required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: CustomText(
              title,
              style: const TextStyle(
                fontSize: 10,
                color: Color.fromRGBO(63, 63, 63, 1),
              ),
              softWrap: true,
            ),
          ),
          const Spacer(),
          CustomText(
            subTitle,
            style: const TextStyle(
              fontSize: 10,
              color: Color.fromRGBO(63, 63, 63, 1),
            ),
            softWrap: true,
          ),
        ],
      ),
    );
  }
}
