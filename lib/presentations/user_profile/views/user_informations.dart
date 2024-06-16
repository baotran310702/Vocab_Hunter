import 'package:english_learner/models/user.dart';
import 'package:english_learner/presentations/global_instance/appbar.dart';
import 'package:english_learner/presentations/user_profile/bloc/manage_user_bloc.dart';
import 'package:english_learner/presentations/user_profile/widgets/change_name_dialog.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:english_learner/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_text_field.dart';

class UserInformations extends StatefulWidget {
  const UserInformations({super.key});

  @override
  State<UserInformations> createState() => _UserInformationsState();
}

class _UserInformationsState extends State<UserInformations> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(text: 'User Informations'),
      body: BlocBuilder<ManageUserProfileBloc, ManageUserState>(
        builder: (context, state) {
          bool isMan = state.userModel.sex.value.trim().toLowerCase() == 'man'
              ? true
              : false;
          phoneController.text = state.userModel.phoneNumber;
          emailController.text = state.emailUSer;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: AppColors.backgroundHeader,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(AppIcons.bathingBoi),
                      fit: BoxFit.fill,
                    ),
                    color: Colors.amber,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.userModel.userName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => const ChangeNameUser(),
                          ).then((value) {
                            if (value != null) {
                              UserModel newUserModel = state.userModel.copyWith(
                                userName: value,
                              );
                              context.read<ManageUserProfileBloc>().add(
                                  UpdateUserInformation(
                                      newUserModel: newUserModel));
                            }
                          });
                        },
                        child:
                            Image.asset(AppIcons.edit, width: 24, height: 24)),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            shape: const CircleBorder(),
                            value: isMan,
                            onChanged: (value) {
                              _changeGender(value, state.userModel);
                            },
                            checkColor: AppColors.titleHeaderColor,
                            fillColor: MaterialStateProperty.all(
                              Colors.transparent,
                            ),
                          ),
                        ),
                        const Text("Man")
                      ],
                    ),
                    Row(
                      children: [
                        Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            shape: const CircleBorder(),
                            value: !isMan,
                            onChanged: (value) {
                              _changeGender(value, state.userModel);
                            },
                            checkColor: AppColors.titleHeaderColor,
                            fillColor: MaterialStateProperty.all(Colors.white),
                          ),
                        ),
                        const Text("Woman")
                      ],
                    ),
                  ],
                ),
                CustomTextField(
                  hintText: "Phone number",
                  icon: AppIcons.phone,
                  isPassword: false,
                  controller: phoneController,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  hintText: "Email",
                  icon: AppIcons.mail,
                  isPassword: false,
                  controller: emailController,
                  isEnable: false,
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.9,
                      52,
                    ),
                    backgroundColor: AppColors.titleHeaderColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  onPressed: () {
                    _onSave(
                      phoneNumber: phoneController.text,
                    );
                  },
                  child: const Text(
                    "SAVE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _changeGender(value, UserModel oldUserModel) {
    UserModel newUserModel =
        oldUserModel.copyWith(sex: oldUserModel.sex.reverse());
    context
        .read<ManageUserProfileBloc>()
        .add(UpdateUserInformation(newUserModel: newUserModel));
  }

  _onSave({required String phoneNumber}) {
    if (validateMobile(phoneNumber) != null) {
      print("number sai dinh dang");
      return;
    }
    UserModel currentUsermodel =
        context.read<ManageUserProfileBloc>().state.userModel;
    UserModel newUserModel =
        currentUsermodel.copyWith(phoneNumber: phoneNumber);
    context
        .read<ManageUserProfileBloc>()
        .add(UpdateUserInformation(newUserModel: newUserModel));
    context.read<ManageUserProfileBloc>().add(SaveUserCloud());
  }

  String? validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }
}
