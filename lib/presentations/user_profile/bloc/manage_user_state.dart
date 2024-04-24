part of 'manage_user_bloc.dart';

class ManageUserState extends Equatable {
  final UserModel userModel;
  final ListTimeNotification listTimeNotification;
  final bool isLoading;
  final String error;

  const ManageUserState({
    required this.userModel,
    required this.listTimeNotification,
    required this.isLoading,
    required this.error,
  });

  factory ManageUserState.initial() {
    return ManageUserState(
      userModel: UserModel.defaultInit(),
      listTimeNotification: ListTimeNotification.initial(),
      isLoading: false,
      error: '',
    );
  }

  ManageUserState copyWith({
    UserModel? userModel,
    ListTimeNotification? listTimeNotification,
    bool? isLoading,
    String? error,
  }) {
    return ManageUserState(
      userModel: userModel ?? this.userModel,
      listTimeNotification: listTimeNotification ?? this.listTimeNotification,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        userModel,
        listTimeNotification,
        isLoading,
        error,
      ];
}
