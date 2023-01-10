import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/models/todo_model.dart';

class DBHelper {
  DBHelper._();

  static DBHelper dbHelper = DBHelper._();

  Database? db;
  String DatabasePath = "";
  String table = "todo";

  Future<Database?> initDB() async {
    String path = await getDatabasesPath();
    DatabasePath = join(path, "data.db");

    db = await openDatabase(DatabasePath, version: 1,
        onCreate: (Database db, version) async {
      String query =
          "CREATE TABLE IF NOT EXISTS $table (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT,startTime TEXT,endTime TEXT,description TEXT);";
      await db.execute(query);
    });
    String query =
        "CREATE TABLE IF NOT EXISTS $table (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT,startTime TEXT,endTime TEXT,description TEXT);";
    await db?.execute(query);
    return db;
  }

  Future<void> insertData(
      {required String title,
      required String starTime,
      required String endTime,
      required String description}) async {
    db = await initDB();
    String query =
        "INSERT INTO $table(id, title,startTime,endTime,description) VALUES(?,?,?,?,?)";
    List arg = [null, title, starTime, endTime, description];
    print(starTime);

    await db!.rawInsert(query, arg);
  }

  Future<List<todoModel>> fetchapp() async {
    db = await initDB();
    String qeury = "SELECT * FROM $table";
    List<Map<String, dynamic>> fetch = await db!.rawQuery(qeury);
    List<todoModel> allData = animalFromJson(jsonEncode(fetch));
    return allData;
  }
 update({required id,required name,required startTime,required endTime,required description})async{
    db = await initDB();
    String query = "UPDATE $table SET title=?,startTime=?,endTime=?,description=? WHERE id=?";
    List arg = [ name, startTime, endTime, description,id];

    db!.rawQuery(query,arg);
 }

  deleteData({required id}) async{
    db = await initDB();
    String qeury = "DELETE FROM $table WHERE id=$id";
    db!.rawQuery(qeury);
  }
}
