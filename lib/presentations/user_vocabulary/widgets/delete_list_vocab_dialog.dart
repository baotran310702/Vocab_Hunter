import 'package:english_learner/models/user_vocab.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';

class DeleteListVocab extends StatelessWidget {
  final UserVocab userVocab;
  const DeleteListVocab({super.key, required this.userVocab});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "List ${userVocab.listName} will be removed!",
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "You want to delete this list? All data will be cleared!",
              textAlign: TextAlign.center,
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
                    Navigator.pop(context, userVocab.listId);
                  },
                  child: const Text(
                    "Delete",
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
