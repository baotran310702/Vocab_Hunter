import 'package:flutter_bloc/flutter_bloc.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(GlobalState(isFront: true)) {
    on<FlashCardSide>(_onUpdateFlashCardSide);
  }

  _onUpdateFlashCardSide(
    FlashCardSide event,
    Emitter<GlobalState> emit,
  ) {
    emit(state.copyWith(isFront: !state.isFront));
  }
}
