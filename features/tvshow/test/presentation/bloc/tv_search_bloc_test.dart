import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'tv_search_bloc_test.mocks.dart';
import 'package:core/common/failure.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import '../../dummy_data/tv_dummy_object.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvshow/domain/usecases/usecases.dart';
import 'package:tvshow/presentation/bloc/tv_bloc.dart';

@GenerateMocks([SearchTvShows])
void main() {
  late SearchTvBloc searchTvBloc;
  late MockSearchTvShows mockSearchTvShows;

  setUp(() {
    mockSearchTvShows = MockSearchTvShows();
    searchTvBloc = SearchTvBloc(mockSearchTvShows);
  });

  test('initial state should be empty', () {
    expect(searchTvBloc.state, TvEmpty());
  });

  blocTest<SearchTvBloc, TvState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTvShows.execute('search tv'))
          .thenAnswer((_) async => Right(testTvList));
      return searchTvBloc;
    },
    act: (bloc) => bloc.add(SearchTvQuery('search tv')),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvState>[
      TvLoading(),
      TvSuccess(testTvList),
    ],
    verify: (bloc) {
      verify(mockSearchTvShows.execute('search tv'));
    },
  );

  blocTest<SearchTvBloc, TvState>(
    'should emit [Loading, Error] when data is gotten unsuccessfully',
    build: () {
      when(mockSearchTvShows.execute('search tv'))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchTvBloc;
    },
    act: (bloc) => bloc.add(SearchTvQuery('search tv')),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvState>[
      TvLoading(),
      const TvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvShows.execute('search tv'));
    },
  );
}
