import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(const GlobalState(isFront: true)) {
    on<ChangeFlashCardSide>(_onUpdateChangeFlashCardSide);
    on<ResetFlashCardSide>(_onUpdateResetFlashCardSide);
  }

  _onUpdateChangeFlashCardSide(
    ChangeFlashCardSide event,
    Emitter<GlobalState> emit,
  ) {
    emit(state.copyWith(isFront: !state.isFront));
  }

  _onUpdateResetFlashCardSide(ResetFlashCardSide event, Emitter emit) {
    emit(state.copyWith(isFront: true));
  }
}
