import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:tvshow/data/models/tv_models.dart';
import 'package:movies/data/models/movies_data.dart';

class DatabaseHelper {
  Database? database;

  DatabaseHelper({this.database});

  static const String _tblWatchlist = 'watchlist';
  static const String _tblWatchlistTv = 'watchlistTv';

  Future<Database> initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: onCreate);
    return db;
  }

  void onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE $_tblWatchlistTv (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
      ''');
  }

  Future<int> insertWatchlist(MovieTable movie) async {
    final db = database;
    return await db!.insert(_tblWatchlist, movie.toMap());
  }

  Future<int> insertTvWatchlist(TvTable tv) async {
    final db = database;
    return await db!.insert(_tblWatchlistTv, {
      'id': tv.id,
      'name': tv.name,
      'posterPath': tv.posterPath,
      'overview': tv.overview,
    });
  }

  Future<int> removeWatchlist(MovieTable movie) async {
    final db = database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<int> removeTvWatchlist(TvTable tv) async {
    final db = database;
    return await db!.delete(
      _tblWatchlistTv,
      where: 'id = ?',
      whereArgs: [tv.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getTvById(int id) async {
    final db = database;
    final results = await db!.query(
      _tblWatchlistTv,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlist);

    return results;
  }

  Future<List<Map<String, dynamic>>> getWatchlistTv() async {
    final db = database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlistTv);

    return results;
  }
}
