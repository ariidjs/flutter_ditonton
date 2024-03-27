import 'package:dartz/dartz.dart';
import 'package:movies/movies.dart';
import 'package:mockito/mockito.dart';
import 'package:core/common/failure.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import '../../dummy_data/dummy_objects.dart';
import 'top_rated_movie_bloc_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMovieBloc topRatedMovieBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMovieBloc = TopRatedMovieBloc(mockGetTopRatedMovies);
  });

  test(
    'initial state should be empty',
    () {
      expect(topRatedMovieBloc.state, MovieEmpty());
    },
  );

  blocTest<TopRatedMovieBloc, MovieState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return topRatedMovieBloc;
    },
    act: (bloc) => bloc.add(TopRatedMovie()),
    wait: const Duration(milliseconds: 500),
    expect: () => <MovieState>[
      MovieLoading(),
      MovieSuccess(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );

  blocTest<TopRatedMovieBloc, MovieState>(
    'should emit [Loading, Error] when get top rated is unsuccessful.',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedMovieBloc;
    },
    act: (bloc) => bloc.add(TopRatedMovie()),
    wait: const Duration(milliseconds: 500),
    expect: () => <MovieState>[
      MovieLoading(),
      const MovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );
}
