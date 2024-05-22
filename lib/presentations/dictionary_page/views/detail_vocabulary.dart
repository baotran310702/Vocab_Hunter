import 'package:english_learner/models/vocabulary/vocab_translated_local.dart';
import 'package:english_learner/models/vocabulary/vocabulary_remote.dart';
import 'package:english_learner/presentations/dictionary_page/bloc/translate_page_bloc.dart';
import 'package:english_learner/presentations/dictionary_page/widgets/pronounce_word.dart';
import 'package:english_learner/presentations/home/widgets/back_button.dart';
import 'package:english_learner/utils/colors.dart';
import 'package:english_learner/utils/converter.dart';
import 'package:english_learner/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailVocabulary extends StatefulWidget {
  final VocabularyRemote? vocabularyRemote;
  final String? word;
  final VocabTranslatedLocalModel? vocabTranslatedLocal;
  const DetailVocabulary({
    super.key,
    this.word,
    this.vocabularyRemote,
    this.vocabTranslatedLocal,
  });

  @override
  State<DetailVocabulary> createState() => _DetailVocabularyState();
}

class _DetailVocabularyState extends State<DetailVocabulary>
    with TickerProviderStateMixin {
  final PageController _pageViewController = PageController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TranslatePageBloc()
        ..add(TranslateWordRemote(word: widget.word ?? "")),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.word?.capitalize() ??
              widget.vocabTranslatedLocal?.englishWords.word?.capitalize() ??
              ""),
          leading: const ButtonBack(),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                text: "Vietnamese - English",
              ),
              Tab(
                text: "English - English",
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            controller: _tabController,
            children: [
              DetailVocabularyPage(
                isVietnamese: false,
                vocabularyRemote: widget.vocabTranslatedLocal,
              ),
              DetailVocabularyPage(
                isVietnamese: true,
                vocabularyRemote: widget.vocabTranslatedLocal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailVocabularyPage extends StatefulWidget {
  final bool isVietnamese;
  final VocabTranslatedLocalModel? vocabularyRemote;

  const DetailVocabularyPage({
    super.key,
    required this.isVietnamese,
    this.vocabularyRemote,
  });

  @override
  State<DetailVocabularyPage> createState() => _DetailVocabularyPageState();
}

class _DetailVocabularyPageState extends State<DetailVocabularyPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<TranslatePageBloc, TranslatePageState>(
        buildWhen: (previous, current) {
          return previous.currentVocabularyRemote !=
              current.currentVocabularyRemote;
        },
        builder: (context, state) {
          if (state.currentVocabularyRemote == null || state.isLoading) {
            if (widget.vocabularyRemote == null) {
              return const Center(child: CircularProgressIndicator());
            }
          }
          VocabularyRemote currentVocabularyRemote = widget.isVietnamese
              ? widget.vocabularyRemote != null
                  ? widget.vocabularyRemote!.englishWords
                  : state.currentVocabularyRemote!.$1
              : widget.vocabularyRemote != null
                  ? widget.vocabularyRemote!.vietnameseWords
                  : state.currentVocabularyRemote!.$2;

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${currentVocabularyRemote.word}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          widget.isVietnamese
                              ? Text(
                                  "${currentVocabularyRemote.phonetic}",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      widget.isVietnamese
                          ? PronounceWord(
                              word: currentVocabularyRemote.word ?? "",
                            )
                          : const SizedBox()
                    ],
                  ),
                  const Devider(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (Meanings meanings
                          in currentVocabularyRemote.meanings!)
                        BoxMeaning(
                          meanings: meanings,
                          isVietnamese: !widget.isVietnamese,
                        ),
                      const SizedBox(height: 20),
                    ],
                  ),
                  Column(
                    children: [
                      const Devider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              widget.isVietnamese ? "Atonymns" : "Đồng nghĩa",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Text(
                              widget.isVietnamese ? "Synonyms" : "Trái nghĩa",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Devider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                for (Meanings synonym
                                    in currentVocabularyRemote.meanings ?? [])
                                  for (String word in synonym.synonyms ?? [])
                                    Text(word)
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                for (Meanings antonym
                                    in currentVocabularyRemote.meanings ?? [])
                                  for (String word in antonym.antonyms ?? [])
                                    Text(word)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class BoxMeaning extends StatelessWidget {
  final Meanings meanings;
  final bool? isVietnamese;
  const BoxMeaning({
    this.isVietnamese,
    required this.meanings,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 40,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 160,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.textInputs,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                isVietnamese != null && isVietnamese == true
                    ? CustomConverter.convertVietnameseWordType(
                        meanings.partOfSpeech?.capitalize() ?? "")
                    : meanings.partOfSpeech?.capitalize() ?? "",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textInputs,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          meanings.definitions != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (Definitions definition in meanings.definitions!)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          definition.definition?.trim().capitalize() != "" &&
                                  definition.definition?.trim().capitalize() !=
                                      "."
                              ? Text(
                                  "- ${definition.definition?.capitalize() ?? ""}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              : const SizedBox(),
                          definition.example != null
                              ? Text(
                                  definition.example?.capitalize() ?? "",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey,
                                  ),
                                )
                              : const SizedBox(
                                  height: 6,
                                ),
                        ],
                      ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class Devider extends StatelessWidget {
  const Devider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      height: 1,
      color: Colors.black,
    );
  }
}
