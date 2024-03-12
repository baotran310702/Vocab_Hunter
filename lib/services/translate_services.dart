import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TranslateServices {
  late Database _db;

  TranslateServices() {
    _init();
  }

  void _init() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "database.db");
    var exist = await databaseExists(path);
    if (exist) {
      _db = await openDatabase(path);
    }
  }

  Future<void> translateLocal(String word) async {
    print("debug#1 _db ${await _db.getVersion()}");
    List<Map<String, dynamic>> results =
        await _db.rawQuery("Select * from vocabulary");
    // Thực hiện truy vấn để lấy tất cả tên bảng

    print("debug#1 result ${results.first}");
  }
}
