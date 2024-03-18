import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_table.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlist(TvTable tvShow);
  Future<String> removeWatchlist(TvTable tvShow);
  Future<MovieTable?> getTvById(int id);
  Future<List<MovieTable>> getWatchlistTv();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(TvTable tvShow) async {
    try {
      await databaseHelper.insertTvWatchlist(tvShow);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvTable tvShow) async {
    try {
      await databaseHelper.removeTvWatchlist(tvShow);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieTable?> getTvById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return MovieTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTable>> getWatchlistTv() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => MovieTable.fromMap(data)).toList();
  }
}
