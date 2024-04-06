import 'package:english_learner/firebase_options.dart';
import 'package:english_learner/my_app.dart';
import 'package:english_learner/presentations/global_widgets/bloc/global_bloc.dart';
import 'package:english_learner/presentations/login_page/sign_in_page.dart';
import 'package:english_learner/presentations/login_page/sign_up_page.dart';
import 'package:english_learner/presentations/user_vocabulary/bloc/manage_vocab_bloc.dart';
import 'package:english_learner/utils/notifications/notifications_services.dart';
import 'package:english_learner/utils/notifications/word_manager_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'services/user_hive_local.dart';

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
    UserHiveLocal().init(),
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
          create: (context) => ManageVocabBloc(),
        ),
        BlocProvider(
          create: (context) => GlobalBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SignInPage(),
          '/sign-up': (context) => const SignUpPage(),
          '/home': (context) => const MyMainApp(),
        },
      ),
    );
  }
}
