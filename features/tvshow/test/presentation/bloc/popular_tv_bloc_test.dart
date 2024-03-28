import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'popular_tv_bloc_test.mocks.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:mockito/annotations.dart';
import '../../dummy_data/tv_dummy_object.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvshow/domain/usecases/usecases.dart';
import 'package:tvshow/presentation/bloc/tv_bloc.dart';




@GenerateMocks([GetPopularTvShows])
void main() {
  late PopularTvBloc popularTvBloc;
  late MockGetPopularTvShows mockGetPopularTv;

  setUp(() {
    mockGetPopularTv = MockGetPopularTvShows();
    popularTvBloc = PopularTvBloc(mockGetPopularTv);
  });

  test('initial state should be empty', () {
    expect(popularTvBloc.state, TvEmpty());
  });

  blocTest<PopularTvBloc, TvState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(PopularTv()),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvState>[
      TvLoading(),
      TvSuccess(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTv.execute());
    },
  );

  blocTest<PopularTvBloc, TvState>(
    'should emit [Loading, Error] when data is gotten unsuccessfully',
    build: () {
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(PopularTv()),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvState>[
      TvLoading(),
      const TvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTv.execute());
    },
  );
}
