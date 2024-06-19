import 'package:english_learner/models/favourite_topic.dart';
import 'package:english_learner/models/sub_topic.dart';
import 'package:english_learner/models/topic.dart';
import 'package:english_learner/presentations/global_instance/appbar.dart';
import 'package:english_learner/presentations/home/widgets/box_topic_item.dart';
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
            List<SubTopic> favouriteSubTopic = state.favouriteSubTopic ?? [];

            return Container(
              color: AppColors.backgroundAppbar,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: favouriteSubTopic.length,
                itemBuilder: (builder, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BoxTopicItem(
                      subTopic: favouriteSubTopic[index],
                      topicId: "",
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
