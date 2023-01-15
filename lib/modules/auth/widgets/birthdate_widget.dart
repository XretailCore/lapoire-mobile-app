import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';

class BirthDateWidget extends StatelessWidget {
  const BirthDateWidget({
    Key? key,
    required this.selectedDate,
    this.onChange,
  }) : super(key: key);

  final DateTime selectedDate;
  final dynamic Function(DateTime, List<int>)? onChange;
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          '${Translate.birthdate.tr} :',
          style: TextStyle(color: primaryColor),
        ),
        DatePickerWidget(
          looping: false,
          pickerTheme: DateTimePickerTheme(
            dividerColor: primaryColor,
          ),
          initialDate: selectedDate,
          firstDate: DateTime(1920),
          lastDate: DateTime.now(),
          dateFormat: "dd-MMMM-yyyy",
          onChange: onChange,
        ),
      ],
    );
  }
}
