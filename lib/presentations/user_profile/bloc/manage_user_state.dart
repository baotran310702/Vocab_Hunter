part of 'manage_user_bloc.dart';

class ManageUserState extends Equatable {
  final UserModel userModel;
  final ListTimeNotification listTimeNotification;
  final bool isLoading;
  final String error;
  final String emailUSer;

  const ManageUserState({
    required this.userModel,
    required this.listTimeNotification,
    required this.isLoading,
    required this.error,
    required this.emailUSer,
  });

  factory ManageUserState.initial() {
    return ManageUserState(
      userModel: UserModel.defaultInit(),
      listTimeNotification: ListTimeNotification.initial(),
      isLoading: false,
      error: '',
      emailUSer: "",
    );
  }

  ManageUserState copyWith({
    UserModel? userModel,
    ListTimeNotification? listTimeNotification,
    bool? isLoading,
    String? error,
    String? emailUSer,
  }) {
    return ManageUserState(
      userModel: userModel ?? this.userModel,
      listTimeNotification: listTimeNotification ?? this.listTimeNotification,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      emailUSer: emailUSer ?? this.emailUSer,
    );
  }

  @override
  List<Object?> get props => [
        userModel,
        listTimeNotification,
        isLoading,
        error,
        emailUSer,
      ];
}
