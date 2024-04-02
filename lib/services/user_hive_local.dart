import 'package:english_learner/models/achievement.dart';
import 'package:english_learner/models/time_notification.dart';
import 'package:english_learner/models/user.dart';
import 'package:english_learner/utils/constants.dart';
import 'package:english_learner/utils/enum.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class UserHiveLocal {
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();

    Hive.init(dir.path);

    if (Hive.isAdapterRegistered(KeyHiveLocal.hiveTimeNotificationId)) {
      Hive.registerAdapter(TimeNotificationAdapter());
    }
  }

  Future<void> saveUser(UserModel user) async {
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveEnumAchievementTypeId)) {
      Hive.registerAdapter(AchievementTypeAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveAchievementId)) {
      Hive.registerAdapter(AchievementAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveUserId)) {
      Hive.registerAdapter(UserModelAdapter());
    }
    final box = await Hive.openBox<UserModel>(KeyBoxHiveLocal.userKeyBox);
    await box.put(KeyBoxHiveLocal.userKeyBox, user);
  }

  Future<UserModel> getUser() async {
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveEnumAchievementTypeId)) {
      Hive.registerAdapter(AchievementTypeAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveAchievementId)) {
      Hive.registerAdapter(AchievementAdapter());
    }
    if (!Hive.isAdapterRegistered(KeyHiveLocal.hiveUserId)) {
      Hive.registerAdapter(UserModelAdapter());
    }
    final box = await Hive.openBox<UserModel>(KeyBoxHiveLocal.userKeyBox);
    UserModel usermodel =
        box.get(KeyBoxHiveLocal.userKeyBox) ?? UserModel.initWithId('', '');
    return usermodel;
  }

  Future<void> removeUser() async {
    final box = await Hive.openBox<UserModel>(KeyBoxHiveLocal.userKeyBox);
    await box.delete(KeyBoxHiveLocal.userKeyBox);
  }
}
