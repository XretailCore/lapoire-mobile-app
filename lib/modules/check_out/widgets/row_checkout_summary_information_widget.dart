import 'package:flutter/material.dart';
import 'package:imtnan/core/utils/app_colors.dart';

import '../../../core/components/custom_text.dart';

class RowCheckOutSummaryInformationWidget extends StatelessWidget {
  const RowCheckOutSummaryInformationWidget({
    Key? key,
    this.isEnableBottomDivider = true,
    this.title = '',
    this.additionalInfo,
    this.value = '',
    this.isLastIndex = false,
    this.currencySymbol = '',
  }) : super(key: key);
  final bool isEnableBottomDivider;
  final String title, value, currencySymbol;
  final bool isLastIndex;
  final String? additionalInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          isLastIndex
              ? const Divider(color: AppColors.primaryColor, thickness: 1.5)
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
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(
                     "${additionalInfo!=null? "($additionalInfo) ":""}${!value.contains(RegExp(r'[0-9]'))
                          ? value
                          : double.parse(value).toStringAsFixed(
                              double.parse(value).truncateToDouble() ==
                                      double.parse(value)
                                  ? 0
                                  : 1)}",
                      softWrap: true,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: isLastIndex ? 14 : 12,
                        color: isLastIndex
                            ? AppColors.redColor
                            : AppColors.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width:!value.contains(RegExp(r'[0-9]'))?0.0:4.0),
                    CustomText(
                      currencySymbol,
                      softWrap: true,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: isLastIndex ? 14 : 12,
                        color: isLastIndex
                            ? AppColors.redColor
                            : AppColors.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
