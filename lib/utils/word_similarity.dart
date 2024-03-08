import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_v2/tflite_v2.dart';

class WordSimilarityML {
  final String model = "assets/glove_model.tflite";
  final String labels = "assets/labels.txt";

  Interpreter? _interpreter;

  Future<List<String>> getSimilarWords(String word) async {
    List<String> similarWords = [];

    String? res = await Tflite.loadModel(model: model, labels: labels);

    if (res != null) {
      try {
        _interpreter = await Interpreter.fromAsset('assets/glove_model.tflite');
        if (_interpreter != null) {
          var output = List.filled(300, '').reshape([10, 30]);
          var input = List.filled(30, '').reshape([1, 30]);
          _interpreter?.run(input, output);
          print(_interpreter!.getOutputTensors().length);
        }
      } catch (e) {
        print(e);
      }
    }

    return similarWords;
  }
}
