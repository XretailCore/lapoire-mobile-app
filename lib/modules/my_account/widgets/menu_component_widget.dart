import 'package:flutter/material.dart';

class MenuComponentWidget extends StatelessWidget {
  const MenuComponentWidget({Key? key, this.children = const <Widget>[]})
      : super(key: key);
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(242, 242, 242, 1),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}
