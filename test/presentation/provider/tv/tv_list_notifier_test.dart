import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv_show.dart';
import 'package:ditonton/domain/usecases/tv/get_on_the_air_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tv_shows.dart';
import 'package:ditonton/presentation/provider/tv/tv_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetOnTheAirTvShows,
  GetPopularTvShows,
  GetTopRatedTvShows,
])
void main() {
  late TvListNotifier provider;
  late MockGetOnTheAirTvShows mockGetNowPlayingTv;
  late MockGetPopularTvShows mockGetPopularTv;
  late MockGetTopRatedTvShows mockGetTopRatedTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTv = MockGetOnTheAirTvShows();
    mockGetPopularTv = MockGetPopularTvShows();
    mockGetTopRatedTv = MockGetTopRatedTvShows();
    provider = TvListNotifier(
      getOnTheAirTvShows: mockGetNowPlayingTv,
      getPopularTvShows: mockGetPopularTv,
      getTopRatedTvShows: mockGetTopRatedTv,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTv = TvShow(
    backdropPath: 'backdropPath',
    firstAirDate: DateTime.parse('2024-03-20'),
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvList = <TvShow>[tTv];

  group('now playing tv', () {
    test("initialState should be empty", () {
      expect(provider.onTheAirTvState, equals(RequestState.Empty));
    });

    test("should get data from the usecase", () async {
      // arrange
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchOnTheAirTvShows();
      // assert
      verify(mockGetNowPlayingTv.execute());
    });

    test("should change state to Loading when usecase is called", () async {
      // arrange
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchOnTheAirTvShows();
      // assert
      expect(provider.onTheAirTvState, RequestState.Loading);
    });

    test("should change tv when data is gotten successfully", () async {
      // arrange
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchOnTheAirTvShows();
      // assert
      expect(provider.onTheAirTvState, RequestState.Loaded);
      expect(provider.onTheAirTvShows, tTvList);
      expect(listenerCallCount, 2);
    });
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOnTheAirTvShows();
      // assert
      expect(provider.onTheAirTvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tv', () {
    test("should change state to Loading when usecase is called", () async {
      // arrange
      when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchPopularTvShows();
      // assert
      expect(provider.popularTvState, RequestState.Loading);
    });

    test("should change tv when data is gotten successfully", () async {
      // arrange
      when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchPopularTvShows();
      // assert
      expect(provider.popularTvState, RequestState.Loaded);
      expect(provider.popularTvShows, tTvList);
      expect(listenerCallCount, 2);
    });
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTvShows();
      // assert
      expect(provider.popularTvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tv', () {
    test("should change state to Loading when usecase is called", () async {
      // arrange
      when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchTopRatedTvShows();
      // assert
      expect(provider.topRatedState, RequestState.Loading);
    });

    test("should change tv when data is gotten successfully", () async {
      // arrange
      when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchTopRatedTvShows();
      // assert
      expect(provider.topRatedState, RequestState.Loaded);
      expect(provider.topRatedTvShows, tTvList);
      expect(listenerCallCount, 2);
    });
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTvShows();
      // assert
      expect(provider.topRatedState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
