import 'package:flutter/material.dart';

import '../../../core/components/custom_text.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {Key? key, this.title = '', this.description = '', required this.onTap})
      : super(key: key);
  final String title, description;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(2),
          padding: const EdgeInsets.fromLTRB(6, 8, 6, 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            // border: Border.all(color: Colors.grey, width: 0.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    CustomText(
                      description,
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 30),
              const Icon(Icons.navigate_next, size: 30),
            ],
          ),
        ),
      ),
    );
  }
}
