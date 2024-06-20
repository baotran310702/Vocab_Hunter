part of 'manage_user_bloc.dart';

class ManageUserState extends Equatable {
  final UserModel userModel;
  final ListTimeNotification listTimeNotification;
  final bool isLoading;
  final String error;
  final String emailUSer;
  final List<Topic> favouriteTopics;
  final List<SubTopic>? favouriteSubTopic;

  const ManageUserState({
    required this.userModel,
    required this.listTimeNotification,
    required this.isLoading,
    required this.error,
    required this.emailUSer,
    required this.favouriteTopics,
    this.favouriteSubTopic,
  });

  factory ManageUserState.initial() {
    return ManageUserState(
      userModel: UserModel.defaultInit(),
      listTimeNotification: ListTimeNotification.initial(),
      isLoading: false,
      error: '',
      emailUSer: "",
      favouriteTopics: const [],
      favouriteSubTopic: const [],
    );
  }

  ManageUserState copyWith({
    UserModel? userModel,
    ListTimeNotification? listTimeNotification,
    bool? isLoading,
    String? error,
    String? emailUSer,
    List<Topic>? topics,
    List<SubTopic>? favouriteSubTopic,
  }) {
    return ManageUserState(
      userModel: userModel ?? this.userModel,
      listTimeNotification: listTimeNotification ?? this.listTimeNotification,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      emailUSer: emailUSer ?? this.emailUSer,
      favouriteTopics: topics ?? favouriteTopics,
      favouriteSubTopic: favouriteSubTopic ?? this.favouriteSubTopic,
    );
  }

  @override
  List<Object?> get props => [
        userModel,
        listTimeNotification,
        isLoading,
        error,
        emailUSer,
        favouriteTopics,
        favouriteSubTopic,
      ];
}
