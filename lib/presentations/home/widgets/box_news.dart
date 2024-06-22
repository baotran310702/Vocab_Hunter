import 'package:dio/dio.dart';
import 'package:english_learner/models/news.dart';
import 'package:english_learner/presentations/home/views/detail_news_vocabulary.dart';
import 'package:english_learner/utils/extension.dart';
import 'package:english_learner/utils/icons.dart';
import 'package:flutter/material.dart';

class BoxNews extends StatefulWidget {
  final News news;
  const BoxNews({super.key, required this.news});

  @override
  State<BoxNews> createState() => _BoxNewsState();
}

class _BoxNewsState extends State<BoxNews> {
  bool isImageWork = false;

  void checkValidImage() async {
    try {
      var res = await Dio().get(widget.news.urlToImage);
      if (res.statusCode == 200) {
        setState(() {
          isImageWork = true;
        });
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  void initState() {
    checkValidImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailNewsPage(
              news: widget.news,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: 120,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: Container(
                height: 120,
                width: 160,
                color: Colors.amber,
                child: isImageWork
                    ? Image.network(
                        widget.news.urlToImage,
                        fit: BoxFit.fitHeight,
                      )
                    : Image.asset(
                        AppIcons.capySleeping,
                        fit: BoxFit.fitHeight,
                      ),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                widget.news.title.capitalize(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.clip,
                maxLines: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
