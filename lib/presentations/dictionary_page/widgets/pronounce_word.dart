import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class PronounceWord extends StatefulWidget {
  final String word;
  const PronounceWord({super.key, required this.word});

  @override
  State<PronounceWord> createState() => _PronounceWordState();
}

class _PronounceWordState extends State<PronounceWord> {
  late FlutterTts flutterTts;
  String? language;
  String? engine;
  double volume = 0.5;
  double pitch = 1;
  double rate = 0.2;
  bool isCurrentLanguageInstalled = false;

  @override
  initState() {
    super.initState();
    initTts();
  }

  initTts() async {
    flutterTts = FlutterTts();

    flutterTts = FlutterTts();
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    _setAwaitOptions();

    _getDefaultVoice();
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future _getDefaultVoice() async {
    await flutterTts.getVoices;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _speak();
      },
      child: Icon(Icons.volume_up_rounded, size: 30, color: Colors.blue[600]),
    );
  }

  Future _speak() async {
    if (widget.word.isNotEmpty) {
      await flutterTts.speak(widget.word);
    }
  }
}
