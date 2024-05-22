import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';

class AddNewListDialog extends StatelessWidget {
  const AddNewListDialog({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textFieldController = TextEditingController();
    return AlertDialog(
      title: const Text(
        "Write New List Name",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textFieldController,
              decoration: const InputDecoration(
                labelText: "New List Name",
                hintText: "New name...",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.boxVocabColor,
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.33, 54),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: AppColors.titleHeaderColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.titleHeaderColor,
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.33, 54),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(textFieldController.text);
                  },
                  child: const Text(
                    "Create",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
