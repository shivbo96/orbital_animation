import 'dart:async';
import 'dart:math' as math;
import 'package:electron_project/model/model_class.dart';
import 'package:electron_project/model/painter/orbit_painter.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer timer;

  List<Orbit> orbits = [
    Orbit(electrons: [], angle: 0),
    Orbit(electrons: [], angle: 45),
    Orbit(electrons: [], angle: 90),
    Orbit(electrons: [], angle: 135),
  ];

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(milliseconds: 16),
      (t) {
        setState(() {
          for (var orbit in orbits) {
            for (var electron in orbit.electrons) {
              electron.currentPositionDegree += electron.speed;
            }
          }
        });
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191636),
      body: Center(
        child: Stack(
          children: orbits
              .map(
                (orbit) => Transform.rotate(
                  angle: degreesToRads(orbit.angle),
                  child: CustomPaint(painter: OrbitPainter(orbit.electrons), size: const Size(300, 100)),
                ),
              )
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final randomOrbit = orbits[math.Random().nextInt(orbits.length)];
          randomOrbit.electrons.add(
            Electron(
              speed: randomDoubleBetween(1, 3),
              size: randomDoubleBetween(4, 8),
              color: randomColor([
                Colors.purpleAccent,
                Colors.yellowAccent,
                Colors.cyanAccent,
              ]),
              currentPositionDegree: 0,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

double randomDoubleBetween(double min, double max) => math.Random().nextDouble() * (max - min) + min;

randomColor(List colors) {
  return colors[math.Random().nextInt(colors.length)];
}
