import 'package:flutter/material.dart';
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
    const grey = Color.fromRGBO(96, 96, 96, 1);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Colors.grey),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
          style: const TextStyle(fontSize: 12, color: grey),
        ),
        collapsedIconColor: grey,
        textColor: primaryColor,
        collapsedTextColor: grey,
        iconColor: primaryColor,
        children: children,
      ),
    );
  }
}
