import 'package:core/common/exception.dart';

import '../db/database_helper.dart';
import '../../models/tv/tv_table.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlist(TvTable tvShow);
  Future<String> removeWatchlist(TvTable tvShow);
  Future<TvTable?> getTvById(int id);
  Future<List<TvTable>> getWatchlistTv();
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
  Future<TvTable?> getTvById(int id) async {
    final result = await databaseHelper.getTvById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchlistTv() async {
    final result = await databaseHelper.getWatchlistTv();
    return result.map((data) => TvTable.fromMap(data)).toList();
  }
}
