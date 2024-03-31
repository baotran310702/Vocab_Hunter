import 'package:english_learner/repository/user_repository.dart';
import 'package:english_learner/services/user_local.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository = UserRepository();
  AuthenticationBloc() : super(AuthenticationState.initial()) {
    on<Login>(_onLogin);
    on<Register>(_onRegister);
    on<Logout>(_onLogout);
  }
  _onLogin(Login event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(isLoading: true, success: null, error: null));

    await _userRepository.signIn(event.email, event.password).then((value) {
      UserLocal().saveUserId(value);
      emit(state.copyWith(
        isLoading: false,
        success: value,
      ));
    }).catchError((error) {
      emit(state.copyWith(
          isLoading: false, error: "User name or password wrong"));
    });
  }

  _onRegister(Register event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(isLoading: true, success: null, error: null));

    var result = await _userRepository.signUp(
        event.email, event.password, event.userName);
    if (result.$1) {
      emit(
        state.copyWith(
          isLoading: false,
          success: result.$2,
        ),
      );
    } else {
      emit(state.copyWith(isLoading: false, error: result.$2));
    }
  }

  _onLogout(Logout event, Emitter<AuthenticationState> emit) {
    emit(state.copyWith(isLoading: true));
  }
}
