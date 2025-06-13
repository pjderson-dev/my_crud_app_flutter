import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/note.dart';

final String databaseName = "notes.db";

final String tableName = "notes";

class NoteFields {
  static final String id = '_id';
  static final String title = 'title';
  static final String content = 'content';

  static final List<String> values = [id, title, content];
}

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper _instance = DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseName);

    print("Chemin de la base de donnees: $path");

    return await openDatabase(
      path,
      version: 1,

      onCreate: _onCreate,
      //onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName(
        ${NoteFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${NoteFields.title} TEXT NOT NULL,
        ${NoteFields.content} TEXT NOT NULL
      )
      ''');
    print("Table '$tableName' creee avec succes!");
  }

  Future<int> create(Note note) async {
    final db = await database;
    final id = await db.insert(
      tableName,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    print("Note inseree avec l'ID: $id");
    return id;
  }

  Future close() async {
    final db = await _instance.database;
    db.close();
    _database = null;
    print("Base de donnees fermee avec succes!");
  }
}
