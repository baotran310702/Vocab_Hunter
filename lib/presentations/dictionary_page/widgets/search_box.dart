import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  final TextEditingController vocabInputController;

  const SearchBox({
    super.key,
    required this.vocabInputController,
  });

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (context, controller) => SearchBar(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 4),
        ),
        controller: controller,
        hintText: 'Search for a word',
        onChanged: (value) {},
        onTap: () {
          controller.openView();
        },
        leading: const Padding(
          padding: EdgeInsets.only(
            left: 8,
            right: 8,
            top: 2,
          ),
          child: Icon(
            Icons.search,
          ),
        ),
        trailing: <Widget>[
          Tooltip(
            message: 'Change brightness mode',
            child: IconButton(
              isSelected: isDark,
              onPressed: () {
                setState(() {
                  isDark = !isDark;
                });
              },
              icon: const Icon(Icons.wb_sunny_outlined),
              selectedIcon: const Icon(Icons.brightness_2_outlined),
            ),
          )
        ],
      ),
      suggestionsBuilder: (context, controller) {
        return List<ListTile>.generate(5, (int index) {
          final String item = 'item $index';
          return ListTile(
            title: Text(item),
            onTap: () {
              setState(() {
                controller.closeView(item);
              });
            },
          );
        });
      },
    );
  }
}
