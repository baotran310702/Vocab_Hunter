import 'package:english_learner/models/user_vocab.dart';
import 'package:english_learner/presentations/home/views/list_vocabulary_page.dart';
import 'package:english_learner/presentations/user_vocabulary/bloc/manage_vocab_bloc.dart';
import 'package:english_learner/presentations/user_vocabulary/widgets/delete_list_vocab_dialog.dart';
import 'package:english_learner/presentations/user_vocabulary/widgets/edit_list_vocab_dialog.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserListVocab extends StatefulWidget {
  final bool? ableToEdit;
  final UserVocab currentVocabList;
  const UserListVocab(
      {super.key, this.ableToEdit, required this.currentVocabList});

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
            margin: const EdgeInsets.only(bottom: 10),
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
            child: Center(
                child: Text(
                    "${widget.currentVocabList.listName} - ${widget.currentVocabList.listVocabulary.isEmpty ? "empty." : "${widget.currentVocabList.listVocabulary.length} words."}")),
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
                        builder: (context) => EditListVocabName(
                          currentVocab: widget.currentVocabList,
                        ),
                      ).then((value) {
                        if (value != null) {
                          if (value.toString() != "") {
                            context.read<ManageVocabBloc>().add(
                                  UpdateListLearningVocab(
                                    listId: widget.currentVocabList.listId,
                                    listName: value.toString(),
                                  ),
                                );
                            Fluttertoast.showToast(
                              msg: "List name updated successfully.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          } else {
                            Fluttertoast.showToast(
                              msg: "New name can't be empty.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                        }
                      });
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
                        builder: (context) => DeleteListVocab(
                          userVocab: widget.currentVocabList,
                        ),
                      ).then((value) {
                        if (value != null) {
                          context.read<ManageVocabBloc>().add(
                                DeleteListLearningVocab(
                                  listId: widget.currentVocabList.listId,
                                ),
                              );
                          Fluttertoast.showToast(
                            msg: "List deleted successfully.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      });
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
