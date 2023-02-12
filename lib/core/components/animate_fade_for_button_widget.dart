import 'package:flutter/material.dart';

class AnimateFadeForButtonWidget extends StatefulWidget {
  const AnimateFadeForButtonWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  State<AnimateFadeForButtonWidget> createState() =>
      _AnimateFadeForButtonWidgetState();
}

class _AnimateFadeForButtonWidgetState extends State<AnimateFadeForButtonWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween(begin: 0.5, end: 1.0).animate(controller),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
