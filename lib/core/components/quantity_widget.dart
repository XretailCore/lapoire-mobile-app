import 'package:flutter/material.dart';
import 'package:imtnan/core/utils/app_colors.dart';

import 'custom_text.dart';

class QuantityButton extends StatefulWidget {
  final int initialQuantity, maxQuantity;
  final Future<int>? Function(int) onQuantityChange;
  final double? height;
  const QuantityButton(
      {Key? key,
      this.height,
      required this.initialQuantity,
      this.maxQuantity = 99,
      required this.onQuantityChange})
      : super(key: key);

  @override
  _QuantityButtonState createState() => _QuantityButtonState();
}

class _QuantityButtonState extends State<QuantityButton> {
  int quantity = 1;
  bool isSaving = false;
  _QuantityButtonState();
  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
  }

  void changeQuantity(int newQuantity) async {
    setState(() {
      isSaving = true;
    });
    newQuantity = await widget.onQuantityChange(newQuantity) ?? newQuantity;
    setState(() {
      quantity = newQuantity;
      isSaving = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var primaryColor = AppColors.redColor;
    return SizedBox(
      height: widget.height,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 30,
            height: 30,
            child: IconButton(
              padding: const EdgeInsets.all(0),
              color: primaryColor,
              onPressed: (isSaving || quantity <= widget.initialQuantity)
                  ? null
                  : () => changeQuantity(quantity - 1),
              icon:  Icon(
                Icons.remove,
                color: primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 20,
            child: CustomText(
              quantity == 0 ? "1" : quantity.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.redColor),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 30,
            height: 30,
            child: IconButton(
              padding: const EdgeInsets.all(0),
              color: primaryColor,
              onPressed: (isSaving || quantity >= widget.maxQuantity)
                  ? null
                  : () => changeQuantity(quantity + 1),
              icon: const Icon(
                Icons.add,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
