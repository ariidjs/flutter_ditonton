import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:core/common/failure.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import '../../dummy_data/tv_dummy_object.dart';
import 'tv_season_detail_bloc_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvshow/domain/usecases/usecases.dart';
import 'package:tvshow/presentation/bloc/tv_bloc.dart';

@GenerateMocks([GetTvSeasonDetail])
void main() {
  late TvSeasonDetailBloc tvSeasonDetailBloc;
  late MockGetTvSeasonDetail mockGetTvSeasonDetail;

  setUp(() {
    mockGetTvSeasonDetail = MockGetTvSeasonDetail();
    tvSeasonDetailBloc = TvSeasonDetailBloc(mockGetTvSeasonDetail);
  });

  test('initial state should be empty', () {
    expect(tvSeasonDetailBloc.state, TvEmpty());
  });

  blocTest<TvSeasonDetailBloc, TvState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvSeasonDetail.execute(1, 2))
          .thenAnswer((_) async => Right(testTvSeasonDetail));
      return tvSeasonDetailBloc;
    },
    act: (bloc) => bloc.add(const TvSeasonDetail(1, 2)),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvState>[
      TvLoading(),
      TvSeasonDetailSuccess(testTvSeasonDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvSeasonDetail.execute(1, 2));
    },
  );

  blocTest<TvSeasonDetailBloc, TvState>(
    'should emit [Loading, Error] when get season tv detail is unsuccessful',
    build: () {
      when(mockGetTvSeasonDetail.execute(1, 2))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeasonDetailBloc;
    },
    act: (bloc) => bloc.add(const TvSeasonDetail(1, 2)),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvState>[
      TvLoading(),
      const TvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvSeasonDetail.execute(1, 2));
    },
  );
}
