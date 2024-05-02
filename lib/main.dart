import 'package:english_learner/firebase_options.dart';
import 'package:english_learner/my_app.dart';
import 'package:english_learner/presentations/authentication/authentication_page.dart';
import 'package:english_learner/presentations/authentication/views/sign_in_page.dart';
import 'package:english_learner/presentations/global_instance/bloc/global_bloc.dart';
import 'package:english_learner/presentations/user_profile/bloc/manage_user_bloc.dart';
import 'package:english_learner/presentations/user_vocabulary/bloc/manage_vocab_bloc.dart';
import 'package:english_learner/services/vocab_translated_local_service.dart';
import 'package:english_learner/services/word_notification_local.dart';
import 'package:english_learner/utils/notifications/notifications_services.dart';
import 'package:english_learner/utils/notifications/word_manager_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

import 'package:path_provider/path_provider.dart';

import 'presentations/dictionary_page/bloc/translate_page_bloc.dart';
import 'services/user_hive_local.dart';

final navigatorKey = GlobalKey<NavigatorState>();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final dir = await getApplicationDocumentsDirectory();

  Hive.init(dir.path);

  await Future.wait([
    UserHiveLocal().init(),
    WordNotificationServices().init(),
    VocabTranslatedLocalServices().init(),
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
          create: (context) => ManageVocabBloc()..add(InitUserVocabEvent()),
        ),
        BlocProvider(
          create: (context) => GlobalBloc(),
        ),
        BlocProvider(
          create: (context) => ManageUserProfileBloc()..add(InitUserEvent()),
        ),
        BlocProvider(
          create: (context) => TranslatePageBloc(),
        ),
      ],
      child: MaterialApp(
        builder: FToastBuilder(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const AuthenticationPage(),
          '/home': (context) => const MyMainApp(),
          '/login': (context) => const SignInPage(),
        },
      ),
    );
  }
}
