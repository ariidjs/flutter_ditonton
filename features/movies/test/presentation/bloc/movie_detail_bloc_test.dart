import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:core/common/failure.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'movie_detail_bloc_test.mocks.dart';
import '../../dummy_data/dummy_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/presentation/bloc/movie_bloc.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';


@GenerateMocks([GetMovieDetail])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailBloc = MovieDetailBloc(mockGetMovieDetail);
  });

  test(
    'initial state should be empty',
    () {
      expect(movieDetailBloc.state, MovieEmpty());
    },
  );

  blocTest<MovieDetailBloc, MovieState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetMovieDetail.execute(1))
          .thenAnswer((_) async => Right(testMovieDetail));
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(const MovieDetails(1)),
    wait: const Duration(milliseconds: 500),
    expect: () => <MovieState>[
      MovieLoading(),
      MovieDetailSuccess(testMovieDetail),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(1));
    },
  );

  blocTest<MovieDetailBloc, MovieState>(
    'emits [Loading, Error] when get movie detail is unsuccessful.',
    build: () {
      when(mockGetMovieDetail.execute(1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(const MovieDetails(1)),
    expect: () => <MovieState>[
      MovieLoading(),
      const MovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(1));
    },
  );
}
