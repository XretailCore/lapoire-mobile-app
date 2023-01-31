import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  Color? _color = Colors.white;

  RPSCustomPainter(Color color) {
    _color = color;
  }
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5000056, size.height);
    path_0.arcToPoint(Offset(size.width * 0.4261833, size.height * 0.9695327),
        radius:
            Radius.elliptical(size.width * 0.1036290, size.height * 0.1036290),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * 0.4146839, size.height * 0.9580333);
    path_0.arcToPoint(Offset(size.width * 0.2364711, size.height * 0.8842110),
        radius:
            Radius.elliptical(size.width * 0.2897020, size.height * 0.2897020),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.lineTo(size.width * 0.2201906, size.height * 0.8842110);
    path_0.arcToPoint(Offset(size.width * 0.1157778, size.height * 0.7798206),
        radius:
            Radius.elliptical(size.width * 0.1047151, size.height * 0.1047151),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * 0.1157778, size.height * 0.7635289);
    path_0.arcToPoint(Offset(size.width * 0.04195546, size.height * 0.5853273),
        radius:
            Radius.elliptical(size.width * 0.2896461, size.height * 0.2896461),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.lineTo(size.width * 0.03045606, size.height * 0.5738167);
    path_0.arcToPoint(Offset(size.width * 0.03045606, size.height * 0.4261609),
        radius:
            Radius.elliptical(size.width * 0.1047263, size.height * 0.1047263),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * 0.04195546, size.height * 0.4146615);
    path_0.arcToPoint(Offset(size.width * 0.1157778, size.height * 0.2364487),
        radius:
            Radius.elliptical(size.width * 0.2897580, size.height * 0.2897580),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.lineTo(size.width * 0.1157778, size.height * 0.2201794);
    path_0.arcToPoint(Offset(size.width * 0.2201906, size.height * 0.1157778),
        radius:
            Radius.elliptical(size.width * 0.1047151, size.height * 0.1047151),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * 0.2364599, size.height * 0.1157778);
    path_0.arcToPoint(Offset(size.width * 0.4146727, size.height * 0.04194426),
        radius:
            Radius.elliptical(size.width * 0.2896685, size.height * 0.2896685),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.lineTo(size.width * 0.4261721, size.height * 0.03044486);
    path_0.arcToPoint(Offset(size.width * 0.5738167, size.height * 0.03044486),
        radius:
            Radius.elliptical(size.width * 0.1047263, size.height * 0.1047263),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * 0.5853161, size.height * 0.04194426);
    path_0.arcToPoint(Offset(size.width * 0.7635513, size.height * 0.1157778),
        radius:
            Radius.elliptical(size.width * 0.2897244, size.height * 0.2897244),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.lineTo(size.width * 0.7798206, size.height * 0.1157778);
    path_0.arcToPoint(Offset(size.width * 0.8842110, size.height * 0.2201794),
        radius:
            Radius.elliptical(size.width * 0.1047039, size.height * 0.1047039),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * 0.8842110, size.height * 0.2364487);
    path_0.arcToPoint(Offset(size.width * 0.9580333, size.height * 0.4146727),
        radius:
            Radius.elliptical(size.width * 0.2897580, size.height * 0.2897580),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.lineTo(size.width * 0.9695215, size.height * 0.4261721);
    path_0.arcToPoint(Offset(size.width * 0.9695215, size.height * 0.5738279),
        radius:
            Radius.elliptical(size.width * 0.1046927, size.height * 0.1046927),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * 0.9580333, size.height * 0.5853385);
    path_0.arcToPoint(Offset(size.width * 0.8842222, size.height * 0.7635289),
        radius:
            Radius.elliptical(size.width * 0.2896461, size.height * 0.2896461),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.lineTo(size.width * 0.8842222, size.height * 0.7798206);
    path_0.arcToPoint(Offset(size.width * 0.7798318, size.height * 0.8842110),
        radius:
            Radius.elliptical(size.width * 0.1047151, size.height * 0.1047151),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * 0.7635513, size.height * 0.8842110);
    path_0.arcToPoint(Offset(size.width * 0.5853273, size.height * 0.9580333),
        radius:
            Radius.elliptical(size.width * 0.2897580, size.height * 0.2897580),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.lineTo(size.width * 0.5738279, size.height * 0.9695327);
    path_0.arcToPoint(Offset(size.width * 0.5000056, size.height),
        radius:
            Radius.elliptical(size.width * 0.1036290, size.height * 0.1036290),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.close();
    path_0.moveTo(size.width * 0.5000840, size.height * 0.1777089);
    path_0.arcToPoint(Offset(size.width * 0.5514786, size.height * 0.2291034),
        radius: Radius.elliptical(
            size.width * 0.05139460, size.height * 0.05139460),
        rotation: 0,
        largeArc: true,
        clockwise: false);
    path_0.arcToPoint(Offset(size.width * 0.5000840, size.height * 0.1777089),
        radius: Radius.elliptical(
            size.width * 0.05145058, size.height * 0.05145058),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = _color ?? Color(0xfffe5c49).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
