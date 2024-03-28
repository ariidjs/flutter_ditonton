import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:core/common/failure.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import '../../dummy_data/tv_dummy_object.dart';
import 'package:flutter_test/flutter_test.dart';
import 'tv_recommendation_bloc_test.mocks.dart';
import 'package:tvshow/domain/usecases/usecases.dart';
import 'package:tvshow/presentation/bloc/tv_bloc.dart';

@GenerateMocks([GetTvShowRecommendations])
void main() {
  late TvRecommendationBloc recommendationTvBloc;
  late MockGetTvShowRecommendations mockGetTvShowRecommendations;

  setUp(() {
    mockGetTvShowRecommendations = MockGetTvShowRecommendations();
    recommendationTvBloc = TvRecommendationBloc(mockGetTvShowRecommendations);
  });

  test('initial state should be empty', () {
    expect(recommendationTvBloc.state, TvEmpty());
  });

  blocTest<TvRecommendationBloc, TvState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvShowRecommendations.execute(1))
          .thenAnswer((_) async => Right(testTvList));
      return recommendationTvBloc;
    },
    act: (bloc) => bloc.add(TvRecommendations(1)),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvState>[
      TvLoading(),
      TvSuccess(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetTvShowRecommendations.execute(1));
    },
  );

  blocTest<TvRecommendationBloc, TvState>(
    'should emit [Loading, Error] when data is gotten unsuccessfully',
    build: () {
      when(mockGetTvShowRecommendations.execute(1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return recommendationTvBloc;
    },
    act: (bloc) => bloc.add(TvRecommendations(1)),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvState>[
      TvLoading(),
      const TvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvShowRecommendations.execute(1));
    },
  );
}
