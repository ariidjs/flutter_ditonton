import 'package:dartz/dartz.dart';
import 'package:movies/movies.dart';
import 'package:mockito/mockito.dart';
import 'package:core/common/failure.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'popular_movie_bloc_test.mocks.dart';
import '../../dummy_data/dummy_objects.dart';
import 'package:flutter_test/flutter_test.dart';



@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMovieBloc popularMovieBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMovieBloc = PopularMovieBloc(mockGetPopularMovies);
  });

  test(
    'initial state should be empty',
    () {
      expect(popularMovieBloc.state, MovieEmpty());
    },
  );

  blocTest<PopularMovieBloc, MovieState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return popularMovieBloc;
    },
    act: (bloc) => bloc.add(PopularMovie()),
    wait: const Duration(milliseconds: 500),
    expect: () => <MovieState>[
      MovieLoading(),
      MovieSuccess(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest<PopularMovieBloc, MovieState>(
    'should emit [Loading, Error] when data is gotten unsuccessfully',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async =>  Left(ServerFailure('Server Failure')));
      return popularMovieBloc;
    },
    act: (bloc) => bloc.add(PopularMovie()),
    wait: const Duration(milliseconds: 500),
    expect: () => <MovieState>[
      MovieLoading(),
      const MovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );
}
