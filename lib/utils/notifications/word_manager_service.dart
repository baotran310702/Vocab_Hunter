// steps
//1.init work manager
//2.excute our task.
//3.register our task in work manager

import 'package:english_learner/utils/notifications/notifications_services.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  void registerMyTask() async {
    //register my task
    await Workmanager().registerPeriodicTask(
      'id1',
      'Pratise Vocabulary Reminder',
      frequency: const Duration(seconds: 5),
    );
  }

  //init work manager service
  Future<void> init() async {
    await Workmanager().initialize(actionTask, isInDebugMode: true);
    registerMyTask();
  }

  void cancelTask(String id) {
    Workmanager().cancelAll();
  }
}

@pragma('vm-entry-point')
void actionTask() {
  //show notification
  Workmanager().executeTask((taskName, inputData) {
    LocalNotifications.showDailySchduledNotification();
    return Future.value(true);
  });
}
