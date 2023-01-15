import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/components/location_widget.dart';
import '../../../core/utils/enums.dart';
import '../../cart/controllers/cart_controller.dart';

class HomeAppBarWidget extends GetView<CartController> {
  const HomeAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            LocationWidget(
              pageName: MapPages.homeScreen.name,
            ),
          ],
        ),
      ),
    );
  }
}
