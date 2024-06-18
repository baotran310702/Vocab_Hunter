import 'package:english_learner/presentations/global_instance/appbar.dart';
import 'package:english_learner/presentations/user_profile/bloc/manage_user_bloc.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YourFavouritePage extends StatefulWidget {
  const YourFavouritePage({super.key});

  @override
  State<YourFavouritePage> createState() => _YourFavouritePageState();
}

class _YourFavouritePageState extends State<YourFavouritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: const MyAppbar(
        text: "Your Favourite",
      ),
      body: SafeArea(
        child: BlocBuilder<ManageUserProfileBloc, ManageUserState>(
          builder: (context, state) {
            return Container(
              color: AppColors.backgroundAppbar,
              child: Center(
                ///TODO: update list favourite by call from local
                child: Column(children: []),
              ),
            );
          },
        ),
      ),
    );
  }
}
