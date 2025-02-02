import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/dog.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('dogs.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE dogs(
        id INTEGER PRIMARY KEY,
        name TEXT,
        image TEXT,
        breed_group TEXT,
        description TEXT
      )
    ''');
  }

  Future<void> insertDog(Dog dog) async {
    final db = await instance.database;
    await db.insert('dogs', dog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Dog>> getSavedDogs() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('dogs');

    return List.generate(maps.length, (i) {
      return Dog.fromJson(maps[i]);
    });
  }

  Future<void> deleteDog(int id) async {
    final db = await instance.database;
    await db.delete('dogs', where: 'id = ?', whereArgs: [id]);
  }
}
