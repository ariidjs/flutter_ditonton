import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/movies.dart';
import 'package:tvshow/tvshow.dart';
import 'package:http/http.dart' as http;
import 'package:tvshow/presentation/bloc/tv_bloc.dart';
import 'package:tvshow/data/repositories/tv_repository_impl.dart';
import 'package:tvshow/data/datasources/tv_local_data_source.dart';
import 'package:tvshow/data/datasources/tv_remote_data_source.dart';
import 'package:movies/data/repositories/movie_repository_impl.dart';
import 'package:movies/data/datasources/movie_local_data_source.dart';
import 'package:movies/data/datasources/movie_remote_data_source.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // provider
  locator.registerFactory(() => PopularMovieBloc(locator()));
  locator.registerFactory(() => TopRatedMovieBloc(locator()));
  locator.registerFactory(() => NowPlayingMovieBloc(locator()));
  locator.registerFactory(() => SearchMovieBloc(locator()));
  locator.registerFactory(() => MovieRecommentaionsBloc(locator()));
  locator.registerFactory(() => MovieDetailBloc(locator()));
  locator.registerFactory(
      () => MovieWatchlistBloc(locator(), locator(), locator(), locator()));

  locator.registerFactory(() => PopularTvBloc(locator()));
  locator.registerFactory(() => TopRatedTvBloc(locator()));
  locator.registerFactory(() => OnTheAirTvBloc(locator()));
  locator.registerFactory(() => TvDetailBloc(locator()));
  locator.registerFactory(() => SearchTvBloc(locator()));
  locator.registerFactory(() => TvSeasonDetailBloc(locator()));
  locator.registerFactory(() => TvRecommendationBloc(locator()));
  locator.registerFactory(
      () => TvWatchlistBloc(locator(), locator(), locator(), locator()));

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator
      .registerLazySingleton(() => GetOnTheAirTvShows(repository: locator()));
  locator.registerLazySingleton(() => GetPopularTvShows(repository: locator()));
  locator
      .registerLazySingleton(() => GetTopRatedTvShows(repository: locator()));
  locator.registerLazySingleton(() => GetTvShowDetail(repository: locator()));
  locator.registerLazySingleton(
      () => GetTvShowRecommendations(repository: locator()));
  locator.registerLazySingleton(() => SearchTvShows(repository: locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(repository: locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(repository: locator()));
  locator
      .registerLazySingleton(() => GetWatchlistTvShows(repository: locator()));
  locator
      .registerLazySingleton(() => GetWatchlistTvStatus(repository: locator()));
  locator.registerLazySingleton(() => GetTvSeasonDetail(repository: locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvLocalDataSource>(
    () => TvLocalDataSourceImpl(databaseHelper: locator()),
  );

  locator.registerLazySingleton<TvRemoteDataSource>(
    () => TvRemoteDataSourceImpl(client: locator()),
  );

  // helper
  locator.registerSingleton<DatabaseHelper>(
      DatabaseHelper(database: await DatabaseHelper().initDb()));

  // external
  locator.registerLazySingleton(() => http.Client());
}
