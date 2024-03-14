import 'package:english_learner/models/vocabulary/vocabulary.dart';
import 'package:english_learner/presentations/dictionary_page/bloc/translate_page_bloc.dart';
import 'package:english_learner/presentations/dictionary_page/widgets/vocabulary_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/debouce.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  //params for search box
  TextEditingController vocabInputController = TextEditingController();

  //params for vocabulary
  Vocabulary? currentVocabulary;

  //params showing box result
  bool isShowingResult = false;

  final Debouncer _debouncer = Debouncer(
    delay: const Duration(
      milliseconds: 650,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TranslatePageBloc(),
      child: BlocBuilder<TranslatePageBloc, TranslatePageState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Dictionary'),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  Container(
                    color: Colors.amber,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        const SizedBox(height: 60),
                        Expanded(
                          child: VocabularyInfor(
                            vocabulary: currentVocabulary ?? Vocabulary.empty(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          child: Stack(
                            children: [
                              TextFormField(
                                style: const TextStyle(color: Colors.black),
                                controller: vocabInputController,
                                onChanged: (value) {
                                  setState(() {
                                    isShowingResult = true;
                                  });
                                  _debouncer.run(() {
                                    context
                                        .read<TranslatePageBloc>()
                                        .add(LoadingSearch());
                                    _onSearchChange(context, value.toString());
                                  });
                                },
                                onTap: () {
                                  setState(() {
                                    isShowingResult = true;
                                  });
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Search vocabulary here...',
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                child: IconButton(
                                  onPressed: () {
                                    vocabInputController.clear();
                                  },
                                  icon: const Icon(Icons.search),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 6, left: 4, right: 4),
                            constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: isShowingResult
                                  ? state.searchedVocabulary.length
                                  : 0,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                      state.searchedVocabulary[index].vocabId),
                                  trailing: Text(
                                    state.searchedVocabulary[index]
                                                .vietNameseMeaining[0].length <
                                            24
                                        ? state.searchedVocabulary[index]
                                            .vietNameseMeaining[0]
                                        : "${state.searchedVocabulary[index].vietNameseMeaining[0].toString().substring(0, 24)}...",
                                  ),
                                  onTap: () {
                                    setState(() {
                                      isShowingResult = false;
                                    });
                                    setState(() {
                                      currentVocabulary =
                                          state.searchedVocabulary[index];
                                    });
                                    vocabInputController.text =
                                        state.searchedVocabulary[index].vocabId;
                                  },
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onSearchChange(BuildContext context, String text) {
    // BlocProvider.of<TranslatePageBloc>(context).add(TranslateWordLocal(text));
    BlocProvider.of<TranslatePageBloc>(context).add(TranslateWordRemote(text));
  }
}
