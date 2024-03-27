import 'package:dartz/dartz.dart';
import 'package:movies/movies.dart';
import 'package:mockito/mockito.dart';
import 'package:core/common/failure.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import '../../dummy_data/dummy_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'now_playing_movie_bloc_test.mocks.dart';



@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingMovieBloc nowPlayingMovieBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMovieBloc = NowPlayingMovieBloc(mockGetNowPlayingMovies);
  });

  test(
    'initial state should be empty',
    () {
      expect(nowPlayingMovieBloc.state, MovieEmpty());
    },
  );

  blocTest<NowPlayingMovieBloc, MovieState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return nowPlayingMovieBloc;
    },
    act: (bloc) => bloc.add(NowPlayingMovie()),
    wait: const Duration(milliseconds: 500),
    expect: () => <MovieState>[
      MovieLoading(),
      MovieSuccess(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<NowPlayingMovieBloc, MovieState>(
    'should emit [Loading, Error] when data is gotten unsuccessfully',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async =>  Left(ServerFailure('Server Failure')));
      return nowPlayingMovieBloc;
    },
    act: (bloc) => bloc.add(NowPlayingMovie()),
    wait: const Duration(milliseconds: 500),
    expect: () => <MovieState>[
      MovieLoading(),
      const MovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );
}
