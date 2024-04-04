part of 'global_bloc.dart';

class GlobalState {
  final bool isFront;

  GlobalState({required this.isFront});

  GlobalState copyWith({bool? isFront}) {
    return GlobalState(
      isFront: isFront ?? this.isFront,
    );
  }
}
