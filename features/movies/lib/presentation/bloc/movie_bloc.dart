import 'package:movies/movies.dart';
import 'package:core/common/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/bloc/bloc.dart';
import 'package:movies/domain/entities/movie_detail.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class NowPlayingMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingMovies nowPlayingMovies;

  NowPlayingMovieBloc(this.nowPlayingMovies) : super(MovieEmpty()) {
    on<NowPlayingMovie>((event, emit) async {
      emit(MovieLoading());
      final result = await nowPlayingMovies.execute();

      result.fold((failure) {
        emit(MovieError(failure.message));
      }, (data) {
        emit(MovieSuccess(data));
      });
    });
  }
}

class PopularMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMovies popularMovies;

  PopularMovieBloc(this.popularMovies) : super(MovieEmpty()) {
    on<PopularMovie>((event, emit) async {
      emit(MovieLoading());
      final result = await popularMovies.execute();

      result.fold((failure) => emit(MovieError(failure.message)),
          (data) => emit(MovieSuccess(data)));
    });
  }
}

class TopRatedMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetTopRatedMovies topRatedMovies;

  TopRatedMovieBloc(this.topRatedMovies) : super(MovieEmpty()) {
    on<TopRatedMovie>((event, emit) async {
      emit(MovieLoading());
      final result = await topRatedMovies.execute();

      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieSuccess(data)),
      );
    });
  }
}

class MovieRecommentaionsBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieRecommendations movieRecommendations;

  MovieRecommentaionsBloc(this.movieRecommendations) : super(MovieEmpty()) {
    on<MovieRecommendations>((event, emit) async {
      emit(MovieLoading());
      final result = await movieRecommendations.execute(event.id);

      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieSuccess(data)),
      );
    });
  }
}

class MovieDetailBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieDetail movieDetail;

  MovieDetailBloc(this.movieDetail) : super(MovieEmpty()) {
    on<MovieDetails>((event, emit) async {
      emit(MovieLoading());
      final result = await movieDetail.execute(event.id);

      result.fold((failure) {
        emit(MovieError(failure.message));
      }, (data) {
        emit(MovieDetailSuccess(data));
      });
    });
  }
}

class MovieWatchlistBloc extends Bloc<MovieEvent, MovieState> {
  final GetWatchlistMovies watchlistMovies;
  final GetWatchListStatus watchListStatus;
  final SaveWatchlist saveWatchlistMovie;
  final RemoveWatchlist removeWatchlistMovie;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  MovieWatchlistBloc(
    this.watchlistMovies,
    this.watchListStatus,
    this.saveWatchlistMovie,
    this.removeWatchlistMovie,
  ) : super(MovieEmpty()) {
    on<WatchlistMovie>((event, emit) async {
      emit(MovieLoading());

      final result = await watchlistMovies.execute();
      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieSuccess(data)),
      );
    });

    on<WatchlistStatusMovie>((event, emit) async {
      emit(MovieLoading());
      final result = await watchListStatus.execute(event.id);
      emit(MovieWatchlistStatus(result));
    });

    on<SaveWatchlistMovie>((event, emit) async {
      emit(MovieLoading());
      final result = await saveWatchlistMovie.execute(event.movieDetail);

      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (success) => emit(WatchlistMovieMessage(success)),
      );
    });
    on<RemoveWatchlistMovie>((event, emit) async {
      emit(MovieLoading());
      final result = await removeWatchlistMovie.execute(event.movieDetail);

      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (success) => emit(WatchlistMovieMessage(success)),
      );
    });
  }
}

class SearchMovieBloc extends Bloc<MovieEvent, MovieState> {
  final SearchMovies _searchMovies;

  SearchMovieBloc(this._searchMovies) : super(MovieEmpty()) {
    on<SearchQueryMovie>((event, emit) async {
      final query = event.query;

      emit(MovieLoading());
      final result = await _searchMovies.execute(query);

      result.fold((failure) {
        emit(MovieError(failure.message));
      }, (data) {
        emit(MovieSuccess(data));
      });
    }, transformer: debounce(const Duration(milliseconds: 300)));
  }
}
