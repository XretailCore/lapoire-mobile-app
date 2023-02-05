import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  Color? _color = Colors.white;

  RPSCustomPainter(Color color) {
    _color = color;
  }
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.4261697, size.height * 0.03042041);
    path_0.arcToPoint(Offset(size.width * 0.5738101, size.height * 0.03042041),
        radius:
            Radius.elliptical(size.width * 0.1047273, size.height * 0.1047273),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * 0.5853090, size.height * 0.04191933);
    path_0.arcToPoint(Offset(size.width * 0.7635320, size.height * 0.1157395),
        radius:
            Radius.elliptical(size.width * 0.2904541, size.height * 0.2904541),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.lineTo(size.width * 0.7797562, size.height * 0.1157395);
    path_0.arcToPoint(Offset(size.width * 0.8842199, size.height * 0.2201829),
        radius:
            Radius.elliptical(size.width * 0.1047071, size.height * 0.1047071),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * 0.8842199, size.height * 0.2364071);
    path_0.arcToPoint(Offset(size.width * 0.9580604, size.height * 0.4146302),
        radius:
            Radius.elliptical(size.width * 0.2904744, size.height * 0.2904744),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.lineTo(size.width * 0.9695390, size.height * 0.4261291);
    path_0.arcToPoint(Offset(size.width * 0.9695390, size.height * 0.5737898),
        radius:
            Radius.elliptical(size.width * 0.1047071, size.height * 0.1047071),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * 0.9580604, size.height * 0.5852887);
    path_0.arcToPoint(Offset(size.width * 0.8842199, size.height * 0.7635320),
        radius:
            Radius.elliptical(size.width * 0.2903932, size.height * 0.2903932),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.lineTo(size.width * 0.8842199, size.height * 0.7797562);
    path_0.arcToPoint(Offset(size.width * 0.7798171, size.height * 0.8842199),
        radius:
            Radius.elliptical(size.width * 0.1047071, size.height * 0.1047071),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * 0.7635929, size.height * 0.8842199);
    path_0.arcToPoint(Offset(size.width * 0.5853698, size.height * 0.9580401),
        radius:
            Radius.elliptical(size.width * 0.2904744, size.height * 0.2904744),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.lineTo(size.width * 0.5738709, size.height * 0.9695390);
    path_0.arcToPoint(Offset(size.width * 0.4262305, size.height * 0.9695390),
        radius:
            Radius.elliptical(size.width * 0.1046868, size.height * 0.1046868),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * 0.4147316, size.height * 0.9580401);
    path_0.arcToPoint(Offset(size.width * 0.2365085, size.height * 0.8842199),
        radius:
            Radius.elliptical(size.width * 0.2904541, size.height * 0.2904541),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.lineTo(size.width * 0.2202843, size.height * 0.8842199);
    path_0.arcToPoint(Offset(size.width * 0.1158815, size.height * 0.7798171),
        radius:
            Radius.elliptical(size.width * 0.1047071, size.height * 0.1047071),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * 0.1158815, size.height * 0.7635929);
    path_0.arcToPoint(Offset(size.width * 0.04204101, size.height * 0.5853901),
        radius:
            Radius.elliptical(size.width * 0.2903932, size.height * 0.2903932),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.lineTo(size.width * 0.03042041, size.height * 0.5738101);
    path_0.arcToPoint(Offset(size.width * 0.03042041, size.height * 0.4261494),
        radius:
            Radius.elliptical(size.width * 0.1047071, size.height * 0.1047071),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * 0.04191933, size.height * 0.4146505);
    path_0.arcToPoint(Offset(size.width * 0.1157598, size.height * 0.2364274),
        radius:
            Radius.elliptical(size.width * 0.2904744, size.height * 0.2904744),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.lineTo(size.width * 0.1157598, size.height * 0.2202032);
    path_0.arcToPoint(Offset(size.width * 0.2201626, size.height * 0.1158004),
        radius:
            Radius.elliptical(size.width * 0.1047071, size.height * 0.1047071),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * 0.2363869, size.height * 0.1158004);
    path_0.arcToPoint(Offset(size.width * 0.4146099, size.height * 0.04198017),
        radius:
            Radius.elliptical(size.width * 0.2904338, size.height * 0.2904338),
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
