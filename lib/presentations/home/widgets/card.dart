import 'package:flutter/material.dart';
import 'dart:math' as math;

class FlashCard extends StatelessWidget {
  const FlashCard({super.key});

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
