import 'package:flutter/material.dart';

class BoxNews extends StatefulWidget {
  const BoxNews({super.key});

  @override
  State<BoxNews> createState() => _BoxNewsState();
}

class _BoxNewsState extends State<BoxNews> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 120,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.black12,
      ),
      child: Row(
        children: [
          Container(
            height: 120,
            width: 160,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              color: Colors.amber,
            ),
          ),
          const SizedBox(width: 10),
          const Flexible(
            child: Text(
              "Tin tức mới nhất về chủ đề học tiếng Anh",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.clip,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
