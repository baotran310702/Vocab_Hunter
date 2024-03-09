import 'package:sqflite/sqflite.dart';

class TranslateServices {
  static const String pathDb = "assets/data/dictionary.db";

  late Database _db;

  TranslateServices() {
    _init();
  }

  void _init() async {
    await openDatabase(pathDb).then((value) {
      _db = value;
      print("debug#1 :DB OPENED");
    });
  }

  Future<void> translateLocal(String word) async {
    var result = await _db.rawQuery("select * from dictionary");
    if (result.isNotEmpty) {
      print(result);
    }
    await _db.close();
  }
}
