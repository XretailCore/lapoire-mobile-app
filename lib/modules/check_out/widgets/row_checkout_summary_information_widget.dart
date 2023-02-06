import 'package:flutter/material.dart';
import 'package:imtnan/core/utils/app_colors.dart';

import '../../../core/components/custom_text.dart';

class RowCheckOutSummaryInformationWidget extends StatelessWidget {
  const RowCheckOutSummaryInformationWidget({
    Key? key,
    this.isEnableBottomDivider = true,
    this.title = '',
    this.value = '',
    this.isLastIndex = false,
  }) : super(key: key);
  final bool isEnableBottomDivider;
  final String title, value;
  final bool isLastIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          isLastIndex
              ? const Divider(color: AppColors.primaryColor,thickness: 1.5)
              : const SizedBox.shrink(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomText(
                  '$title: ',
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: CustomText(
                  value,
                  softWrap: true,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: isLastIndex ? 14 : 12,
                    color:
                        isLastIndex ? AppColors.redColor : AppColors.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
