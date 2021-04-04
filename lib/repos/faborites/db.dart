import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/product.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "favorites2.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
      print(db);
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Product ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "price INT,"
          "discount TEXT,"
          "imageUrl TEXT,"
          "referId TEXT,"
          "imageHash TEXT"
          ")");
    });
  }

  newClient(Product newProduct) async {
    try {
      final db = await database;
      //get the biggest id in the table
      var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Product");
      int id = table.first["id"];
      //insert to the table using the new id
      var raw = await db.rawInsert(
          "INSERT Into Product (id,name,price,discount,imageUrl,referId,imageHash)"
          " VALUES (?,?,?,?,?,?,?)",
          [
            id,
            newProduct.name,
            newProduct.price,
            newProduct.discount,
            newProduct.imageUrl,
            newProduct.id,
            newProduct.imageHash
          ]);
      return raw;
    } catch (e) {
      print(e);
    }
  }

  updateClient(Product newProduct) async {
    final db = await database;
    var res = await db.update("Product", newProduct.toMap(),
        where: "referId = ?", whereArgs: [newProduct.id]);
    return res;
  }

  getClient(String referId) async {
    final db = await database;
    var res =
        await db.query("Product", where: "referId = ?", whereArgs: [referId]);
      
    return res.isNotEmpty ? Product.fromMap(res.first) : null;
  }

  Future<List<Product>> getAllClients() async {
    final db = await database;
    var res = await db.query("Product");
    List<Product> list =
        res.isNotEmpty ? res.map((c) => Product.fromMap(c)).toList() : [];
    return list;
  }

  deleteClient(String referId) async {
    final db = await database;
    return db.delete("Product", where: "referId = ?", whereArgs: [referId]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Product");
  }
}
