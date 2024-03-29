import 'package:english_learner/presentations/home/views/list_vocabulary_page.dart';
import 'package:english_learner/presentations/user_vocabulary/widgets/delete_list_vocab_dialog.dart';
import 'package:english_learner/presentations/user_vocabulary/widgets/edit_list_vocab_dialog.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';

class UserListVocab extends StatefulWidget {
  final bool? ableToEdit;
  const UserListVocab({super.key, this.ableToEdit});

  @override
  State<UserListVocab> createState() => _UserListVocabState();
}

class _UserListVocabState extends State<UserListVocab> {
  double heighContainer = 52;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ListVocabularyItem()));
          },
          child: Container(
            width: widget.ableToEdit != null && widget.ableToEdit == true
                ? MediaQuery.of(context).size.width * 0.6
                : MediaQuery.of(context).size.width * 0.8,
            height: heighContainer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: const Center(child: Text("List Vocab 1 (10 words)")),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        widget.ableToEdit != null && widget.ableToEdit == true
            ? Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const EditListVocabName(),
                      );
                    },
                    child: Container(
                      height: heighContainer,
                      width: 52,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundEditButton,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                          child: Text(
                        "Edit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const DeleteListVocab(),
                      );
                    },
                    child: Container(
                      height: heighContainer,
                      width: 52,
                      decoration: BoxDecoration(
                        color: AppColors.backGroupDeleteButton,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                          child: Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  ),
                ],
              )
            : const SizedBox(),
      ],
    );
  }
}
