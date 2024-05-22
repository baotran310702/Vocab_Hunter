import 'package:english_learner/repository/user_repository.dart';
import 'package:english_learner/services/user_pref_local.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository = UserRepository();
  AuthenticationBloc() : super(AuthenticationState.initial()) {
    on<Login>(_onLogin);
    on<AuthWithToken>(_onAuthWithToken);
    on<Register>(_onRegister);
    on<Logout>(_onLogout);
  }
  _onLogin(Login event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(isLoading: true, success: null, error: null));

    try {
      var result = await _userRepository.signIn(event.email, event.password);
      emit(
        state.copyWith(
          isLoading: false,
          success: result,
          error: null,
        ),
      );
      return;
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: "Something went wrong, please try again.",
          success: null,
          
        ),
      );
      return;
    }
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
      UserPrefererencesLocal().saveUserId(result.$2);
    } else {
      emit(state.copyWith(isLoading: false, error: result.$2));
    }
  }

  _onLogout(Logout event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(isLoading: true, success: null, error: null));
    await _userRepository.signOut();
    emit(state.copyWith(isLoading: false, success: null, error: null));
  }

  _onAuthWithToken(
      AuthWithToken event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(isLoading: true, success: null, error: null));
    String token = await UserPrefererencesLocal().getToken();
    if (token.isEmpty) {
      emit(state.copyWith(
          isLoading: false,
          authStatus: AuthStatus.invalidToken,
          success: null));
      return;
    }
    var result = await _userRepository.signInWithToken(token);
    if (result == true) {
      emit(state.copyWith(
          isLoading: false, error: null, authStatus: AuthStatus.validToken));
    } else {
      emit(
        state.copyWith(
          isLoading: false,
          authStatus: AuthStatus.invalidToken,
          success: null,
        ),
      );
    }
  }
}
