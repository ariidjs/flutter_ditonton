import 'package:dartz/dartz.dart';
import 'package:movies/movies.dart';
import 'package:mockito/mockito.dart';
import 'package:core/common/failure.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import '../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_bloc_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';


@GenerateMocks([
  GetWatchlistMovies,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieWatchlistBloc movieWatchlistBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieWatchlistBloc = MovieWatchlistBloc(
      mockGetWatchlistMovies,
      mockGetWatchListStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });

  test(
    'initial state should be empty',
    () {
      expect(movieWatchlistBloc.state, MovieEmpty());
    },
  );

  blocTest<MovieWatchlistBloc, MovieState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(WatchlistMovie()),
    wait: const Duration(milliseconds: 500),
    expect: () => <MovieState>[
      MovieLoading(),
      MovieSuccess(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<MovieWatchlistBloc, MovieState>(
    'should emit [Loading, Error] when data is gotten unsuccessfully.',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(WatchlistMovie()),
    expect: () => <MovieState>[
      MovieLoading(),
      const MovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<MovieWatchlistBloc, MovieState>(
    'should emit [Loading, MovieWatchlistStatus] when data is gotten successfully',
    build: () {
      when(mockGetWatchListStatus.execute(testMovie.id))
          .thenAnswer((_) async => true);
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(WatchlistStatusMovie(testMovie.id)),
    wait: const Duration(milliseconds: 500),
    expect: () => <MovieState>[
      MovieLoading(),
      const MovieWatchlistStatus(true),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(testMovie.id));
    },
  );

  blocTest<MovieWatchlistBloc, MovieState>(
    'should emit [Loading, WatchlistMovieMessage] when save to watchlist is successful',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer((_) async =>
          const Right(MovieWatchlistBloc.watchlistAddSuccessMessage));
      when(mockGetWatchListStatus.execute(testMovie.id))
          .thenAnswer((_) async => true);
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(SaveWatchlistMovie(testMovieDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => <MovieState>[
      MovieLoading(),
      const WatchlistMovieMessage(
          MovieWatchlistBloc.watchlistAddSuccessMessage),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MovieWatchlistBloc, MovieState>(
    'should emit [Loading, WatchlistMovieMessage] when remove watchlist is successful',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer((_) async =>
          const Right(MovieWatchlistBloc.watchlistRemoveSuccessMessage));
      when(mockGetWatchListStatus.execute(testMovie.id))
          .thenAnswer((_) async => false);
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(RemoveWatchlistMovie(testMovieDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => <MovieState>[
      MovieLoading(),
      const WatchlistMovieMessage(
          MovieWatchlistBloc.watchlistRemoveSuccessMessage),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MovieWatchlistBloc, MovieState>(
    'should emit [Loading, Error] when add watchlist is unsuccessful',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
      when(mockGetWatchListStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => false);
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(SaveWatchlistMovie(testMovieDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => <MovieState>[
      MovieLoading(),
      const MovieError('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MovieWatchlistBloc, MovieState>(
    'should emit [Loading, Error] when remove watchlist is unsuccessful',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
      when(mockGetWatchListStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => true);
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(RemoveWatchlistMovie(testMovieDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => <MovieState>[
      MovieLoading(),
      const MovieError('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );
}
