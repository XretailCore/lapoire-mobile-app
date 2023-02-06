import 'package:flutter/material.dart';
import 'package:imtnan/core/components/custom_button.dart';

import '../../../core/localization/translate.dart';

class RowDiscountWidget extends StatelessWidget {
  const RowDiscountWidget({
    Key? key,
    this.hintText = '',
    this.textEditingController,
    this.isApply = true,
    this.onTapApply,
    this.onTapClear,
    this.validator,
  }) : super(key: key);
  final String hintText;
  final TextEditingController? textEditingController;
  final bool isApply;
  final VoidCallback? onTapApply, onTapClear;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              enabled: isApply,
              controller: textEditingController,
              textInputAction: TextInputAction.done,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: primaryColor,
              ),
              maxLines: 1,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: primaryColor,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: hintText,
                enabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
              validator: validator,
            ),
          ),
          const SizedBox(width: 10),
          CustomBorderButton(
            textColor: Colors.white,
            radius: 20.0,
            color: isApply ? Theme.of(context).primaryColor : Colors.grey[700]!,
            title: isApply ? Translate.apply.tr : Translate.clear.tr,
            onTap: isApply ? onTapApply : onTapClear,
          )
        ],
      ),
    );
  }
}
