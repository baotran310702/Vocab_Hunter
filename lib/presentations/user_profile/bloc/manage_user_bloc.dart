import 'package:english_learner/models/time_notification.dart';
import 'package:english_learner/models/user.dart';
import 'package:english_learner/services/time_notification_local.dart';
import 'package:english_learner/services/user_hive_local.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'manage_user_event.dart';
part 'manage_user_state.dart';

class ManageUserProfileBloc extends Bloc<ManageUserEvents, ManageUserState> {
  ManageUserProfileBloc() : super(ManageUserState.initial()) {
    on<InitUserEvent>(_onInitUserEvent);
  }

  _onInitUserEvent(InitUserEvent event, Emitter emit) async {
    ListTimeNotification listTimeNotification =
        await TimeNotificationLocal().getListTimeNotification();
    UserModel currentUser = await UserHiveLocal().getUser();
    emit(state.copyWith(
      userModel: currentUser,
      listTimeNotification: listTimeNotification,
    ));
  }
}
