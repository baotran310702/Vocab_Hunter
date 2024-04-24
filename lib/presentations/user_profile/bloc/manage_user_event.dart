part of 'manage_user_bloc.dart';

abstract class ManageUserEvents {}

class InitUserEvent extends ManageUserEvents {
  InitUserEvent();
}

class UpdateUserEvent extends ManageUserEvents {
  final UserModel userModel;
  UpdateUserEvent({required this.userModel});
}

class AddTimeNotificationEvent extends ManageUserEvents {
  final TimeNotification timeNotification;
  AddTimeNotificationEvent({required this.timeNotification});
}

class RemoveTimeNotificationEvent extends ManageUserEvents {
  final TimeNotification timeNotification;
  RemoveTimeNotificationEvent({required this.timeNotification});
}

