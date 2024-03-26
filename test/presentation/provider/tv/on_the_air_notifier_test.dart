import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv_show.dart';
import '../../../../core/lib/domain/usecases/tv/get_on_the_air_tv_shows.dart';
import '../../../../features/tvshow/lib/presentation/providers/on_the_air_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'on_the_air_notifier_test.mocks.dart';

@GenerateMocks([GetOnTheAirTvShows])
void main() {
  late MockGetOnTheAirTvShows mockGetOnTheAirTvShows;
  late OnTheAirTvNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnTheAirTvShows = MockGetOnTheAirTvShows();
    notifier = OnTheAirTvNotifier(mockGetOnTheAirTvShows)
      ..addListener(() {
        listenerCallCount++;
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

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetOnTheAirTvShows.execute())
        .thenAnswer((_) async => Right(tTvList));
    // act
    notifier.fetchOnTheAirTv();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetOnTheAirTvShows.execute())
        .thenAnswer((_) async => Right(tTvList));
    // act
    await notifier.fetchOnTheAirTv();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tv, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should change state to error when data is gotten unsuccessfully',
      () async {
    // arrange
    when(mockGetOnTheAirTvShows.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchOnTheAirTv();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
