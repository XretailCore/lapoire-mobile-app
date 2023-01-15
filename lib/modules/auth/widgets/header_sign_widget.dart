import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:toggle_switch/toggle_switch.dart';

class HeaderSignWidget extends StatelessWidget {
  const HeaderSignWidget({
    Key? key,
    this.initialLabelIndex = 0,
    this.onToggle,
    this.labels = const [],
  }) : super(key: key);
  final void Function(int?)? onToggle;
  final int initialLabelIndex;
  final List<String> labels;
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
      color: primaryColor,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/main_logo.png',
            color: Colors.white,
            width: 130,
          ),
          const SizedBox(height: 20),
          ToggleSwitch(
            initialLabelIndex: initialLabelIndex,
            totalSwitches: labels.length,
            activeBgColor: const [Colors.white],
            activeFgColor: primaryColor,
            inactiveFgColor: primaryColor,
            fontSize: 15,
            minWidth: 120,
            cornerRadius: 4,
            inactiveBgColor: const Color.fromRGBO(241, 241, 241, 1),
            labels: labels,
            onToggle: onToggle,
          ),
        ],
      ),
    );
  }
}
