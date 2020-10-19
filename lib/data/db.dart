import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'models.dart';

class DBProvider {
  String databaseName = 'database.db';

  static final DBProvider _instance = DBProvider._internal();
  static DBProvider get instance => _instance;

  // factory DBProvider({String databaseName = 'database.db'}) {
  //   instance.databaseName = databaseName;
  //   return instance;
  // }

  DBProvider._internal();

  static Database _database;
  Future<Database> get database async => _database ??= await initDB();

  Future<Database> initDB() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    var path = join(documentsDirectory.path, databaseName);
    return await openDatabase(path, version: 1, onConfigure: _onConfigureHandler, onCreate: _onCreateHandler, onOpen: _onOpenHandler);
  }

  Future<void> _onConfigureHandler(Database db) async {
    if (kDebugMode) {
      await Sqflite.devSetDebugModeOn(true); // TODO: Implement logger
    }
    await db.execute("PRAGMA foreign_keys = ON");
  }

  Future<void> _onCreateHandler(Database db, int version) async {
    await _createTables(db);
  }

  Future<void> _onOpenHandler(Database db) async {
    if (kDebugMode) {
      await _insertData(db);
    }
  }

  Future<void> _createTables(Database db) async {
    developer.log('Create tables');
    await db.execute('''CREATE TABLE Questions (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      text TEXT,
      difficulty INTEGER,
      rating INTEGER,
      subject TEXT,
      image TEXT
    )''');

    await db.execute('''CREATE TABLE Options (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      questionId INTEGER NOT NULL,
      value TEXT,
      isCorrect BOOLEAN DEFAULT 0,
      FOREIGN KEY (questionId) REFERENCES Questions(id) ON DELETE CASCADE
    )''');
  }

  Future<void> _insertData(Database db) async {
    developer.log('Insert data');
    await db.insert('Questions', {'id': 1, 'text': 'Is this a question?', 'difficulty': 1, 'rating': 10, 'subject': 'Test', 'image': ''},
        conflictAlgorithm: ConflictAlgorithm.replace);
    await db.insert('Options', {'id': 1, 'questionId': 1, 'value': 'Yes', 'isCorrect': 1}, conflictAlgorithm: ConflictAlgorithm.replace);
    await db.insert('Options', {'id': 2, 'questionId': 1, 'value': 'No', 'isCorrect': 0}, conflictAlgorithm: ConflictAlgorithm.replace);

    await db.insert('Questions', {'id': 2, 'text': 'Another question in the quiz.', 'difficulty': 4, 'rating': 7, 'subject': 'Test', 'image': ''},
        conflictAlgorithm: ConflictAlgorithm.replace);
    await db.insert('Options', {'id': 4, 'questionId': 2, 'value': 'Yes', 'isCorrect': 0}, conflictAlgorithm: ConflictAlgorithm.replace);
    await db.insert('Options', {'id': 5, 'questionId': 2, 'value': 'No', 'isCorrect': 1}, conflictAlgorithm: ConflictAlgorithm.replace);
    await db.insert('Options', {'id': 3, 'questionId': 2, 'value': 'Maybe', 'isCorrect': 0}, conflictAlgorithm: ConflictAlgorithm.replace);

    await db.insert('Questions', {'id': 3, 'text': 'Test question?', 'difficulty': 10, 'rating': 1, 'subject': 'Test', 'image': ''}, conflictAlgorithm: ConflictAlgorithm.replace);
    await db.insert('Options', {'id': 6, 'questionId': 3, 'value': 'It is', 'isCorrect': 1}, conflictAlgorithm: ConflictAlgorithm.replace);
    await db.insert('Options', {'id': 7, 'questionId': 3, 'value': 'Maybe', 'isCorrect': 0}, conflictAlgorithm: ConflictAlgorithm.replace);
    await db.insert('Options', {'id': 8, 'questionId': 3, 'value': 'Always', 'isCorrect': 0}, conflictAlgorithm: ConflictAlgorithm.replace);
    await db.insert('Options', {'id': 9, 'questionId': 3, 'value': 'It isn\'t', 'isCorrect': 0}, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> close() async => database.then((db) => db.close());

  Future<List<Question>> getAllQuestions() async {
    final db = await database;
    var questionsQuery = await db.query("Questions");
    var result = questionsQuery.map((row) => Question.fromMap(row)).toList();
    for (var question in result) {
      var optionsQuery = await db.query('Options', where: 'questionId = ?', whereArgs: [question.id]);
      question.options = optionsQuery.map((row) => Option(value: row['value'], isCorrect: row['isCorrect'] == 1)).toList();
    }
    return result;
  }
  // Future<List<Product>> getAllProducts() async {
  //   final db = await database;
  //   List<Map> results = await db.query("Product", columns: Product.columns, orderBy: "id ASC");
  //   List<Product> products = new List();
  //   results.forEach((result) {
  //     Product product = Product.fromMap(result);
  //     products.add(product);
  //   });
  //   return products;
  // }

  // Future<dynamic> getProductById(int id) async {
  //   final db = await database;
  //   var result = await db.query("Product", where: "id = ", whereArgs: [id]);
  //   return result.isNotEmpty ? Product.fromMap(result.first) : Null;
  // }

  // Future<int> insert(Product product) async {
  //   final db = await database;
  //   var maxIdResult = await db.rawQuery("SELECT MAX(id)+1 as last_inserted_id FROM Product");
  //   var id = maxIdResult.first["last_inserted_id"];
  //   var result = await db.rawInsert(
  //       "INSERT Into Product (id, name, description, price, image)"
  //       " VALUES (?, ?, ?, ?, ?)",
  //       [id, product.name, product.description, product.price, product.image]);
  //   return result;
  // }

  // Future<int> update(Product product) async {
  //   final db = await database;
  //   var result = await db.update("Product", product.toMap(), where: "id = ?", whereArgs: [product.id]);
  //   return result;
  // }

  // Future<int> delete(int id) async {
  //   final db = await database;
  //   var result = db.delete("Product", where: "id = ?", whereArgs: [id]);
  //   return result;
  // }

}
