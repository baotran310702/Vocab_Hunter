import 'package:english_learner/utils/notifications/notifications_services.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  void registerMyTask() async {
    //register my task
    await Workmanager().registerPeriodicTask(
      'mng_task1',
      'Pratise Vocabulary Reminder',
      frequency: const Duration(minutes: 15),
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
    LocalNotifications.showMultiNotificationsSchedule();
    return Future.value(true);
  });
}
