import 'package:flutter/material.dart';

import '../../../core/localization/translate.dart';
import 'next_widget.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            enabled: isApply,
            controller: textEditingController,
            textInputAction: TextInputAction.done,
            style: const TextStyle(fontSize: 14),
            maxLines: 1,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: primaryColor),
              ),
              hintText: hintText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: primaryColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: primaryColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: Colors.red),
              ),
            ),
            validator: validator,
          ),
        ),
        const SizedBox(width: 10),
        TextButtonWidget(
          width: 90,
          backgroundColor:
              isApply ? Theme.of(context).primaryColor : Colors.grey[700]!,
          text: isApply ? Translate.apply.tr : Translate.clear.tr,
          onTap: isApply ? onTapApply : onTapClear,
        )
      ],
    );
  }
}
