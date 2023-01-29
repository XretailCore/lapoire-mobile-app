import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'custom_text.dart';

class ExpansionTileWidget extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final bool initiallyExpanded;
  final void Function(bool)? onExpansionChanged;

  const ExpansionTileWidget({
    Key? key,
    required this.title,
    this.children = const <Widget>[],
    this.initiallyExpanded = false,
    this.onExpansionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.redColor),
      ),
      child: ExpansionTile(
        key: UniqueKey(),
        onExpansionChanged: onExpansionChanged,
        initiallyExpanded: initiallyExpanded,
        childrenPadding:
            const EdgeInsetsDirectional.only(start: 20, end: 20, bottom: 8),
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        title: CustomText(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.redColor,
          ),
        ),
        collapsedIconColor: AppColors.redColor,
        textColor: primaryColor,
        collapsedTextColor: AppColors.redColor,
        iconColor: AppColors.redColor,
        children: children,
      ),
    );
  }
}
