part of 'global_bloc.dart';

class GlobalState extends Equatable {
  final bool isFront;

  GlobalState({required this.isFront});

  GlobalState copyWith({bool? isFront}) {
    return GlobalState(
      isFront: isFront ?? this.isFront,
    );
  }

  @override
  List<Object?> get props => [isFront];
}
