import 'dart:async';

import 'package:english_learner/models/notification.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/user_repository.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  final UserRepository _userRepository = UserRepository();

  late StreamSubscription _notificationSubscription;

  _initNotificationStream() {
    _notificationSubscription =
        _userRepository.streamNotificationApp().listen((event) {
      List<NotificationApp> notificationApps = [];
      for (var doc in event.docs) {
        notificationApps.add(NotificationApp.fromMap(doc.data()));
      }
      add(UpdateNotificationApp(notificationApps));
    });
  }

  GlobalBloc() : super(const GlobalState(isFront: true, notificationApps: [])) {
    on<GlobalInitialEvent>(_onGlobalInit);
    on<ChangeFlashCardSide>(_onUpdateChangeFlashCardSide);
    on<ResetFlashCardSide>(_onUpdateResetFlashCardSide);
    on<UpdateNotificationApp>(_onUpdateNotificationApp);
  }

  _onGlobalInit(GlobalInitialEvent event, Emitter emit) {
    _initNotificationStream();
  }

  @override
  Future<void> close() {
    _notificationSubscription.cancel();
    return super.close();
  }

  _onUpdateNotificationApp(
    UpdateNotificationApp event,
    Emitter<GlobalState> emit,
  ) {
    emit(state.copyWith(notificationApps: event.notificationApps));
  }

  _onUpdateChangeFlashCardSide(
    ChangeFlashCardSide event,
    Emitter<GlobalState> emit,
  ) {
    emit(state.copyWith(isFront: !state.isFront));
  }

  _onUpdateResetFlashCardSide(ResetFlashCardSide event, Emitter emit) {
    emit(state.copyWith(isFront: true));
  }
}
