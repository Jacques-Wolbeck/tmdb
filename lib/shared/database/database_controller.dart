import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tmdb/shared/models/movie_model.dart';

class DatabaseController {
  static final DatabaseController db = DatabaseController._init(); //singleton

  DatabaseController._init();

  Future<Database> get database async {
    return await initDB();
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'movies_sqflite.db');

    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE movies (id INTEGER PRIMARY KEY, original_title TEXT, description TEXT, status TEXT, creationDate TEXT)');
      },
      version: 1,
    );
  }

  Future<void> insertTodo(MovieModel movie) async {
    final db = await database;
    await db.insert(
      'movies',
      movie.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteTodo(MovieModel movie) async {
    final db = await database;
    await db.delete(
      'movies',
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<List<MovieModel>> getAllTodos() async {
    final db = await database;
    var response = await db.query('movies');
    return response.isEmpty
        ? []
        : response.map((json) => MovieModel.fromJson(json)).toList();
  }
}
