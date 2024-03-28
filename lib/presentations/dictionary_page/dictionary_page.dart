import 'package:english_learner/models/vocabulary/vocabulary.dart';
import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';
import 'package:english_learner/presentations/dictionary_page/bloc/translate_page_bloc.dart';
import 'package:english_learner/presentations/home/widgets/header_informations.dart';
import 'package:english_learner/presentations/home/widgets/vocabulary_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/debouce.dart';
import 'views/detail_vocabulary.dart';

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
            body: SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeaderInformations(
                      title: "Search anywords you want,lets learn togother!",
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 66),
                            child: Column(
                              children: [
                                const Text(
                                  "Search History",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      children: List.generate(
                                        10,
                                        (index) => Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5,
                                              ),
                                            ),
                                          ),
                                          child: InkWell(
                                              onTap: () {
                                                _onTapDetailVocabulary(
                                                    context,
                                                    state.searchedVocabulary[
                                                        index]);
                                              },
                                              child: const VocabularyItem()),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          searchBox(context, state),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget searchBox(BuildContext context, TranslatePageState state) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
                    context.read<TranslatePageBloc>().add(LoadingSearch());
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
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
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
            margin: const EdgeInsets.only(top: 6, left: 4, right: 4),
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.4,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: isShowingResult ? state.searchedVocabulary.length : 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.searchedVocabulary[index].vocabId),
                  trailing: Text(
                    state.searchedVocabulary[index].vietNameseMeaining[0]
                                .length <
                            24
                        ? state.searchedVocabulary[index].vietNameseMeaining[0]
                        : "${state.searchedVocabulary[index].vietNameseMeaining[0].toString().substring(0, 24)}...",
                  ),
                  onTap: () {
                    setState(() {
                      isShowingResult = false;
                      currentVocabulary = state.searchedVocabulary[index];
                    });

                    vocabInputController.text =
                        state.searchedVocabulary[index].vocabId;
                    _onTapDetailVocabulary(
                        context, state.searchedVocabulary[index]);
                  },
                );
              },
            ),
          ),
        )
      ],
    );
  }

  void _onTapDetailVocabulary(BuildContext context, Vocabulary vocabulary) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailVocabulary(
          vocabularyRemote: VocabularyRemote.empty(),
        ),
      ),
    );
  }

  void _onSearchChange(BuildContext context, String text) {
    BlocProvider.of<TranslatePageBloc>(context).add(TranslateWordLocal(text));
    // BlocProvider.of<TranslatePageBloc>(context).add(TranslateWordRemote(text));
  }
}
