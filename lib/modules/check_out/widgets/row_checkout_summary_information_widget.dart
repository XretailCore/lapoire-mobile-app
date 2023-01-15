import 'package:flutter/material.dart';

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomText(
                '$title: ',
                softWrap: true,
                style: const TextStyle(
                  fontSize: 10,
                  color: Color.fromRGBO(63, 63, 63, 1),
                ),
              ),
            ),
            Expanded(
              child: CustomText(
                value,
                softWrap: true,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontSize: 10,
                  color: Color.fromRGBO(63, 63, 63, 1),
                ),
              ),
            ),
          ],
        ),
        if (isEnableBottomDivider && !isLastIndex)
          const Divider(
            height: 20,
            indent: 4,
            endIndent: 4,
            thickness: 1,
          ),
      ],
    );
  }
}
