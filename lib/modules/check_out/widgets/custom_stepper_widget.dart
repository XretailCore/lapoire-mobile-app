import 'package:flutter/material.dart';

import '../../../core/localization/translate.dart';
import 'stepper_widget.dart';

class CustomStepperWidget extends StatelessWidget {
  const CustomStepperWidget({
    Key? key,
    this.currentIndex = -1,
  }) : super(key: key);
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: StepperWidget(
        currentIndex: currentIndex,
        steps: [
          Translate.delivery.tr,
          Translate.payment.tr,
          Translate.summary.tr,
        ],
      ),
    );
  }
}
