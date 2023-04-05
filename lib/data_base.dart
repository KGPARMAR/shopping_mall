import 'package:online_shopping/product_list_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBase {
  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'shoppingmall.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE planets(id INTEGER PRIMARY KEY , slug TEXT NULL, title TEXT NULL, description TEXT NULL, price INTEGER NULL, featured_image TEXT NULL,status TEXT NULL, created_at TEXT NULL)",
        );
      },
    );
  }

  // insert data
  Future<int> insertPlanets(List<Data> planets) async {
    int result = 0;
    final Database db = await initializedDB();
    for (var planet in planets) {
      result = await db.insert('planets', planet.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    return result;
  }

  // retrieve data
  Future<List<Data>> retrievePlanets() async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult = await db.query('planets');
    return queryResult.map((e) => Data.fromJson(e)).toList();
  }

  // delete user
  Future<void> deletePlanet(int id) async {
    final db = await initializedDB();
    await db.delete(
      'planets',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}