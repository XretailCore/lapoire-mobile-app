import 'package:flutter/material.dart';
import 'package:imtnan/core/utils/theme.dart';

import '../../../core/components/custom_text.dart';

class GenderRadioGroupWidget extends StatefulWidget {
  const GenderRadioGroupWidget({
    Key? key,
    this.children = const <String>[],
    required this.onChanged,
    this.defaultGender,
  }) : super(key: key);
  final List<String> children;
  final void Function(int? gender) onChanged;
  final int? defaultGender;
  @override
  State<GenderRadioGroupWidget> createState() => _GenderRadioGroupWidgetState();
}

class _GenderRadioGroupWidgetState extends State<GenderRadioGroupWidget> {
  int? selected;
  @override
  void initState() {
    super.initState();
    if (widget.children.isNotEmpty) {
      selected = widget.defaultGender;
      widget.onChanged(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.children.length,
        itemBuilder: (_, index) {
          final child = widget.children.elementAt(index);
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<int?>(
                value: index,
                groupValue: selected,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (v) {
                  widget.onChanged(v!);
                  setState(() {
                    selected = index;
                  });
                },
              ),
              CustomText(
                child,
                style: TextStyle(color: CustomThemes.appTheme.primaryColor,fontWeight: FontWeight.w400),
              ),
            ],
          );
        },
      ),
    );
  }
}
