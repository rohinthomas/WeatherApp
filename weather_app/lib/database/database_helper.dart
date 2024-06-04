import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'weather.db');

    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE city(name TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertCity(String name) async {
    final db = await database;
    try {
      await db.insert(
        'city',
        {'name': name},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (error) {
      print('Error inserting city: $error');
    }
  }

  Future<List<Map<String, dynamic>>> getCities() async {
    final db = await database;
    try {
      return await db.query('city');
    } catch (error) {
      print('Error fetching cities: $error');
      return [];
    }
  }

  Future<void> updateCity(int id, String name) async {
    final db = await database;
    try {
      await db.update(
        'city',
        {'name': name},
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (error) {
      print('Error updating city: $error');
    }
  }

  Future<void> deleteCity(String city) async {
    final db = await database;
    try {
      await db.delete(
        'city',
        where: 'name = ?',
        whereArgs: [city],
      );
    } catch (error) {
      print('Error deleting city: $error');
    }
  }

  Future<void> close() async {
    final db = await database;
    try {
      await db.close();
    } catch (error) {
      print('Error closing database: $error');
    }
  }
}
