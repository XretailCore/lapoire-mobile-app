import 'package:flutter/material.dart';

import '../../../core/components/custom_text.dart';

class StepperWidget extends StatelessWidget {
  const StepperWidget(
      {Key? key,
      this.currentIndex = -1,
      this.unSelectedColor = Colors.transparent,
      this.selectedColor = Colors.white,
      required this.steps})
      : assert(currentIndex >= -1 && currentIndex < steps.length),
        super(key: key);
  final List<String> steps;

  /// -1 = no selected
  final int currentIndex;
  final Color unSelectedColor;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: steps
            .mapIndexed(
              (v, index) => Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _changeColor(index), width: 1.3),
                ),
                child: CustomText(
                  v,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Color _changeColor(int index) {
    return _isEqualCurrentIndex(index) ? selectedColor : unSelectedColor;
  }

  bool _isEqualCurrentIndex(int index) => index == currentIndex;
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}
