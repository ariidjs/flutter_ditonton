// Mocks generated by Mockito 5.4.4 from annotations
// in ditonton/test/helpers/tv_test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;
import 'dart:convert' as _i20;
import 'dart:typed_data' as _i21;

import 'package:core/common/failure.dart' as _i9;
import 'package:core/data/datasources/db/database_helper.dart' as _i18;
import 'package:core/data/datasources/tv/tv_local_data_source.dart' as _i15;
import 'package:core/data/datasources/tv/tv_remote_data_source.dart' as _i13;
import 'package:core/data/models/movies/movie_table.dart' as _i19;
import 'package:core/data/models/tv/season/season_detail.dart' as _i4;
import 'package:core/data/models/tv/tv_detail_model.dart' as _i3;
import 'package:core/data/models/tv/tv_model.dart' as _i14;
import 'package:core/data/models/tv/tv_table.dart' as _i16;
import 'package:dartz/dartz.dart' as _i2;
import 'package:http/http.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i17;
import 'package:sqflite/sqflite.dart' as _i5;
import 'package:tvshow/domain/entities/season_detail.dart' as _i12;
import 'package:tvshow/domain/entities/tv_detail.dart' as _i11;
import 'package:tvshow/domain/entities/tv_show.dart' as _i10;
import 'package:tvshow/domain/repositories/tv_repository.dart' as _i7;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTvDetailResponse_1 extends _i1.SmartFake
    implements _i3.TvDetailResponse {
  _FakeTvDetailResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSeasonDetailResponse_2 extends _i1.SmartFake
    implements _i4.SeasonDetailResponse {
  _FakeSeasonDetailResponse_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDatabase_3 extends _i1.SmartFake implements _i5.Database {
  _FakeDatabase_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_4 extends _i1.SmartFake implements _i6.Response {
  _FakeResponse_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStreamedResponse_5 extends _i1.SmartFake
    implements _i6.StreamedResponse {
  _FakeStreamedResponse_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TvRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvRepository extends _i1.Mock implements _i7.TvRepository {
  MockTvRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.TvShow>>> getOnTheAirTvShows() =>
      (super.noSuchMethod(
        Invocation.method(
          #getOnTheAirTvShows,
          [],
        ),
        returnValue:
            _i8.Future<_i2.Either<_i9.Failure, List<_i10.TvShow>>>.value(
                _FakeEither_0<_i9.Failure, List<_i10.TvShow>>(
          this,
          Invocation.method(
            #getOnTheAirTvShows,
            [],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, List<_i10.TvShow>>>);

  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.TvShow>>> getPopularTvShows() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopularTvShows,
          [],
        ),
        returnValue:
            _i8.Future<_i2.Either<_i9.Failure, List<_i10.TvShow>>>.value(
                _FakeEither_0<_i9.Failure, List<_i10.TvShow>>(
          this,
          Invocation.method(
            #getPopularTvShows,
            [],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, List<_i10.TvShow>>>);

  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.TvShow>>> getTopRatedTvShows() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRatedTvShows,
          [],
        ),
        returnValue:
            _i8.Future<_i2.Either<_i9.Failure, List<_i10.TvShow>>>.value(
                _FakeEither_0<_i9.Failure, List<_i10.TvShow>>(
          this,
          Invocation.method(
            #getTopRatedTvShows,
            [],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, List<_i10.TvShow>>>);

  @override
  _i8.Future<_i2.Either<_i9.Failure, _i11.TvDetail>> getTvShowDetail(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvShowDetail,
          [id],
        ),
        returnValue: _i8.Future<_i2.Either<_i9.Failure, _i11.TvDetail>>.value(
            _FakeEither_0<_i9.Failure, _i11.TvDetail>(
          this,
          Invocation.method(
            #getTvShowDetail,
            [id],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, _i11.TvDetail>>);

  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.TvShow>>>
      getTvShowRecommendations(int? id) => (super.noSuchMethod(
            Invocation.method(
              #getTvShowRecommendations,
              [id],
            ),
            returnValue:
                _i8.Future<_i2.Either<_i9.Failure, List<_i10.TvShow>>>.value(
                    _FakeEither_0<_i9.Failure, List<_i10.TvShow>>(
              this,
              Invocation.method(
                #getTvShowRecommendations,
                [id],
              ),
            )),
          ) as _i8.Future<_i2.Either<_i9.Failure, List<_i10.TvShow>>>);

  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.TvShow>>> searchTvShows(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchTvShows,
          [query],
        ),
        returnValue:
            _i8.Future<_i2.Either<_i9.Failure, List<_i10.TvShow>>>.value(
                _FakeEither_0<_i9.Failure, List<_i10.TvShow>>(
          this,
          Invocation.method(
            #searchTvShows,
            [query],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, List<_i10.TvShow>>>);

  @override
  _i8.Future<_i2.Either<_i9.Failure, String>> saveWatchlistTv(
          _i11.TvDetail? tv) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveWatchlistTv,
          [tv],
        ),
        returnValue: _i8.Future<_i2.Either<_i9.Failure, String>>.value(
            _FakeEither_0<_i9.Failure, String>(
          this,
          Invocation.method(
            #saveWatchlistTv,
            [tv],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, String>>);

  @override
  _i8.Future<_i2.Either<_i9.Failure, String>> removeWatchlistTv(
          _i11.TvDetail? tv) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlistTv,
          [tv],
        ),
        returnValue: _i8.Future<_i2.Either<_i9.Failure, String>>.value(
            _FakeEither_0<_i9.Failure, String>(
          this,
          Invocation.method(
            #removeWatchlistTv,
            [tv],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, String>>);

  @override
  _i8.Future<bool> isAddedToWatchlistTv(int? id) => (super.noSuchMethod(
        Invocation.method(
          #isAddedToWatchlistTv,
          [id],
        ),
        returnValue: _i8.Future<bool>.value(false),
      ) as _i8.Future<bool>);

  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.TvShow>>>
      getWatchlistTvShows() => (super.noSuchMethod(
            Invocation.method(
              #getWatchlistTvShows,
              [],
            ),
            returnValue:
                _i8.Future<_i2.Either<_i9.Failure, List<_i10.TvShow>>>.value(
                    _FakeEither_0<_i9.Failure, List<_i10.TvShow>>(
              this,
              Invocation.method(
                #getWatchlistTvShows,
                [],
              ),
            )),
          ) as _i8.Future<_i2.Either<_i9.Failure, List<_i10.TvShow>>>);

  @override
  _i8.Future<_i2.Either<_i9.Failure, _i12.SeasonDetail>> getSeasonDetail(
    int? tvId,
    int? seasonNumber,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSeasonDetail,
          [
            tvId,
            seasonNumber,
          ],
        ),
        returnValue:
            _i8.Future<_i2.Either<_i9.Failure, _i12.SeasonDetail>>.value(
                _FakeEither_0<_i9.Failure, _i12.SeasonDetail>(
          this,
          Invocation.method(
            #getSeasonDetail,
            [
              tvId,
              seasonNumber,
            ],
          ),
        )),
      ) as _i8.Future<_i2.Either<_i9.Failure, _i12.SeasonDetail>>);
}

/// A class which mocks [TvRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvRemoteDataSource extends _i1.Mock
    implements _i13.TvRemoteDataSource {
  MockTvRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<List<_i14.TvModel>> getNowPlayingTv() => (super.noSuchMethod(
        Invocation.method(
          #getNowPlayingTv,
          [],
        ),
        returnValue: _i8.Future<List<_i14.TvModel>>.value(<_i14.TvModel>[]),
      ) as _i8.Future<List<_i14.TvModel>>);

  @override
  _i8.Future<List<_i14.TvModel>> getPopularTv() => (super.noSuchMethod(
        Invocation.method(
          #getPopularTv,
          [],
        ),
        returnValue: _i8.Future<List<_i14.TvModel>>.value(<_i14.TvModel>[]),
      ) as _i8.Future<List<_i14.TvModel>>);

  @override
  _i8.Future<List<_i14.TvModel>> getTopRatedTv() => (super.noSuchMethod(
        Invocation.method(
          #getTopRatedTv,
          [],
        ),
        returnValue: _i8.Future<List<_i14.TvModel>>.value(<_i14.TvModel>[]),
      ) as _i8.Future<List<_i14.TvModel>>);

  @override
  _i8.Future<_i3.TvDetailResponse> getTvDetail(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getTvDetail,
          [id],
        ),
        returnValue:
            _i8.Future<_i3.TvDetailResponse>.value(_FakeTvDetailResponse_1(
          this,
          Invocation.method(
            #getTvDetail,
            [id],
          ),
        )),
      ) as _i8.Future<_i3.TvDetailResponse>);

  @override
  _i8.Future<List<_i14.TvModel>> getTvRecommendations(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvRecommendations,
          [id],
        ),
        returnValue: _i8.Future<List<_i14.TvModel>>.value(<_i14.TvModel>[]),
      ) as _i8.Future<List<_i14.TvModel>>);

  @override
  _i8.Future<List<_i14.TvModel>> searchTv(String? query) => (super.noSuchMethod(
        Invocation.method(
          #searchTv,
          [query],
        ),
        returnValue: _i8.Future<List<_i14.TvModel>>.value(<_i14.TvModel>[]),
      ) as _i8.Future<List<_i14.TvModel>>);

  @override
  _i8.Future<_i4.SeasonDetailResponse> getSeasonDetail(
    int? tvId,
    int? seasonNumber,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSeasonDetail,
          [
            tvId,
            seasonNumber,
          ],
        ),
        returnValue: _i8.Future<_i4.SeasonDetailResponse>.value(
            _FakeSeasonDetailResponse_2(
          this,
          Invocation.method(
            #getSeasonDetail,
            [
              tvId,
              seasonNumber,
            ],
          ),
        )),
      ) as _i8.Future<_i4.SeasonDetailResponse>);
}

/// A class which mocks [TvLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvLocalDataSource extends _i1.Mock implements _i15.TvLocalDataSource {
  MockTvLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<String> insertWatchlist(_i16.TvTable? tvShow) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [tvShow],
        ),
        returnValue: _i8.Future<String>.value(_i17.dummyValue<String>(
          this,
          Invocation.method(
            #insertWatchlist,
            [tvShow],
          ),
        )),
      ) as _i8.Future<String>);

  @override
  _i8.Future<String> removeWatchlist(_i16.TvTable? tvShow) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [tvShow],
        ),
        returnValue: _i8.Future<String>.value(_i17.dummyValue<String>(
          this,
          Invocation.method(
            #removeWatchlist,
            [tvShow],
          ),
        )),
      ) as _i8.Future<String>);

  @override
  _i8.Future<_i16.TvTable?> getTvById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getTvById,
          [id],
        ),
        returnValue: _i8.Future<_i16.TvTable?>.value(),
      ) as _i8.Future<_i16.TvTable?>);

  @override
  _i8.Future<List<_i16.TvTable>> getWatchlistTv() => (super.noSuchMethod(
        Invocation.method(
          #getWatchlistTv,
          [],
        ),
        returnValue: _i8.Future<List<_i16.TvTable>>.value(<_i16.TvTable>[]),
      ) as _i8.Future<List<_i16.TvTable>>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i18.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set database(_i5.Database? _database) => super.noSuchMethod(
        Invocation.setter(
          #database,
          _database,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i8.Future<_i5.Database> initDb() => (super.noSuchMethod(
        Invocation.method(
          #initDb,
          [],
        ),
        returnValue: _i8.Future<_i5.Database>.value(_FakeDatabase_3(
          this,
          Invocation.method(
            #initDb,
            [],
          ),
        )),
      ) as _i8.Future<_i5.Database>);

  @override
  void onCreate(
    _i5.Database? db,
    int? version,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onCreate,
          [
            db,
            version,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i8.Future<int> insertWatchlist(_i19.MovieTable? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [movie],
        ),
        returnValue: _i8.Future<int>.value(0),
      ) as _i8.Future<int>);

  @override
  _i8.Future<int> insertTvWatchlist(_i16.TvTable? tv) => (super.noSuchMethod(
        Invocation.method(
          #insertTvWatchlist,
          [tv],
        ),
        returnValue: _i8.Future<int>.value(0),
      ) as _i8.Future<int>);

  @override
  _i8.Future<int> removeWatchlist(_i19.MovieTable? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [movie],
        ),
        returnValue: _i8.Future<int>.value(0),
      ) as _i8.Future<int>);

  @override
  _i8.Future<int> removeTvWatchlist(_i16.TvTable? tv) => (super.noSuchMethod(
        Invocation.method(
          #removeTvWatchlist,
          [tv],
        ),
        returnValue: _i8.Future<int>.value(0),
      ) as _i8.Future<int>);

  @override
  _i8.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieById,
          [id],
        ),
        returnValue: _i8.Future<Map<String, dynamic>?>.value(),
      ) as _i8.Future<Map<String, dynamic>?>);

  @override
  _i8.Future<Map<String, dynamic>?> getTvById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getTvById,
          [id],
        ),
        returnValue: _i8.Future<Map<String, dynamic>?>.value(),
      ) as _i8.Future<Map<String, dynamic>?>);

  @override
  _i8.Future<List<Map<String, dynamic>>> getWatchlistMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistMovies,
          [],
        ),
        returnValue: _i8.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i8.Future<List<Map<String, dynamic>>>);

  @override
  _i8.Future<List<Map<String, dynamic>>> getWatchlistTv() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistTv,
          [],
        ),
        returnValue: _i8.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i8.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i6.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i6.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i8.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i8.Future<_i6.Response>);

  @override
  _i8.Future<_i6.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i8.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i8.Future<_i6.Response>);

  @override
  _i8.Future<_i6.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i20.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i8.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i8.Future<_i6.Response>);

  @override
  _i8.Future<_i6.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i20.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i8.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i8.Future<_i6.Response>);

  @override
  _i8.Future<_i6.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i20.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i8.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i8.Future<_i6.Response>);

  @override
  _i8.Future<_i6.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i20.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i8.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i8.Future<_i6.Response>);

  @override
  _i8.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i8.Future<String>.value(_i17.dummyValue<String>(
          this,
          Invocation.method(
            #read,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i8.Future<String>);

  @override
  _i8.Future<_i21.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i8.Future<_i21.Uint8List>.value(_i21.Uint8List(0)),
      ) as _i8.Future<_i21.Uint8List>);

  @override
  _i8.Future<_i6.StreamedResponse> send(_i6.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i8.Future<_i6.StreamedResponse>.value(_FakeStreamedResponse_5(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i8.Future<_i6.StreamedResponse>);

  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
