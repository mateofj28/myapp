import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Database? _db;

  Future<Database?> get db async {
    _db ??= await _initDatabase();
    return _db;
  }

  DatabaseHelper._internal();

  Future<Database> _initDatabase() async {
    final dbPath = join(await getDatabasesPath(), 'shopify.db');
    
    sqfliteFfiInit();

    final db = await openDatabase(dbPath, onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE sales (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, client TEXT, paymentMethod TEXT, date Text)');
    }, version: 1);
    return db;
  }

}
