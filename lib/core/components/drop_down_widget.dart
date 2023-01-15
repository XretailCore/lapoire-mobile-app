import 'package:flutter/material.dart';
import 'package:imtnan/core/localization/translate.dart';
import '../utils/theme.dart';

class DropDownWidget<T> extends StatefulWidget {
  const DropDownWidget(
      {Key? key, this.defaultValue, this.items = const [], this.onChanged})
      : super(key: key);
  final T? defaultValue;
  final List<DropdownMenuItem<T>> items;
  final void Function(T? v)? onChanged;

  @override
  State<DropDownWidget<T>> createState() => _DropDownWidgetState<T>();
}

class _DropDownWidgetState<T> extends State<DropDownWidget<T>> {
  T? selectedValue;
  @override
  void initState() {
    super.initState();
    selectedValue = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return SizedBox(
      width: double.infinity,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<T>(
          iconEnabledColor: primaryColor,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: primaryColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: primaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: primaryColor),
            ),
          ),
          dropdownColor: Colors.white,
          hint: Text(
            Translate.selectYourZone.tr,
            style: TextStyle(
                fontSize: 14, color: CustomThemes.appTheme.primaryColor),
          ),
          onChanged: (v) => setState(
            () {
              final func = widget.onChanged;
              if (func != null) {
                selectedValue = v;
                func(selectedValue);
              }
            },
          ),
          value: selectedValue,
          items: widget.items,
        ),
      ),
    );
  }
}
