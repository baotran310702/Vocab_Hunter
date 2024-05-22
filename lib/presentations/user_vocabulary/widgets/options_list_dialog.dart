import 'package:english_learner/presentations/user_vocabulary/bloc/manage_vocab_bloc.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OptionListDialog extends StatelessWidget {
  final String listId;
  const OptionListDialog({super.key, required this.listId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Set default or View list",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
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
                    context
                        .read<ManageVocabBloc>()
                        .add(SetDefaultListLearningVocab(listId: listId));
                    Navigator.pop(context, false);
                  },
                  child: Text(
                    "Set Default",
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
                    Navigator.of(context).pop(true);
                  },
                  child: const Text(
                    "View all",
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
