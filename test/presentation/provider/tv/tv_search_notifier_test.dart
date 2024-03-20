import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv_show.dart';
import 'package:ditonton/domain/usecases/tv/search_tv_shows.dart';
import 'package:ditonton/presentation/provider/tv/tv_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvShows])
void main() {
  late MockSearchTvShows mockSearchTv;
  late TvSearchNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTv = MockSearchTvShows();
    notifier = TvSearchNotifier(searchTvShows: mockSearchTv)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTvModel = TvShow(
    backdropPath: '/5DUMPBSnHOZsbBv81GFXZXvDpo6.jpg',
    firstAirDate: DateTime.parse('2024-03-20'),
    genreIds: [16, 10759, 10765, 35],
    id: 114410,
    name: 'Chainsaw Man',
    originCountry: ['JP'],
    originalLanguage: 'ja',
    originalName: 'チェンソーマン',
    overview:
        'Denji has a simple dream—to live a happy and peaceful life, spending time with a girl he likes. This is a far cry from reality, however, as Denji is forced by the yakuza into killing devils in order to pay off his crushing debts. Using his pet devil Pochita as a weapon, he is ready to do anything for a bit of cash.',
    popularity: 1004.662,
    posterPath: '/npdB6eFzizki0WaZ1OvKcJrWe97.jpg',
    voteAverage: 8.6,
    voteCount: 340,
  );
  final tTvList = <TvShow>[tTvModel];
  final tQuery = 'chainsaw man';

  group('search tv', () {
    test(
      "should change state to loading when usecase is called",
      () async {
        // arrange
        when(mockSearchTv.execute(tQuery))
            .thenAnswer((_) async => Right(tTvList));
        // act
        notifier.fetchTvSearch(tQuery);
        // assert
        expect(notifier.state, RequestState.Loading);
      },
    );
  });

  test("should change search result data when data is gotten successfully",
      () async {
    // arrange
    when(mockSearchTv.execute(tQuery)).thenAnswer((_) async => Right(tTvList));
    // act
    await notifier.fetchTvSearch(tQuery);
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.searchResult, tTvList);
    expect(listenerCallCount, 2);
  });

  test("should change state to error when data is gotten unsuccessfully",
      () async {
    // arrange
    when(mockSearchTv.execute(tQuery))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTvSearch(tQuery);
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
