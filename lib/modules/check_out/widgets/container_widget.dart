import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({
    Key? key,
    required this.child,
    this.color,
    this.padding,
    this.image,
    this.radius = 30,
  }) : super(key: key);
  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final DecorationImage? image;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 4),
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          image: image,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            topRight: Radius.circular(radius),
          ),
          color: color ?? Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 1,
              spreadRadius: 1,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
