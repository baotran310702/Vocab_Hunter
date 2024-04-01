import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:english_learner/presentations/dictionary_page/dictionary_page.dart';
import 'package:english_learner/presentations/user_profile/user_profile.dart';
import 'package:english_learner/presentations/user_vocabulary/user_vocabulary.dart';
import 'package:english_learner/utils/icons.dart';
import 'package:flutter/material.dart';

import 'presentations/home/home.dart';
import 'utils/colors.dart';

class MyMainApp extends StatefulWidget {
  const MyMainApp({super.key});

  @override
  State<MyMainApp> createState() => _MyMainAppState();
}

class _MyMainAppState extends State<MyMainApp> {
  final _pageController = PageController(initialPage: 0);
  final _controller = NotchBottomBarController();

  int maxCount = 4;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// widget list
  final List<Widget> bottomBarPages = [
    const HomePage(),
    const DictionaryPage(),
    const UserVocabularyTrain(),
    const UserProfile(),
  ];

  @override
  void initState() {
    if (_pageController.hasClients) {
      _pageController.jumpTo(0);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: bottomBarPages,
        onPageChanged: (int index) {},
      ),
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        color: AppColors.bottomBarColor,
        notchColor: AppColors.mainBackgroundColor,
        bottomBarItems: [
          BottomBarItem(
            inActiveItem: Image.asset(
              AppIcons.home,
              color: Colors.white,
            ),
            activeItem: Image.asset(
              AppIcons.home,
            ),
            itemLabel: "Home",
          ),
          BottomBarItem(
            inActiveItem: Image.asset(
              AppIcons.dictionaryIcon,
              color: Colors.white,
            ),
            activeItem: Image.asset(AppIcons.dictionaryIcon),
            itemLabel: "Dictionary",
          ),
          BottomBarItem(
            inActiveItem: Image.asset(
              AppIcons.book,
              color: Colors.white,
            ),
            activeItem: Image.asset(AppIcons.book),
            itemLabel: "Your Words",
          ),
          BottomBarItem(
            inActiveItem: Image.asset(
              AppIcons.user,
              color: Colors.white,
            ),
            activeItem: Image.asset(AppIcons.user),
            itemLabel: "User",
          ),
        ],
        onTap: (int value) {
          setState(() {
            _pageController.jumpToPage(value);
          });
        },
        durationInMilliSeconds: 400,
        kIconSize: 25,
        kBottomRadius: 30,
        removeMargins: false,
        bottomBarHeight: 64,
        itemLabelStyle: const TextStyle(
          fontSize: 10,
          color: Colors.white,
        ),
      ),
    );
  }
}
