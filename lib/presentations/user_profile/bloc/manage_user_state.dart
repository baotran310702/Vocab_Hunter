part of 'manage_user_bloc.dart';

class ManageUserState extends Equatable {
  final UserModel userModel;
  final bool isLoading;
  final String error;

  const ManageUserState({
    required this.userModel,
    required this.isLoading,
    required this.error,
  });

  factory ManageUserState.initial() {
    return ManageUserState(
      userModel: UserModel.defaultInit(),
      isLoading: false,
      error: '',
    );
  }

  ManageUserState copyWith({
    UserModel? userModel,
    bool? isLoading,
    String? error,
  }) {
    return ManageUserState(
      userModel: userModel ?? this.userModel,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [userModel, isLoading, error];
}
