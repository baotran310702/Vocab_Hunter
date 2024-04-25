import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';

class TypeWords extends StatelessWidget {
  const TypeWords({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //craete a big box container for the question
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.9,
          child: const Center(
            child: Text(
              "What is the meaning of 'apple'?",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 60,
          child: TextField(
            decoration: InputDecoration(
              hintText: "Type your answer here",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        //submit button
        const SizedBox(height: 12),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.textInputs,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {},
            child: const Text(
              "Submit",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
