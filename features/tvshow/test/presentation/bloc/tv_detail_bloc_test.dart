import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'tv_detail_bloc_test.mocks.dart';
import 'package:core/common/failure.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import '../../dummy_data/tv_dummy_object.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvshow/domain/usecases/usecases.dart';
import 'package:tvshow/presentation/bloc/tv_bloc.dart';

@GenerateMocks([GetTvShowDetail])
void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTvShowDetail mockGetTvDetail;

  setUp(() {
    mockGetTvDetail = MockGetTvShowDetail();
    tvDetailBloc = TvDetailBloc(mockGetTvDetail);
  });

  test('initial state should be empty', () {
    expect(tvDetailBloc.state, TvEmpty());
  });

  blocTest<TvDetailBloc, TvState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvDetail.execute(1))
          .thenAnswer((_) async => Right(testTvDetail));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(const TvDetails(1)),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvState>[
      TvLoading(),
      TvDetailSuccess(testTvDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(1));
    },
  );

  blocTest<TvDetailBloc, TvState>(
    'should emit [Loading, Error] when get tv detail is unsuccessful',
    build: () {
      when(mockGetTvDetail.execute(1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(const TvDetails(1)),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvState>[
      TvLoading(),
      const TvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(1));
    },
  );
}
