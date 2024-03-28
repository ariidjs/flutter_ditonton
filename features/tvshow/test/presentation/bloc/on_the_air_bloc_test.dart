import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'on_the_air_bloc_test.mocks.dart';
import 'package:core/common/failure.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import '../../dummy_data/tv_dummy_object.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvshow/presentation/bloc/tv_bloc.dart';
import 'package:tvshow/domain/usecases/get_on_the_air_tv_shows.dart';


@GenerateMocks([GetOnTheAirTvShows])
void main() {
  late OnTheAirTvBloc onTheAirBloc;
  late MockGetOnTheAirTvShows mockGetOnAirTv;

  setUp(() {
    mockGetOnAirTv = MockGetOnTheAirTvShows();
    onTheAirBloc = OnTheAirTvBloc(mockGetOnAirTv);
  });

  test(
    'initial state should be empty',
    () {
      expect(onTheAirBloc.state, TvEmpty());
    },
  );

  blocTest<OnTheAirTvBloc, TvState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetOnAirTv.execute()).thenAnswer((_) async => Right(testTvList));
      return onTheAirBloc;
    },
    act: (bloc) => bloc.add(OnTheAir()),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvState>[
      TvLoading(),
      TvSuccess(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetOnAirTv.execute());
    },
  );

  blocTest<OnTheAirTvBloc, TvState>(
    'should emit [Loading, Error] when data is gotten unsuccessfully',
    build: () {
      when(mockGetOnAirTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return onTheAirBloc;
    },
    act: (bloc) => bloc.add(OnTheAir()),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvState>[
      TvLoading(),
      const TvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetOnAirTv.execute());
    },
  );
}
