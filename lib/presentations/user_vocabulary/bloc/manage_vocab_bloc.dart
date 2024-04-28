import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:english_learner/models/user.dart';
import 'package:english_learner/models/vocabulary/vocabulary.dart';
import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';
import 'package:english_learner/repository/user_repository.dart';
import 'package:english_learner/repository/vocab_repository.dart';
import 'package:english_learner/services/translate_services.dart';
import 'package:equatable/equatable.dart';

import '../../../models/user_vocab.dart';
import '../../../models/vocabulary/vocab_word_similarity.dart';
import '../../../services/user_hive_local.dart';
import '../../../services/user_pref_local.dart';

part 'manage_vocab_event.dart';
part 'manage_vocab_state.dart';

//Handle event to manage vocab

class ManageVocabBloc extends Bloc<ManageVocabEvent, ManageVocabState> {
  final VocabRepository _vocabRepository = VocabRepository();
  final UserRepository _userRepository = UserRepository();
  final TranslateServices _translateServices = TranslateServices();

  ManageVocabBloc() : super(ManageVocabState.initial()) {
    on<InitUserVocabEvent>(_onInitUserVocabEvent);

    on<AddVocabEvent>(_onAddVocab);
    on<RemoveVocabEvent>(_onRemoveVocab);

    on<UpdateVocabEvent>(_onUpdateVocab);
    on<LoadVocabEvent>(_onLoadVocab);
    on<GetSimilarityVocabEvent>(_onGetSimilarityVocab);

    on<GetMeaningVocab>(_onGetMeaningVocab);
    on<GetSimilarityVocabLocalEvent>(_onGetSimilarityVocabLocal,
        transformer: droppable());
    on<GetSimilarVocabModel>(_onGetSimilarVocabModel);
    on<ClearRecommendVocabEvent>(_onClearRecommendVocabEvent);

    on<AddNewListLearningVocab>(_onAddNewListLearningVocab);
    on<RemoveFromListLearning>(_onRemoveFromListLearning);
    on<DeleteListLearningVocab>(_onDeleteListLearningVocab);
    on<AddVocabToListLearning>(_onAddVocabToListLearning);
    on<DeleteVocabFromListLearning>(_onDeleteVocabFromListLearning);
    on<UpdateListLearningVocab>(_onUpdateListLearningVocab);
    on<SyncUserData>(_onSyncUserData);
    on<SetDefaultListLearningVocab>(_onSetDefaultListLearning);
  }

  _onInitUserVocabEvent(
      InitUserVocabEvent event, Emitter<ManageVocabState> emit) async {
    UserModel currentUser = await UserHiveLocal().getUser();
    String? currentDefaultId =
        await UserPrefererencesLocal().getDefaultListLearningVocab();
    if (currentDefaultId == null) {
      await UserPrefererencesLocal().setDefaultListLearningVocab(
          currentUser.learningWords.isNotEmpty
              ? currentUser.learningWords[0].listId
              : '');
      emit(state.copyWith(
          userModel: currentUser,
          currentDefaultListId: currentUser.learningWords.isNotEmpty
              ? currentUser.learningWords[0].listId
              : ''));
      return;
    }
    emit(state.copyWith(
        userModel: currentUser, currentDefaultListId: currentDefaultId));
  }

  _onAddVocab(AddVocabEvent event, Emitter<ManageVocabState> emit) {
    emit(
        state.copyWith(vocabList: List.from(state.vocabList)..add(event.word)));
  }

  _onRemoveVocab(RemoveVocabEvent event, Emitter<ManageVocabState> emit) {
    List<Vocabulary> newVocabList = List.from(state.vocabList);
    newVocabList.removeWhere((element) => element.vocabId == event.word);
    emit(state.copyWith(vocabList: newVocabList));
  }

  _onUpdateVocab(UpdateVocabEvent event, Emitter<ManageVocabState> emit) {
    int index = state.vocabList
        .indexWhere((element) => element.vocabId == event.word.vocabId);
    //update word in list with that index
    List<Vocabulary> newVocabList = List.from(state.vocabList);
    newVocabList[index] = event.word;

    emit(state.copyWith(vocabList: newVocabList));
  }

  _onLoadVocab(LoadVocabEvent event, Emitter<ManageVocabState> emit) async {}

  _onGetSimilarityVocab(
      GetSimilarityVocabEvent event, Emitter<ManageVocabState> emit) async {
    emit(state.copyWith(isLoading: true));
    List<VocabWordSimilarity> similarVocabs =
        await _vocabRepository.getSimilarVocab(event.inputVocab);

    List<VocabWordSimilarity> highestSimilarity = List.generate(
        similarVocabs.length > 10 ? 10 : similarVocabs.length,
        (index) => similarVocabs[index]);

    var listTranslated = await Future.wait(highestSimilarity
        .map((e) => _translateServices.translateWordOnline(e.word)));

    emit(state.copyWith(
      similarVocabs: similarVocabs,
      isLoading: false,
      vocabRemoteList: listTranslated.map((e) => e).toList(),
    ));
  }

  _onGetSimilarityVocabLocal(GetSimilarityVocabLocalEvent event,
      Emitter<ManageVocabState> emit) async {
    emit(state.copyWith(isLoading: true));
    List<VocabWordSimilarity> similarVocabs =
        await _vocabRepository.getSimilarVocabLocal(event.inputVocab);

    List<VocabWordSimilarity> highestSimilarity = List.generate(
        similarVocabs.length > 14 ? 14 : similarVocabs.length,
        (index) => similarVocabs[index]);

    var listTranslated = await Future.wait(highestSimilarity
        .map((e) => _translateServices.translateWordOnline(e.word)));

    emit(state.copyWith(
      similarVocabs: similarVocabs,
      isLoading: false,
      vocabRemoteList: listTranslated
          .where(
            (e) =>
                e.$1 != VocabularyRemote.empty() &&
                e.$2 != VocabularyRemote.empty() &&
                e.$1.meanings?.isNotEmpty == true,
          )
          .toList(),
    ));
  }

  _onGetMeaningVocab(
      GetMeaningVocab event, Emitter<ManageVocabState> emit) async {
    emit(state.copyWith(isLoading: true));
    String meaning = await _vocabRepository.getTranslation(event.inputVocab);
    emit(state.copyWith(meaningRecommendVocabs: meaning, isLoading: false));
  }

  _onGetSimilarVocabModel(
      GetSimilarVocabModel event, Emitter<ManageVocabState> emit) async {
    emit(state.copyWith(isLoading: true));
  }

  _onClearRecommendVocabEvent(
      ClearRecommendVocabEvent event, Emitter<ManageVocabState> emit) {
    emit(state.copyWith(
      vocabRemoteList: List.empty(),
      similarVocabs: List.empty(),
      isLoading: false,
    ));
  }

  ///Handle UserVocab

  _onAddNewListLearningVocab(
      AddNewListLearningVocab event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    UserModel currentUser = state.userModel;
    int currentIndex = currentUser.learningWords.length;

    if (currentIndex == 0) {
      await UserPrefererencesLocal()
          .setDefaultListLearningVocab(currentIndex.toString());
    }

    List<UserVocab> currentUserList = currentUser.learningWords;
    List<UserVocab> newList = List.from(currentUserList);
    newList.add(UserVocab(
        listId: currentIndex.toString(),
        listName: event.name,
        listVocabulary: const {
          'english': [],
          'translated': [],
        }));

    UserModel newUsers = currentUser.copyWith(learningWords: newList);

    await UserHiveLocal().saveUser(newUsers);

    emit(state.copyWith(
      isLoading: false,
      userModel: newUsers,
    ));
  }

  _onRemoveFromListLearning(RemoveFromListLearning event, Emitter emit) async {
    UserModel currentUser = state.userModel;

    String currentListId =
        await UserPrefererencesLocal().getDefaultListLearningVocab() ?? '';

    List<UserVocab> listUpdated = currentUser.learningWords.map((e) {
      if (e.listId == currentListId) {
        List<VocabularyRemote> currentRemoveList = e
            .listVocabulary.entries.first.value
            .where((element) => element.word != event.vocab.word)
            .toList();
        return e.copyWith(
            listVocabulary: {e.listVocabulary.keys.first: currentRemoveList});
      }
      return e;
    }).toList();

    UserModel newUSers = currentUser.copyWith(learningWords: listUpdated);

    UserHiveLocal().saveUser(newUSers);

    emit(state.copyWith(userModel: newUSers));
  }

  _onDeleteListLearningVocab(
      DeleteListLearningVocab event, Emitter emit) async {
    UserModel currentUser = state.userModel;

    List<UserVocab> newList = currentUser.learningWords
        .where((element) => element.listId != event.listId)
        .toList();
    await UserHiveLocal()
        .saveUser(currentUser.copyWith(learningWords: newList));
    emit(state.copyWith(
        userModel: currentUser.copyWith(learningWords: newList)));
  }

  _onAddVocabToListLearning(AddVocabToListLearning event, Emitter emit) async {
    String listDefaultId =
        await UserPrefererencesLocal().getDefaultListLearningVocab() ?? '';
    UserModel currentUser = state.userModel;
    List<UserVocab> listUpdated = currentUser.learningWords.map((e) {
      if (e.listId == listDefaultId) {
        Map<String, List<VocabularyRemote>> currentList = {};
        String key1 = e.listVocabulary.keys.first;
        String key2 = e.listVocabulary.keys.last;
        List<VocabularyRemote> currentListEnglish =
            List.from(e.listVocabulary[key1]!);
        List<VocabularyRemote> currentListTranslated =
            List.from(e.listVocabulary[key2]!);
        currentList.addAll({key1: currentListEnglish..add(event.vocabEng)});
        currentList.addAll({key2: currentListTranslated..add(event.vocabViet)});

        return e.copyWith(listVocabulary: currentList);
      }
      return e;
    }).toList();

    UserModel newUsers = currentUser.copyWith(learningWords: listUpdated);

    await UserHiveLocal().saveUser(newUsers);

    emit(state.copyWith(userModel: newUsers));
  }

  _onDeleteVocabFromListLearning(
      DeleteVocabFromListLearning event, Emitter emit) async {
    UserModel currentUser = state.userModel;
    List<UserVocab> listDeleted = currentUser.learningWords
        .where(
          (element) => element.listId != event.listId,
        )
        .toList();

    UserModel newUSers = currentUser.copyWith(learningWords: listDeleted);

    await UserHiveLocal().saveUser(newUSers);

    emit(state.copyWith(userModel: newUSers));
  }

  _onUpdateListLearningVocab(UpdateListLearningVocab event, Emitter emit) {
    List<UserVocab> updatedList = state.userModel.learningWords.map((e) {
      if (e.listId == event.listId) {
        return e.copyWith(listName: event.listName);
      }
      return e;
    }).toList();
    UserHiveLocal()
        .saveUser(state.userModel.copyWith(learningWords: updatedList));
    emit(state.copyWith(
        userModel: state.userModel.copyWith(learningWords: updatedList)));
  }

  _onSetDefaultListLearning(
      SetDefaultListLearningVocab event, Emitter emit) async {
    await UserPrefererencesLocal().setDefaultListLearningVocab(event.listId);
    emit(state.copyWith(currentDefaultListId: event.listId));
  }

  _onSyncUserData(SyncUserData event, Emitter emit) async {
    emit(state.copyWith(isSync: true));
    await _userRepository.syncUserData();
    emit(state.copyWith(isSync: false));
  }
}
