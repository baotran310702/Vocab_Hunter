import 'package:bloc/bloc.dart';
import 'package:english_learner/models/vocabulary.dart';

part 'manage_vocab_state.dart';
part 'manage_vocab_event.dart';


//Handle event to manage vocab

class ManageVocabBloc extends Bloc<ManageVocabEvent, ManageVocabState> {
  ManageVocabBloc() : super(ManageVocabState.initial()){
    on<AddVocabEvent>((event, emit) {
     
      emit(state.copyWith(vocabList: List.from(state.vocabList)..add(Vocabulary(word: event.word, meaning: event.meaning))));
    });

    on<RemoveVocabEvent>((event, emit) {
      final List<Vocabulary> newVocabList = List.from(state.vocabList)..remove(event.vocab);
      emit(ManageVocabState(vocabList: newVocabList));
    });

    on<UpdateVocabEvent>((event, emit) {
      final List<Vocabulary> newVocabList = List.from(state.vocabList)..[event.index] = event.vocab;
      emit(ManageVocabState(vocabList: newVocabList));
    });

    on<ClearVocabEvent>((event, emit) {
      emit(ManageVocabState(vocabList: []));
    });

    on<LoadVocabEvent>((event, emit) {
      emit(ManageVocabState(vocabList: event.vocabList));
    });


  };

}
