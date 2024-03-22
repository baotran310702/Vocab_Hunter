import 'package:flutter/material.dart';

class ListVocabType extends StatelessWidget {
  const ListVocabType({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Học từ vựng"),
          Row(
            children: [
              Container(
                width: 100,
                height: 100,
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
