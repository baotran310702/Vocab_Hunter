import 'package:sqflite/sqflite.dart';

class DictionaryLocal {
  static const String path = 'assets/dictionary.db';

  Future<Database> getCurrentDatabase() async {
    return await openDatabase(path);
  }

  Future<List<Map<String, dynamic>>> getWords() async {
    final db = await getCurrentDatabase();
    // query table av with all columns
    List<Map<String, dynamic>> result = await db.query('av');
    return result;
  }
}

class UserLocal {}
