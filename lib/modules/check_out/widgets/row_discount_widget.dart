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
    this.validator, this.textInputType,
  }) : super(key: key);
  final String hintText;
  final TextEditingController? textEditingController;
  final bool isApply;
  final TextInputType? textInputType;
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
            keyboardType: textInputType,
            enabled: isApply,
            controller: textEditingController,
            textInputAction: TextInputAction.done,
            style: const TextStyle(fontSize: 14),
            maxLines: 1,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: primaryColor),
              ),
              hintText: hintText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: primaryColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: primaryColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red),
              ),
            ),
            validator: validator,
          ),
        ),
        const SizedBox(width: 10),
        CustomBorderButton(
          radius: 30,
          textColor: Colors.white,
          color:
          isApply ? Theme.of(context).primaryColor : Colors.grey[700]!,
          title: isApply ? Translate.apply.tr : Translate.clear.tr,
          onTap: isApply ? onTapApply : onTapClear,
        )
      ],
    );
  }
}
