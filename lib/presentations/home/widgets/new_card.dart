import 'dart:math' as math;

import 'package:flippy/flippy.dart';
import 'package:flutter/material.dart';

class NewFlashCard extends StatefulWidget {
  const NewFlashCard({super.key});

  @override
  State<NewFlashCard> createState() => _NewFlashCardState();
}

class _NewFlashCardState extends State<NewFlashCard> {
  FlipperController controller = FlipperController();

  @override
  void initState() {
    super.initState();
    controller = FlipperController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {});
      },
      child: const FlipAnimation(),
    );
  }
}

class FrontWidget extends StatelessWidget {
  const FrontWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 600,
      decoration: BoxDecoration(
        color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(1.0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(child: Text('Flash Card')),
    );
  }
}

class BackWidget extends StatelessWidget {
  const BackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 600,
      decoration: BoxDecoration(
        color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(1.0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(child: Text('Flash Card')),
    );
  }
}

class FlipAnimation extends StatefulWidget {
  const FlipAnimation({super.key});

  @override
  State<FlipAnimation> createState() => _FlipAnimationState();
}

class _FlipAnimationState extends State<FlipAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startAnimation,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          double value = _animation.value;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(value * 3.14),
            child: const FrontWidget(),
          );
        },
      ),
    );
  }
}
