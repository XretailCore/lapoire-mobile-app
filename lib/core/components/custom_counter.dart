import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import 'custom_text.dart';

class CounterPart extends StatelessWidget {
  final bool disable;
  final Function()? onTap;
  final IconData icon;

  // ignore: use_key_in_widget_constructors
  const CounterPart(this.disable, this.onTap, this.icon);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disable || onTap == null ? () {} : onTap,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Icon(icon,
            size: 15,
            color:
                disable || onTap == null ? Colors.black : AppColors.redColor),
      ),
    );
  }
}

class CounterWidget extends StatelessWidget {
  final int count;
  final int? maxCount;
  final Function()? increment;
  final Function()? decrement;

  // ignore: use_key_in_widget_constructors
  const CounterWidget(
      {this.count = 1,
      required this.increment,
      required this.decrement,
      this.maxCount});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => DottedBorder(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        radius: const Radius.circular(20.0),
        borderType: BorderType.RRect,
        color: AppColors.redColor,
        child: Row(
          children: [
            CounterPart((count == 1), decrement, Icons.remove),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: CustomText(
                count.toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: AppColors.redColor),
              ),
            ),
            CounterPart(
                (maxCount != null && count == maxCount), increment, Icons.add),
          ],
        ),
      ),
    );
  }
}
