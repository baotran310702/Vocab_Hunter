import 'package:english_learner/presentations/dictionary_page/bloc/translate_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DictionaryPage extends StatelessWidget {
  const DictionaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TranslatePageBloc(),
      child: BlocBuilder<TranslatePageBloc, TranslatePageState>(
        builder: (context, state) {
          return SafeArea(
            child: Column(children: [
              //create a drop down button
              DropdownButton<String>(
                  style: const TextStyle(color: Colors.black),
                  items: <String>['A', 'B', 'C', 'D'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    context
                        .read<TranslatePageBloc>()
                        .add(TranslateWordLocal(value ?? ""));
                  }),
            ]),
          );
        },
      ),
    );
  }
}
