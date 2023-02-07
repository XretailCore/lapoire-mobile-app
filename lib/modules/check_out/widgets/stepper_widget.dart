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
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                          thickness: 3,
                          color: currentIndex == 0
                              ? AppColors.primaryColor
                              : AppColors.redColor),
                    ),
                    Expanded(
                      child: Divider(
                          thickness: 3,
                          color: currentIndex == 2
                              ? AppColors.redColor
                              : AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                stepperItem(color: AppColors.redColor, title: steps[0]),
                stepperItem(color: currentIndex==0?AppColors.primaryColor:AppColors.redColor, title: steps[1]),
                stepperItem(color: currentIndex==2?AppColors.redColor:AppColors.primaryColor, title: steps[2]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget stepperItem({required Color color, required String title}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: color, width: 1.3),
      ),
      child: CustomText(
        title,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }
}
