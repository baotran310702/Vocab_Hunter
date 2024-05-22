part of 'global_bloc.dart';

class GlobalState extends Equatable {
  final bool isFront;
  final List<NotificationApp> notificationApps;

  const GlobalState({required this.isFront, required this.notificationApps});

  GlobalState copyWith({
    bool? isFront,
    List<NotificationApp>? notificationApps,
  }) {
    return GlobalState(
      isFront: isFront ?? this.isFront,
      notificationApps: notificationApps ?? this.notificationApps,
    );
  }

  @override
  List<Object?> get props => [isFront, notificationApps];
}
