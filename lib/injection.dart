import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movies/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movies/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/tv/tv_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:ditonton/domain/usecases/movies/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/movies/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movies/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movies/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movies/save_watchlist.dart';
import 'package:ditonton/domain/usecases/movies/search_movies.dart';
import 'package:ditonton/presentation/provider/movies/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movies/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movies/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/movies/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/movies/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/movies/watchlist_movie_notifier.dart';
import 'package:ditonton/domain/usecases/tv/get_on_the_air_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_season_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_show_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_show_recommendations.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv_status.dart';
import 'package:ditonton/domain/usecases/tv/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv/save_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv/search_tv_shows.dart';
import 'package:ditonton/presentation/provider/tv/popular_tv_notifier.dart';
import 'package:ditonton/presentation/provider/tv/top_rated_tv_notifier.dart';
import 'package:ditonton/presentation/provider/tv/tv_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv/tv_list_notifier.dart';
import 'package:ditonton/presentation/provider/tv/tv_search_notifier.dart';
import 'package:ditonton/presentation/provider/tv/tv_season_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv/watchlist_tv_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => TvListNotifier(
      getOnTheAirTvShows: locator(),
      getPopularTvShows: locator(),
      getTopRatedTvShows: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvNotifier(
      getPopularTvShows: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvNotifier(
      getTopRatedTvShows: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailNotifier(
      getTvShowDetail: locator(),
      getTvShowRecommendations: locator(),
      getWatchlistTvStatus: locator(),
      saveWatchlistTv: locator(),
      removeWatchlistTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSearchNotifier(
      searchTvShows: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvNotifier(
      getWatchlistTvShows: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeasonDetailNotifier(
      getTvShowDetail: locator(),
      getTvSeasonDetail: locator(),
      getTvShowRecommendations: locator(),
      getWatchlistTvStatus: locator(),
      removeWatchlistTv: locator(),
      saveWatchlistTv: locator(),
    ),
  );

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
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
