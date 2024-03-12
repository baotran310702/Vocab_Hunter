import 'package:english_learner/models/vocabulary.dart';
import 'package:english_learner/presentations/dictionary_page/bloc/translate_page_bloc.dart';
import 'package:english_learner/presentations/dictionary_page/widgets/search_box.dart';
import 'package:english_learner/presentations/dictionary_page/widgets/vocabulary_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  TextEditingController vocabInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> vocabList = [
      'ok ok ok',
      'low g',
      ' chan gai 707',
      'ok ok ok',
      'low g',
      ' chan gai 707',
      'ok ok ok',
      'low g',
      ' chan gai 707',
      'ok ok ok',
      'low g',
      ' chan gai 707',
      'ok ok ok',
      'low g',
      ' chan gai 707',
    ];

    return BlocProvider(
      create: (context) => TranslatePageBloc(),
      child: BlocBuilder<TranslatePageBloc, TranslatePageState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Dictionary'),
              centerTitle: true,
            ),
            body: SafeArea(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SearchBox(
                        vocabInputController: vocabInputController,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child:
                          VocabularyInfor(vocabulary: Vocabulary.seedData[0]),
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

  void _onSearchChange() {}
}
