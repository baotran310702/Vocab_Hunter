import 'package:english_learner/firebase_options.dart';
import 'package:english_learner/presentations/dictionary_page/dictionary_page.dart';
import 'package:english_learner/presentations/home/home.dart';
import 'package:english_learner/presentations/home/views/topic_vocabs.dart';
import 'package:english_learner/presentations/login_page/sign_in_page.dart';
import 'package:english_learner/presentations/login_page/sign_up_page.dart';
import 'package:english_learner/presentations/user_profile/user_profile.dart';
import 'package:english_learner/presentations/user_vocabulary_training/bloc/manage_vocab_bloc.dart';
import 'package:english_learner/presentations/user_vocabulary_training/user_vocabulary.dart';
import 'package:english_learner/repository/vocab_repository.dart';
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
  int maxCount = 4;
  int _selectedIndex = 0;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// widget list
  final List<Widget> bottomBarPages = [
    const HomePage(),
    const UserVocabulary(),
    const DictionaryPage(),
    const UserProfile(),
  ];

  /// on item tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
          '/1': (context) => const SignInPage(),
          '/sign-up': (context) => const SignUpPage(),
          '/home': (context) => home(),
          '/': (context) => const TopicVocab(),
        },
      ),
    );
  }

  Scaffold home() {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: bottomBarPages,
        onPageChanged: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Your Vocab',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Dictionary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        iconSize: 32,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.amber[400],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
