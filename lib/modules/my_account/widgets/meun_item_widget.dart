import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/components/custom_text.dart';

class MenuItemWidget extends StatelessWidget {
  final IconData icon;
  final String? title;
  final VoidCallback? onTap;
  const MenuItemWidget({
    Key? key,
    required this.icon,
    this.onTap,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(color: primaryColor),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 30,
                child: FaIcon(
                  icon,
                  size: 20,
                  color: primaryColor,
                ),
              ),
              const SizedBox(width: 10),
              CustomText(
                title ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.chevron_right,
                color: primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
