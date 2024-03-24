import 'package:ditonton/data/datasources/db/db_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../dummy_data/movies/dummy_objects.dart';
import 'database_helper_test.mocks.dart';

@GenerateMocks([DatabaseHelper])
void main() {
  late Database database;
  late MockDatabaseHelper dbHelper;
  setUpAll(() async {
    sqfliteFfiInit();
    // database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await dbHelper.initDb();
    dbHelper = MockDatabaseHelper();
    // dbHelper.database =
  });

  test("create task", () async {
    verifyNever(dbHelper.insertWatchlist(testMovieTable));
    expect(await dbHelper.insertWatchlist(testMovieTable), 1);
    verify(dbHelper.insertWatchlist(testMovieTable)).called(1);
  });
}
