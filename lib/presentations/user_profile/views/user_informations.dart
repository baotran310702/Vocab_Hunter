import 'package:english_learner/presentations/global_instance/appbar.dart';
import 'package:english_learner/presentations/user_profile/widgets/change_name_dialog.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:english_learner/utils/icons.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_text_field.dart';

class UserInformations extends StatefulWidget {
  const UserInformations({super.key});

  @override
  State<UserInformations> createState() => _UserInformationsState();
}

class _UserInformationsState extends State<UserInformations> {
  bool isMan = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(text: 'User Informations'),
      body: Container(
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
                const Text(
                  "John Doe",
                  style: TextStyle(
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
                      );
                    },
                    child: Image.asset(AppIcons.edit, width: 24, height: 24)),
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
                        onChanged: _changeGender,
                        checkColor: AppColors.titleHeaderColor,
                        fillColor: MaterialStateProperty.all(
                          Colors.transparent,
                        ),
                      ),
                    ),
                    const Text("Nam")
                  ],
                ),
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        shape: const CircleBorder(),
                        value: !isMan,
                        onChanged: _changeGender,
                        checkColor: AppColors.titleHeaderColor,
                        fillColor: MaterialStateProperty.all(Colors.white),
                      ),
                    ),
                    const Text("Nữ")
                  ],
                ),
              ],
            ),
            const CustomTextField(
              hintText: "Phone number",
              icon: AppIcons.phone,
              isPassword: false,
            ),
            const SizedBox(
              height: 16,
            ),
            const CustomTextField(
              hintText: "Email",
              icon: AppIcons.mail,
              isPassword: false,
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
              onPressed: () {},
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
      ),
    );
  }

  _changeGender(value) {
    setState(() {
      isMan = !isMan;
    });
  }
}
