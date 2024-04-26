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
    on<AddTimeNotificationEvent>(_onAddTimeNotificationEvent);
    on<RemoveTimeNotificationEvent>(_onRemoveTimeNotificationEvent);
    on<UpdateTimeNotification>(_onUpdateTimeNotification);
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

  _onAddTimeNotificationEvent(
      AddTimeNotificationEvent event, Emitter emit) async {
    ListTimeNotification listTimeNotification = state.listTimeNotification;
    listTimeNotification.listTimeNotification.add(event.timeNotification);
    await TimeNotificationLocal()
        .addTimeNotificationToList(event.timeNotification);
    await TimeNotificationLocal().updateListNotification(listTimeNotification);
    emit(state.copyWith(listTimeNotification: listTimeNotification));
  }

  _onRemoveTimeNotificationEvent(
      RemoveTimeNotificationEvent event, Emitter emit) async {
    List<TimeNotification> listTimeNotificationUpdated = state
        .listTimeNotification.listTimeNotification
        .where((element) => element.id != event.timeNotification.id)
        .toList();
    await TimeNotificationLocal().updateListNotification(
      ListTimeNotification(
        listTimeNotification: listTimeNotificationUpdated,
      ),
    );

    emit(state.copyWith(
      listTimeNotification: ListTimeNotification(
        listTimeNotification: listTimeNotificationUpdated,
      ),
    ));
  }

  _onUpdateTimeNotification(UpdateTimeNotification event, Emitter emit) async {
    List<TimeNotification> listTimeNotificationUpdated =
        state.listTimeNotification.listTimeNotification.map((e) {
      if (e.id == event.timeNotification.id) {
        return event.timeNotification;
      }
      return e;
    }).toList();

    await TimeNotificationLocal().updateListNotification(
      ListTimeNotification(
        listTimeNotification: listTimeNotificationUpdated,
      ),
    );
    emit(
      state.copyWith(
        listTimeNotification: ListTimeNotification(
          listTimeNotification: listTimeNotificationUpdated,
        ),
      ),
    );
  }
}
