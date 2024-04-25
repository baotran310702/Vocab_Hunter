import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../models/time_notification.dart';
import '../utils/constants.dart';

class TimeNotificationLocal {
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();

    Hive.init(dir.path);
  }

  Future<void> addTimeNotification(
      ListTimeNotification timeNotification) async {
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveTimeNotificationId)) {
      Hive.registerAdapter(TimeNotificationAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveListTimeNotificationId)) {
      Hive.registerAdapter(ListTimeNotificationAdapter());
    }
    final box = await Hive.openBox<ListTimeNotification>(
        KeyBoxHiveLocal.listTimeNotificationKeyBox);
    await box.put(KeyBoxHiveLocal.listTimeNotificationKeyBox, timeNotification);
  }

  Future<void> removeTimeNotifcation(TimeNotification timeNotification) async {
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveTimeNotificationId)) {
      Hive.registerAdapter(TimeNotificationAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveListTimeNotificationId)) {
      Hive.registerAdapter(ListTimeNotificationAdapter());
    }

    final box = await Hive.openBox<ListTimeNotification>(
        KeyBoxHiveLocal.listTimeNotificationKeyBox);
    ListTimeNotification? currentListTimeNotification =
        box.get(KeyBoxHiveLocal.listTimeNotificationKeyBox);
    List<TimeNotification> currentListTimeNotificationList =
        currentListTimeNotification?.listTimeNotification ?? [];
    List<TimeNotification> newListTimeNotificationList =
        currentListTimeNotificationList
            .where((element) =>
                element.time.hour != timeNotification.time.hour &&
                element.time.minute != timeNotification.time.minute)
            .toList();
    ListTimeNotification newListTimeNotification =
        ListTimeNotification(listTimeNotification: newListTimeNotificationList);
    await box.put(
        KeyBoxHiveLocal.listTimeNotificationKeyBox, newListTimeNotification);
  }

  Future<ListTimeNotification> getListTimeNotification() async {
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveTimeNotificationId)) {
      Hive.registerAdapter(TimeNotificationAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveListTimeNotificationId)) {
      Hive.registerAdapter(ListTimeNotificationAdapter());
    }

    final box = await Hive.openBox<ListTimeNotification>(
        KeyBoxHiveLocal.listTimeNotificationKeyBox);
    ListTimeNotification? listTimeNotification =
        box.get(KeyBoxHiveLocal.listTimeNotificationKeyBox);
    if (listTimeNotification == null) {
      return ListTimeNotification.initial();
    }
    return listTimeNotification;
  }
}
