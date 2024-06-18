import 'package:flutter/material.dart';

class AddAchievementDialog extends StatefulWidget {
  const AddAchievementDialog({super.key});

  @override
  State<AddAchievementDialog> createState() => _AddAchievementDialogState();
}

class _AddAchievementDialogState extends State<AddAchievementDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Row(
            children: [],
          ),
        ),
        Text("Description"),
        TextFormField(
          decoration: InputDecoration(
            hintText: "Description",
          ),
        ),
      ],
    );
  }
}
