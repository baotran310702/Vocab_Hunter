import 'dart:math';

import 'package:english_learner/utils/icons.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final Function(String) onChanged;
  final List<String> listItem;
  const CustomDropDown({
    super.key,
    required this.onChanged,
    required this.listItem,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String item = "";

  @override
  void initState() {
    item = widget.listItem[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey),
          ),
          height: 54,
          width: MediaQuery.of(context).size.width * 0.9,
          child: DropdownButton<String>(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            menuMaxHeight: MediaQuery.of(context).size.height * 0.3,
            alignment: AlignmentDirectional.topStart,
            borderRadius: BorderRadius.circular(10),
            value: item,
            icon: const SizedBox(),
            iconSize: 12,
            elevation: 8,
            underline: const SizedBox(),
            style: const TextStyle(color: Colors.deepPurple),
            onChanged: (String? newValue) {
              setState(() {
                item = newValue!;
              });
              widget.onChanged(newValue ?? "");
            },
            items: <String>[
              ...widget.listItem,
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                alignment: AlignmentDirectional.center,
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Positioned(
          top: 40,
          right: 16,
          child: Transform.rotate(
            angle: pi * 1.5,
            child: Image.asset(
              AppIcons.arrow,
              width: 18,
              height: 18,
            ),
          ),
        )
      ],
    );
  }
}
