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
    const textType = "TEXT NOT NULL";

    await db.execute('''CREATE TABLE Products (
     doc_id $String,
     description $textType,
     name_product $textType,
     image_urls $textType,
     price INTEGER
    )''');

    await db.execute('''CREATE TABLE Basket (
     doc_id $String,
     description $textType,
     name_product $textType,
     image_urls $textType,
     price INTEGER,
     count INTEGER
    )''');
  }

  ///Products Table----------------------------------------------------

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
      String orderBy = "doc_id DESC";
      List json = await db.query("Products", orderBy: orderBy);
      networkResponse.data =
          json.map((e) => ProductModel.fromJsonForSql(e)).toList();
    } catch (error) {
      networkResponse.errorText = error.toString();
    }

    return networkResponse;
  }

  static Future<NetworkResponse> deleteDebtors(String docId) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      final db = await databaseInstance.database;
      await db.delete(
        "Products",
        where: "doc_id = ?",
        whereArgs: [docId],
      );
    } catch (error) {
      networkResponse.errorText = error.toString();
    }
    return networkResponse;
  }

  ///Basket Table----------------------------------------------------

  static Future<NetworkResponse> insertToBasketProdeuct(
      ProductModel personModel) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      final db = await databaseInstance.database;

      await db.insert("Basket", personModel.toJson());
    } catch (error) {
      networkResponse.errorText = error.toString();
    }

    return networkResponse;
  }

  static Future<NetworkResponse> getAllBasketProducts() async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      final db = await databaseInstance.database;
      String orderBy = "doc_id DESC";
      List json = await db.query("Basket", orderBy: orderBy);
      networkResponse.data =
          json.map((e) => ProductModel.fromJsonForSql(e)).toList();
    } catch (error) {
      networkResponse.errorText = error.toString();
    }

    return networkResponse;
  }

  static Future<NetworkResponse> deleteProductToBasket(String docId) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      final db = await databaseInstance.database;
      await db.delete(
        "Basket",
        where: "doc_id = ?",
        whereArgs: [docId],
      );
    } catch (error) {
      networkResponse.errorText = error.toString();
    }
    return networkResponse;
  }

  static updateBasketProduct({required ProductModel productModel}) async {
    final db = await databaseInstance.database;
    // debugPrint(noteModel.id.toString());

    await db.update("Basket", productModel.toJsonForBasket(),
        where: "doc_id = ?", whereArgs: [productModel.docId]);
  }
}
