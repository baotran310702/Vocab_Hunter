import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';

class InputTextFields extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final String labelText;
  const InputTextFields({
    super.key,
    required this.textController,
    required this.hintText,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: AppColors.textInputs, fontSize: 16),
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(40),
          ),
          borderSide: BorderSide(color: AppColors.borderInput),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }
}
