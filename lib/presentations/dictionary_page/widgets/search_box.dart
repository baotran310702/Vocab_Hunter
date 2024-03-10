import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  final TextEditingController vocabInputController;
  final List<String> vocabList;

  const SearchBox({
    super.key,
    required this.vocabInputController,
    required this.vocabList,
  });

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            TextFormField(
              controller: widget.vocabInputController,
              decoration: const InputDecoration(
                labelText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                contentPadding: EdgeInsets.all(10),
                constraints: BoxConstraints(
                  maxHeight: 60,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
