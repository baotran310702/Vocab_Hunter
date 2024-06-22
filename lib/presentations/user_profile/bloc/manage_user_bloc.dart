import 'package:english_learner/models/achievement.dart';
import 'package:english_learner/models/sub_topic.dart';
import 'package:english_learner/models/time_notification.dart';
import 'package:english_learner/models/topic.dart';
import 'package:english_learner/models/user.dart';
import 'package:english_learner/presentations/dialog/show_dialog.dart';
import 'package:english_learner/repository/user_repository.dart';
import 'package:english_learner/repository/vocab_repository.dart';
import 'package:english_learner/services/favourite_topic_services.dart';
import 'package:english_learner/services/time_notification_local.dart';
import 'package:english_learner/services/user_hive_local.dart';
import 'package:english_learner/services/user_pref_local.dart';
import 'package:english_learner/utils/enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'manage_user_event.dart';
part 'manage_user_state.dart';

class ManageUserProfileBloc extends Bloc<ManageUserEvents, ManageUserState> {
  final UserRepository _userRepository = UserRepository();
  final VocabRepository _vocabRepository = VocabRepository();

  ManageUserProfileBloc() : super(ManageUserState.initial()) {
    on<InitUserEvent>(_onInitUserEvent);
    on<AddTimeNotificationEvent>(_onAddTimeNotificationEvent);
    on<RemoveTimeNotificationEvent>(_onRemoveTimeNotificationEvent);
    on<UpdateTimeNotification>(_onUpdateTimeNotification);
    on<UpdateNewPassWord>(_onUpdateNewPassWord);
    on<UpdateUserInformation>(_onUpdateUserInformation);
    on<SaveUserCloud>(_onSaveUserCloud);
    on<AddFavouriteTopic>(_onAddFavouriteTopic);
    on<RemoveAFavouriteTopic>(_onRemoveAFavouriteTopic);
    on<InitFavouriteSubTopic>(_onInitFavouriteSubTopic);
    on<AddAchievementEvent>(_onAddAchievementEvent);
    on<UpdateAchievementEvent>(_onUpdateAchievementEvent);
  }

  _onUpdateAchievementEvent(UpdateAchievementEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    UserModel userModel = state.userModel;
    List<Achievement> achievements = List.from(userModel.achievements);

    List<Achievement> newListAchievement = achievements.map((element) {
      if (element.customAchievement == event.customAchievement &&
          element.isAlert == false) {
        if (element.amount == element.total) {
          return element;
        } else {
          Achievement newAchievement =
              element.copyWith(amount: element.amount + 1);
          return newAchievement;
        }
      } else {
        return element;
      }
    }).toList();
    //Check if any achievement is completed and show alert and update isAlert value
    for (var element in newListAchievement) {
      if (element.amount == element.total && element.isAlert == false) {
        element.isAlert = true;
        CustomDialog.showAlertAchievementDialog(element);
      }
    }

    UserModel newUserModel =
        userModel.copyWith(achievements: newListAchievement);

    await UserHiveLocal().saveUser(newUserModel);
    add(SaveUserCloud());
    emit(state.copyWith(isLoading: false, userModel: newUserModel));
  }

  _onAddAchievementEvent(AddAchievementEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    UserModel userModel = state.userModel;
    List<Achievement> achievements = List.from(userModel.achievements);
    achievements.add(event.achievement);
    UserModel newUserModel = userModel.copyWith(achievements: achievements);
    await UserHiveLocal().saveUser(newUserModel);
    add(SaveUserCloud());
    emit(state.copyWith(isLoading: false, userModel: newUserModel));
  }

  _onInitFavouriteSubTopic(InitFavouriteSubTopic event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    List<SubTopic> topics = await _vocabRepository.getFavouriteTopic();
    emit(state.copyWith(isLoading: false, favouriteSubTopic: topics));
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

  _onAddFavouriteTopic(AddFavouriteTopic event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    await FavouriteTopicLocal().addFavouriteTopic(event.topic);
    emit(state.copyWith(isLoading: false));
  }

  _onRemoveAFavouriteTopic(RemoveAFavouriteTopic event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    await FavouriteTopicLocal().removeAFavouriteTopic(event.topicId);
    emit(state.copyWith(isLoading: false));
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
