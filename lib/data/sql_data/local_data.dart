import 'package:gavhar_app/data/models/network_respons/network_respons_model.dart';
import 'package:gavhar_app/data/models/product/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static final databaseInstance = LocalDatabase._();

  LocalDatabase._();

  factory LocalDatabase() {
    return databaseInstance;
  }

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _init("todo.db");
      return _database!;
    }
  }

  Future<Database> _init(String databaseName) async {
    String internalPath = await getDatabasesPath();
    String path = join(internalPath, databaseName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";

    await db.execute('''CREATE TABLE Products (
     id $idType,
     description $textType,
     name_product $textType,
     image_urls $textType,
     price INTEGER
    )''');
  }

  static Future<NetworkResponse> insertDebtors(ProductModel personModel) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      final db = await databaseInstance.database;

      await db.insert("Products", personModel.toJson());
    } catch (error) {
      networkResponse.errorText = error.toString();
    }

    return networkResponse;
  }

  static Future<NetworkResponse> getAllDebtors() async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      final db = await databaseInstance.database;
      String orderBy = "id DESC";
      List json = await db.query("Products", orderBy: orderBy);
      networkResponse.data = json.map((e) => ProductModel.fromJsonForSql(e));
    } catch (error) {
      networkResponse.errorText = error.toString();
    }

    return networkResponse;
  }

  static Future<NetworkResponse> deleteDebtors(int id) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      final db = await databaseInstance.database;
      await db.delete(
        "Products",
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (error) {
      networkResponse.errorText = error.toString();
    }
    return networkResponse;
  }
}
