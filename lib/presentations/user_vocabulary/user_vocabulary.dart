import 'package:english_learner/presentations/home/widgets/divider.dart';
import 'package:english_learner/presentations/home/widgets/item_type_vocab.dart';
import 'package:english_learner/presentations/user_vocabulary/bloc/manage_vocab_bloc.dart';
import 'package:english_learner/presentations/user_vocabulary/widgets/add_new_list_dialog.dart';
import 'package:english_learner/presentations/user_vocabulary/widgets/user_list_vocab.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:english_learner/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../home/widgets/header_informations.dart';

class UserVocabularyTrain extends StatefulWidget {
  const UserVocabularyTrain({super.key});

  @override
  State<UserVocabularyTrain> createState() => _UserVocabularyTrainState();
}

class _UserVocabularyTrainState extends State<UserVocabularyTrain> {
  bool isAbleToEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundAppbar,
      body: SafeArea(
        child: Container(
          color: AppColors.backgroundHeader,
          child: Column(
            children: [
              const HeaderInformations(
                title: "Manage Your Words",
                description: "Manage your words and learn them easily!",
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocBuilder<ManageVocabBloc, ManageVocabState>(
                    builder: (context, state) {
                      return ItemTypeVocab(
                        text: "Sync",
                        icon: Image.asset(
                          AppIcons.sync,
                          width: 24,
                          height: 24,
                        ),
                        onTap: () {
                          context.read<ManageVocabBloc>().add(SyncUserData());
                          Fluttertoast.showToast(
                            msg: "Sync successfully!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        },
                        isSync: state.isSync,
                      );
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const DeviderVerticle(),
                  const SizedBox(
                    width: 10,
                  ),
                  BlocBuilder<ManageVocabBloc, ManageVocabState>(
                    builder: (context, state) {
                      return ItemTypeVocab(
                        text: "Edit",
                        icon: Image.asset(
                          AppIcons.setting,
                          width: 24,
                          height: 24,
                        ),
                        onTap: () {
                          setState(() {
                            isAbleToEdit = !isAbleToEdit;
                          });
                        },
                        isAbleToEdit: state.userModel.learningWords.isNotEmpty
                            ? isAbleToEdit
                            : false,
                      );
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const DeviderVerticle(),
                  const SizedBox(
                    width: 10,
                  ),
                  ItemTypeVocab(
                    text: "Add New",
                    icon: Image.asset(
                      AppIcons.createNew,
                      width: 24,
                      height: 24,
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const AddNewListDialog();
                          }).then((value) {
                        if (value != null && value.toString().isNotEmpty) {
                          context
                              .read<ManageVocabBloc>()
                              .add(AddNewListLearningVocab(
                                name: value.toString(),
                              ));
                        }
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                "Your Lists",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 18,
              ),
              BlocBuilder<ManageVocabBloc, ManageVocabState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state.userModel.learningWords.isEmpty) {
                    return const Expanded(
                      child: Center(
                        child: Text(
                            "There's no list created yet, please create a new one!"),
                      ),
                    );
                  }

                  if (state.userModel.learningWords.isNotEmpty) {
                    return Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return UserListVocab(
                            ableToEdit: isAbleToEdit,
                            currentVocabList:
                                state.userModel.learningWords[index],
                          );
                        },
                        itemCount: state.userModel.learningWords.length,
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
