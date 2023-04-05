/*
*    @author     KGPARMAR
*    @project    online_shopping
*    @file_name  data_base
*    @desc       Flutter Developer
*    @version    1.0.0
*    @since      1.0
*    @created on 05-Apr-23 10:45 PM
*    @updated on 05-Apr-23 10:45 PM
*    @Notes
*/

import 'package:online_shopping/model/product_list_model.dart';
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
          "CREATE TABLE products(id INTEGER PRIMARY KEY , slug TEXT NULL, title TEXT NULL, description TEXT NULL, price INTEGER NULL, featured_image TEXT NULL,status TEXT NULL, created_at TEXT NULL)",
        );
      },
    );
  }

  // insert data
  Future<int> insertProducts(List<Data> products) async {
    int result = 0;
    final Database db = await initializedDB();
    for (var planet in products) {
      result = await db.insert('products', planet.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    }

    return result;
  }

  // retrieve data
  Future<List<Data>> retrieveProducts() async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult = await db.query('products');
    return queryResult.map((e) => Data.fromJson(e)).toList();
  }

  // delete product
  Future<void> deleteProduct(int id) async {
    final db = await initializedDB();
    await db.delete(
      'products',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
