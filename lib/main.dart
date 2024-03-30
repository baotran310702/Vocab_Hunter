import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:english_learner/firebase_options.dart';
import 'package:english_learner/presentations/dictionary_page/dictionary_page.dart';
import 'package:english_learner/presentations/home/home.dart';
import 'package:english_learner/presentations/login_page/sign_in_page.dart';
import 'package:english_learner/presentations/login_page/sign_up_page.dart';
import 'package:english_learner/presentations/user_profile/user_profile.dart';
import 'package:english_learner/presentations/user_vocabulary/bloc/manage_vocab_bloc.dart';
import 'package:english_learner/presentations/user_vocabulary/user_vocabulary.dart';
import 'package:english_learner/repository/vocab_repository.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:english_learner/utils/icons.dart';
import 'package:english_learner/utils/notifications/notifications_services.dart';
import 'package:english_learner/utils/notifications/word_manager_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final navigatorKey = GlobalKey<NavigatorState>();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Future.wait([
    LocalNotifications().init(),
    WorkManagerService().init(),
  ]);

  //  handle in terminated state
  var initialNotification =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (initialNotification?.didNotificationLaunchApp == true) {
    // LocalNotifications.onClickNotification.stream.listen((event) {
    Future.delayed(const Duration(milliseconds: 500), () {
      // print(event);
      navigatorKey.currentState!.pushNamed('/another',
          arguments: initialNotification?.notificationResponse?.payload);
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _pageController = PageController(initialPage: 0);
  final _controller = NotchBottomBarController();

  int maxCount = 4;
  // int _selectedIndex = 0;
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

  /// on item tapped
  void _onItemTapped(int index) {
    setState(() {
      _pageController.jumpToPage(index);
    });
  }

  @override
  void initState() {
    requestPermission();
    super.initState();
  }

  void requestPermission() async {
    await LocalNotifications.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ManageVocabBloc(VocabRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/sign-in': (context) => const SignInPage(),
          '/sign-up': (context) => const SignUpPage(),
          '/': (context) => home(),
        },
      ),
    );
  }

  Scaffold home() {
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
