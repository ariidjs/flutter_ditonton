import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../../dummy_data/tv/tv_dummy_object.dart';

void main() {
  late Database db;
  late DatabaseHelper dbHelper;

  setUpAll(() async {
    sqfliteFfiInit();
    db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    dbHelper = DatabaseHelper(database: db);

    dbHelper.database = db;
    dbHelper.onCreate(db, await db.getVersion());
  });

  group('CRUD testing', () {
    // group('watchlist movies', () {
    //   test('should return 1 when insert to database is success', () async {
    //     final result = await dbHelper.insertWatchlist(testMovieTable);
    //     expect(result, 1);
    //   });
    //   test('should return 1 when remove from database is success', () async {
    //     final result = await dbHelper.removeWatchlist(testMovieTable);
    //     expect(result, 1);
    //   });
    //   test('should return MovieTable when data is founded', () async {
    //     await dbHelper.removeWatchlist(testMovieTable);
    //     await dbHelper.insertWatchlist(testMovieTable);
    //     final result = await dbHelper.getMovieById(1);
    //     expect(result, testMovieTable.toMap());
    //   });
    //   test('should return list of MovieTable when data is founded', () async {
    //     await dbHelper.removeWatchlist(testMovieTable);
    //     await dbHelper.insertWatchlist(testMovieTable);
    //     final result = await dbHelper.getWatchlistMovies();
    //     expect(result, [testMovieTable.toMap()]);
    //   });
    // });

    group("watchlist tv show", () {
      test('should return 1 when insert to database is success', () async {
        final result = await dbHelper.insertTvWatchlist(testTvTable);
        expect(result, 1);
      });
      test('should return 1 when remove from database is success', () async {
        final result = await dbHelper.removeTvWatchlist(testTvTable);
        expect(result, 1);
      });
      test('should return TvShowTable when data is founded', () async {
        await dbHelper.removeTvWatchlist(testTvTable);
        await dbHelper.insertTvWatchlist(testTvTable);
        final result = await dbHelper.getTvById(1);
        expect(result, testTvTable.toMap());
      });
      test('should return list of TvShowTable when data is founded', () async {
        await dbHelper.removeTvWatchlist(testTvTable);
        await dbHelper.insertTvWatchlist(testTvTable);
        final result = await dbHelper.getWatchlistTv();
        expect(result, [testTvTable.toMap()]);
      });
    });
  });
}
