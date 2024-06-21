import 'package:dio/dio.dart';
import 'package:english_learner/models/news.dart';
import 'package:english_learner/presentations/global_instance/appbar.dart';
import 'package:english_learner/utils/extension.dart';
import 'package:flutter/material.dart';

class DetailNewsPage extends StatefulWidget {
  final News news;
  const DetailNewsPage({super.key, required this.news});

  @override
  State<DetailNewsPage> createState() => _DetailNewsPageState();
}

class _DetailNewsPageState extends State<DetailNewsPage> {
  bool isImageWork = false;

  void checkValidImage() async {
    try {
      var res = await Dio().get(widget.news.urlToImage);
      if (res.statusCode == 200) {
        setState(() {
          isImageWork = true;
        });
      }
    } catch (e) {}
  }

  @override
  void initState() {
    checkValidImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(text: "News"),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.news.title.capitalize(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 240,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.amber,
                        ),
                        child: isImageWork
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.network(widget.news.urlToImage,
                                    fit: BoxFit.fill),
                              )
                            : const Center(child: Text("Cover here")),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.news.content.capitalize(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
