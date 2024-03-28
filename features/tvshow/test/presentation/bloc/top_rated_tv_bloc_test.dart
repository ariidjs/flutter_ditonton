import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:mockito/annotations.dart';
import 'top_rated_tv_bloc_test.mocks.dart';
import '../../dummy_data/tv_dummy_object.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvshow/presentation/bloc/tv_bloc.dart';
import 'package:tvshow/domain/usecases/get_top_rated_tv_shows.dart';



@GenerateMocks([GetTopRatedTvShows])
void main() {
  late TopRatedTvBloc topRatedTvBloc;
  late MockGetTopRatedTvShows mockGetTopRatedTv;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTvShows();
    topRatedTvBloc = TopRatedTvBloc(mockGetTopRatedTv);
  });

  test('initial state should be empty', () {
    expect(topRatedTvBloc.state, TvEmpty());
  });

  blocTest<TopRatedTvBloc, TvState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(TopRatedTv()),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvState>[
      TvLoading(),
      TvSuccess(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTv.execute());
    },
  );

  blocTest<TopRatedTvBloc, TvState>(
    'should emit [Loading, Error] when data is gotten unsuccessfully',
    build: () {
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async =>  Left(ServerFailure('Server Failure')));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(TopRatedTv()),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvState>[
      TvLoading(),
      const TvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTv.execute());
    },
  );
}
