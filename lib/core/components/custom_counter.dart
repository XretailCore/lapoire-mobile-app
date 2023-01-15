import 'package:flutter/material.dart';
import '../utils/theme.dart';
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
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        decoration: BoxDecoration(
          color: disable || onTap == null
              ? Colors.grey.withOpacity(.6)
              : CustomThemes.appTheme.primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(icon,
            size: 15,
            color: disable || onTap == null ? Colors.black : Colors.white),
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
        builder: (context, setState) => Row(children: [
              CounterPart((count == 1), decrement, Icons.remove),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                child: CustomText(
                  count.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              CounterPart((maxCount != null && count == maxCount), increment,
                  Icons.add),
            ]));
  }
}
