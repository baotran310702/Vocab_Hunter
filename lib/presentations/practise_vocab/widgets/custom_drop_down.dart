import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({super.key});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String item = "item 1";
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
      ),
      height: 54,
      width: MediaQuery.of(context).size.width * 0.9,
      child: DropdownButton<String>(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        menuMaxHeight: MediaQuery.of(context).size.height * 0.3,
        alignment: AlignmentDirectional.center,
        borderRadius: BorderRadius.circular(10),
        value: item,
        icon: const SizedBox(),
        iconSize: 24,
        elevation: 8,
        underline: const SizedBox(),
        style: const TextStyle(color: Colors.deepPurple),
        onChanged: (String? newValue) {
          setState(() {
            item = newValue!;
          });
        },
        items: <String>[
          'item 1',
          'item 2',
          'item 3',
          'item 4',
          'item 5',
          'item 6',
          'item 7',
          'item 8',
          'item 9',
          'item 10'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            alignment: AlignmentDirectional.center,
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
