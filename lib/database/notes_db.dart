import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/model_constants.dart';
import '../model/notes_model.dart';

class NotesDatabase {
  //private named constructor
  NotesDatabase._init();
  //making global instance of NotesDatabase Class
  static final NotesDatabase instance = NotesDatabase._init();

  //database field
  Database? _database;

  //getter for database
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    //initializing db for first time in db is null
    _database = await _initDB(dbName);
    return _database!;
  }

  //database initialization passing dbName
  Future<Database> _initDB(String dbName) async {
    //getting dbPath, here we can get from path provider package also for specific path location
    final dbPath = await getDatabasesPath();
    //joining path with dbName
    final path = join(dbPath, dbName);
    //creating db with that path and version
    return openDatabase(
      path,
      version: kVersion1,
      onCreate: _createDB,
      // onUpgrade: we can upgrade if we change db schema
    );
  }

  //creating database
  Future _createDB(Database db, int version) async {
    //defining the different required data types
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    // sql query for creating db
    await db.execute('''
CREATE TABLE $TableNotes ( 
  $Id $idType, 
  $IsImportant $boolType,
  $IsFav $boolType,
  $Number $integerType,
  $Title $textType,
  $Description $textType,
  $Time $textType
  )
''');
    //  we can creating other multiple tables here with db.execute('');
  } //creating database

  //CRUD For Note Model
  Future<Note> create(Note note) async {
    final db = await instance.database;
    //RAW Query Method
    // final json = note.toJson();
    // final columns = '$Title, $Description, $Time';
    // final values = '${json[Title]}, ${json[Description]}, ${json[Time]}';
    // final id = await db.rawInsert('INSERT INTO $TableNotes ($columns) VALUES ($values)');

    final id = await db.insert(TableNotes, note.toJson());
    // print("Note created Id: $id");
    //assigning new created note id to id field of Note model and returning note model
    return note.copyWith(id: id);
  }

  //reading single note model with id
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

  //getting list of notes
  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;

    final orderBy = '$Time ASC';
    // final result = await db.rawQuery('SELECT * FROM $TableNotes ORDER BY $orderBy');
    final result = await db.query(TableNotes, orderBy: orderBy);
    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<List<Note>> readAllFavNotes() async {
    final db = await instance.database;

    final orderBy = '$Time ASC';
    // final result = await db.rawQuery('SELECT * FROM $TableNotes ORDER BY $orderBy');
    final result = await db.query(
      TableNotes,
      orderBy: orderBy,
      where: IsFav,
    );
    return result.map((json) => Note.fromJson(json)).toList();
  }

  //updating note with id
  Future<int> update(Note note) async {
    final db = await instance.database;

    return db.update(
      TableNotes,
      note.toJson(),
      where: '$Id = ?',
      whereArgs: [note.id],
    );
  }

  //deleting single note
  Future<int> delete(int id) async {
    final db = await instance.database;
    return db.delete(
      TableNotes,
      where: '$Id = ?',
      whereArgs: [id],
    );
  }

  //closing db
  Future close() async {
    final db = await instance.database;
    await db.close();
  }
}
