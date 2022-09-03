import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GravitySimulationDemo(),
    );
  }
}

class GravitySimulationDemo extends StatefulWidget {
  const GravitySimulationDemo({Key? key}) : super(key: key);

  @override
  State<GravitySimulationDemo> createState() => _GravitySimulationDemoState();
}

class _GravitySimulationDemoState extends State<GravitySimulationDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController.unbounded(vsync: this);
    _animation = _controller.drive(AlignmentTween(
        begin: const Alignment(
          0,
          -1,
        ),
        end: const Alignment(0, 1)));

    _controller.addListener(() {
      if (kDebugMode) {
        print(_controller.value);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: AnimatedBuilder(
                    animation: _animation,
                    child: Container(
                      color: Colors.black,
                      height: 10,
                      width: 10,
                    ),
                    builder: (context, child) {
                      return Align(
                        alignment: _animation.value,
                        child: child,
                      );
                    }),
              ),
              ElevatedButton(
                  onPressed: () {
                    _controller.animateWith(GravitySimulation(
                      0.01, //Acceleration in pixels
                      0, // Initial Position in pixels
                      1, // Final Position in pixels
                      0.01, // Velocity in pixels
                    ));
                  },
                  child: const Text('Play Gravity Simulation'))
            ],
          ),
        ),
      ),
    );
  }
}
