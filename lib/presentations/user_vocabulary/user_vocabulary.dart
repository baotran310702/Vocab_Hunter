import 'package:english_learner/presentations/home/widgets/divider.dart';
import 'package:english_learner/presentations/home/widgets/item_type_vocab.dart';
import 'package:english_learner/presentations/user_vocabulary/widgets/add_new_list_dialog.dart';
import 'package:english_learner/presentations/user_vocabulary/widgets/user_list_vocab.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:english_learner/utils/icons.dart';
import 'package:flutter/material.dart';

import '../home/widgets/header_informations.dart';

class UserVocabularyTrain extends StatefulWidget {
  const UserVocabularyTrain({super.key});

  @override
  State<UserVocabularyTrain> createState() => _UserVocabularyTrainState();
}

class _UserVocabularyTrainState extends State<UserVocabularyTrain> {
  bool isAbleToEdit = false;
  bool isSync = false;
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
                title: "Edit List Name",
                description: "Write new list name here",
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ItemTypeVocab(
                    text: "Sync",
                    icon: Image.asset(
                      AppIcons.sync,
                      width: 24,
                      height: 24,
                    ),
                    onTap: () {
                      setState(() {
                        isSync = !isSync;
                      });
                    },
                    isSync: isSync,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const DeviderVerticle(),
                  const SizedBox(
                    width: 10,
                  ),
                  ItemTypeVocab(
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
                    isAbleToEdit: isAbleToEdit,
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
                          });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                "Danh sách đã tạo",
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
              UserListVocab(
                ableToEdit: isAbleToEdit,
              ),
              const SizedBox(
                height: 8,
              ),
              UserListVocab(
                ableToEdit: isAbleToEdit,
              ),
              const SizedBox(
                height: 8,
              ),
              UserListVocab(
                ableToEdit: isAbleToEdit,
              ),
              const SizedBox(
                height: 8,
              ),
              UserListVocab(
                ableToEdit: isAbleToEdit,
              ),
              const SizedBox(
                height: 8,
              ),
              UserListVocab(
                ableToEdit: isAbleToEdit,
              ),
              const SizedBox(
                height: 8,
              ),
              UserListVocab(
                ableToEdit: isAbleToEdit,
              ),
              const SizedBox(
                height: 8,
              ),
              UserListVocab(
                ableToEdit: isAbleToEdit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
