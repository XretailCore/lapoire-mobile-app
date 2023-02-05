import 'package:flutter/material.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import '../../../core/components/custom_text.dart';

class StepperWidget extends StatelessWidget {
  const StepperWidget(
      {Key? key,
      this.currentIndex = -1,
      this.unSelectedColor = AppColors.primaryColor,
      this.selectedColor = AppColors.redColor,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0),
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Stack(
          children: [
            const Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Divider(thickness: 3, color: AppColors.primaryColor),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: steps
                  .mapIndexed(
                    (v, index) => steps[index].isEmpty
                        ? Container(
                            height: 5,
                            width: 30,
                            color: Colors.transparent,
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            decoration: BoxDecoration(
                              color: _changeColor(index),
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(
                                  color: _changeColor(index), width: 1.3),
                            ),
                            child: CustomText(
                              v,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                  )
                  .toList(),
            ),
          ],
        ),
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
