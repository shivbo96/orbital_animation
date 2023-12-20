import 'package:electron_project/model_class.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;

class OrbitPainter extends CustomPainter {

  final List<Electron>  orbits;
  OrbitPainter(this.orbits);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCenter(center: center, width: size.width, height: size.height);
    canvas.drawOval(
        rect,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1);

    orbits.forEach((electron) {
      final degree = degreesToRads(electron.currentPositionDegree);
      final electronPos = center +
          Offset(
            math.cos(degree) * (size.width / 2),
            math.sin(degree) * (size.height / 2),
          );
      canvas.drawCircle(electronPos, electron.size, Paint()..color = electron.color);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}



double degreesToRads(double deg) {
  return (deg * math.pi) / 180.0;
}