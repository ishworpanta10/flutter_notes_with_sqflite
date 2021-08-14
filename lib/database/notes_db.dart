import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/model_constants.dart';
import '../model/notes_model.dart';

class NotesDatabase {
  NotesDatabase._init();

  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB(dbName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return openDatabase(path, version: kVersion1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $TableNotes ( 
  $Id $idType, 
  $IsImportant $boolType,
  $Number $integerType,
  $Title $textType,
  $Description $textType,
  $Time $textType
  )
''');
  }

  Future<Note> create(Note note) async {
    final db = await instance.database;
    // final json = note.toJson();
    // final columns = '$Title, $Description, $Time';
    // final values = '${json[Title]}, ${json[Description]}, ${json[Time]}';
    // final id = await db.rawInsert('INSERT INTO $TableNotes ($columns) VALUES ($values)');

    final id = await db.insert(TableNotes, note.toJson());
    return note.copyWith(id: id);
  }

  Future<Note> readNote(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      TableNotes,
      columns: colValues,
      where: '$Id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;

    final orderBy = '$Time ASC';
    // final result = await db.rawQuery('SELECT * FROM $TableNotes ORDER BY $orderBy');
    final result = await db.query(TableNotes, orderBy: orderBy);
    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<int> update(Note note) async {
    final db = await instance.database;

    return db.update(
      TableNotes,
      note.toJson(),
      where: '$Id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return db.delete(
      TableNotes,
      where: '$Id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    await db.close();
  }
}
