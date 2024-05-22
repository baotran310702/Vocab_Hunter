part of 'global_bloc.dart';

abstract class GlobalEvent {}

class GlobalInitialEvent extends GlobalEvent {}

class ChangeFlashCardSide extends GlobalEvent {}

class ResetFlashCardSide extends GlobalEvent {}

class UpdateNotificationApp extends GlobalEvent {
  final List<NotificationApp> notificationApps;

  UpdateNotificationApp(this.notificationApps);
}
