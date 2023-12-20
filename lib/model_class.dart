import 'package:flutter/material.dart';

class Electron {
  double speed;
  double size;
  Color color;
  double currentPositionDegree;
  Electron({
    required this.speed,
    required this.size,
    required this.color,
    required this.currentPositionDegree,
  });
}


class Orbit {
  final List<Electron> electrons;
  final double angle;
  Orbit({
    required this.electrons,
    required this.angle,
  });
}