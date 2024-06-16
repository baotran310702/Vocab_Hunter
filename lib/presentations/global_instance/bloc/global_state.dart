part of 'global_bloc.dart';

class GlobalState extends Equatable {
  final bool isLoading;
  final bool isFront;
  final List<NotificationApp> notificationApps;

  const GlobalState(
      {required this.isLoading,
      required this.isFront,
      required this.notificationApps});

  GlobalState copyWith({
    bool? isLoading,
    bool? isFront,
    List<NotificationApp>? notificationApps,
  }) {
    return GlobalState(
      isLoading: isLoading ?? this.isLoading,
      isFront: isFront ?? this.isFront,
      notificationApps: notificationApps ?? this.notificationApps,
    );
  }

  @override
  List<Object?> get props => [isLoading, isFront, notificationApps];
}
