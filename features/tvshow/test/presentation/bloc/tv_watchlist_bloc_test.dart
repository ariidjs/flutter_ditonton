import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:mockito/annotations.dart';
import 'tv_watchlist_bloc_test.mocks.dart';
import '../../dummy_data/tv_dummy_object.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvshow/domain/usecases/usecases.dart';
import 'package:tvshow/presentation/bloc/tv_bloc.dart';

@GenerateMocks([
  GetWatchlistTvShows,
  GetWatchlistTvStatus,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  late TvWatchlistBloc tvWatchlistBloc;
  late MockGetWatchlistTvShows mockGetWatchlistTv;
  late MockGetWatchlistTvStatus mockGetWatchListTvStatus;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;

  setUp(() {
    mockGetWatchlistTv = MockGetWatchlistTvShows();
    mockGetWatchListTvStatus = MockGetWatchlistTvStatus();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    tvWatchlistBloc = TvWatchlistBloc(
      mockGetWatchlistTv,
      mockGetWatchListTvStatus,
      mockSaveWatchlistTv,
      mockRemoveWatchlistTv,
    );
  });

  test('initial state should be empty', () {
    expect(tvWatchlistBloc.state, TvEmpty());
  });

  blocTest<TvWatchlistBloc, TvState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(WatchlistTv()),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvState>[
      TvLoading(),
      TvSuccess(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTv.execute());
    },
  );

  blocTest<TvWatchlistBloc, TvState>(
    'should emit [Loading, Error] when data is gotten unsuccessfully.',
    build: () {
      when(mockGetWatchlistTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(WatchlistTv()),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvState>[
      TvLoading(),
      const TvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTv.execute());
    },
  );

  blocTest<TvWatchlistBloc, TvState>(
    'should emit [Loading, TvWatchlistStatus] when data is gotten successfully',
    build: () {
      when(mockGetWatchListTvStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(WatchlistStatusTv(testTvDetail.id)),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvState>[
      TvLoading(),
      const TvWatchlistStatus(true),
    ],
    verify: (bloc) {
      verify(mockGetWatchListTvStatus.execute(testTvDetail.id));
    },
  );

  blocTest<TvWatchlistBloc, TvState>(
    'should emit [Loading, WatchlistMovieMessage] when save to watchlist is successful',
    build: () {
      when(mockSaveWatchlistTv.execute(testTvDetail)).thenAnswer(
          (_) async => const Right(TvWatchlistBloc.watchlistAddSuccessMessage));
      when(mockGetWatchListTvStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(SaveTvWatchlist(testTvDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvState>[
      TvLoading(),
      const WatchlistTvMessage(TvWatchlistBloc.watchlistAddSuccessMessage),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistTv.execute(testTvDetail));
    },
  );

  blocTest<TvWatchlistBloc, TvState>(
    'should emit [Loading, WatchlistMovieMessage] when remove from watchlist is successful',
    build: () {
      when(mockRemoveWatchlistTv.execute(testTvDetail)).thenAnswer((_) async =>
          const Right(TvWatchlistBloc.watchlistRemoveSuccessMessage));
      when(mockGetWatchListTvStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(RemoveTvWatchlist(testTvDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvState>[
      TvLoading(),
      const WatchlistTvMessage(TvWatchlistBloc.watchlistRemoveSuccessMessage),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistTv.execute(testTvDetail));
    },
  );

  blocTest<TvWatchlistBloc, TvState>(
    'should emit [Loading, Error] when save to watchlist is unsuccessful',
    build: () {
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
      when(mockGetWatchListTvStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(SaveTvWatchlist(testTvDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvState>[
      TvLoading(),
      const TvError('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistTv.execute(testTvDetail));
    },
  );

  blocTest<TvWatchlistBloc, TvState>(
    'should emit [Loading, Error] when remove from watchlist is unsuccessful',
    build: () {
      when(mockRemoveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
      when(mockGetWatchListTvStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(RemoveTvWatchlist(testTvDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvState>[
      TvLoading(),
      const TvError('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistTv.execute(testTvDetail));
    },
  );
}
