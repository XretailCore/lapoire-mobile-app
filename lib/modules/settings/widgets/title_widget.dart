import 'package:flutter/material.dart';

import '../../../core/components/custom_text.dart';

class TitlesWidget extends StatelessWidget {
  final String title;
  const TitlesWidget({Key? key, this.title = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: CustomText(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}
