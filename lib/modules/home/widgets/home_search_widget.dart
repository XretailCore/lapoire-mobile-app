import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/theme.dart';
import '../../cart/controllers/cart_controller.dart';
import '../controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeSearchWidget extends GetView<CartController> {
  final Function()? onMenuTap;
  const HomeSearchWidget({
    Key? key,
    required this.onMenuTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onMenuTap,
          child: Icon(
            Icons.menu,
            color: CustomThemes.appTheme.colorScheme.secondary,
          ),
        ),
        const SizedBox(width: 15),
        const Expanded(child: SearchContainerWidget()),
        const SizedBox(width: 15),
        // const CartIconWithCounterWidget(),
      ],
    );
  }
}

class CartIconWithCounterWidget extends GetView<HomeController> {
  const CartIconWithCounterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CounterBadgeWidget extends GetView<CartController> {
  const CounterBadgeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Offstage(
        offstage: (controller.cartCounter.value <= 0),
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: CustomThemes.appTheme.colorScheme.secondary,
          ),
          child: CustomText(
            controller.cartCounter.value.toString(),
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class SearchContainerWidget extends GetView<HomeController> {
  const SearchContainerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.goToSearch(),
      child: Card(
        elevation: 2,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Row(
            children: [
              CustomText(
                Translate.searchHere.tr,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.search,
                size: 16,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
