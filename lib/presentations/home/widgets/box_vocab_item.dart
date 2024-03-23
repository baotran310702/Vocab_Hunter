import 'package:english_learner/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class BoxVocab extends StatefulWidget {
  const BoxVocab({super.key});

  @override
  State<BoxVocab> createState() => _BoxVocabState();
}

class _BoxVocabState extends State<BoxVocab> {
  double scale = 1;
  void handleScale() async {
    setState(() {
      scale = 0.9;
    });
    await Future.delayed(const Duration(milliseconds: 160));
    setState(() {
      scale = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        handleScale();
      },
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 280),
        child: Container(
          padding: const EdgeInsets.all(6.0),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 185,
          height: 185,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Assets.icons.tag_save.image(width: 24, height: 24),
                ],
              ),
              const Text(
                "Word Name",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                "/pronounce/",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const Text(
                "word type",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "Meaning123123123123123123123123123123123123123",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
