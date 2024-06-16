import 'package:english_learner/models/time_notification.dart';
import 'package:english_learner/models/user.dart';
import 'package:english_learner/repository/user_repository.dart';
import 'package:english_learner/services/time_notification_local.dart';
import 'package:english_learner/services/user_hive_local.dart';
import 'package:english_learner/services/user_pref_local.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'manage_user_event.dart';
part 'manage_user_state.dart';

class ManageUserProfileBloc extends Bloc<ManageUserEvents, ManageUserState> {
  final UserRepository _userRepository = UserRepository();

  ManageUserProfileBloc() : super(ManageUserState.initial()) {
    on<InitUserEvent>(_onInitUserEvent);
    on<AddTimeNotificationEvent>(_onAddTimeNotificationEvent);
    on<RemoveTimeNotificationEvent>(_onRemoveTimeNotificationEvent);
    on<UpdateTimeNotification>(_onUpdateTimeNotification);
    on<UpdateNewPassWord>(_onUpdateNewPassWord);
    on<UpdateUserInformation>(_onUpdateUserInformation);
    on<SaveUserCloud>(_onSaveUserCloud);
  }

  _onSaveUserCloud(SaveUserCloud event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    await UserHiveLocal().saveUser(state.userModel);
    await _userRepository.syncUserData();
    emit(state.copyWith(isLoading: false));
  }

  _onUpdateUserInformation(UpdateUserInformation event, Emitter emit) async {
    emit(state.copyWith(userModel: event.newUserModel));
  }

  _onInitUserEvent(InitUserEvent event, Emitter emit) async {
    ListTimeNotification listTimeNotification =
        await TimeNotificationLocal().getListTimeNotification();
    UserModel currentUser = await UserHiveLocal().getUser();
    String emailUser = await UserPrefererencesLocal().getEmailUser();
    emit(state.copyWith(
      userModel: currentUser,
      listTimeNotification: listTimeNotification,
      emailUSer: emailUser,
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

  _onUpdateNewPassWord(UpdateNewPassWord event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _userRepository.changePassword(event.newPassWord);
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: "Change password fail!"));
    }
    emit(state.copyWith(isLoading: false));
  }
}
