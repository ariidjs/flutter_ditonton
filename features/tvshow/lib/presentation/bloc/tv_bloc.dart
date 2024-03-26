import 'package:core/common/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshow/domain/entities/tv_show.dart';
import 'package:tvshow/domain/usecases/usecases.dart';
import 'package:tvshow/domain/entities/tv_detail.dart';
import 'package:tvshow/domain/entities/season_detail.dart';

part 'tv_event.dart';
part 'tv_state.dart';

class OnTheAirTvBloc extends Bloc<TvEvent, TvState> {
  final GetOnTheAirTvShows onTheAir;

  OnTheAirTvBloc(this.onTheAir) : super(TvEmpty()) {
    on<OnTheAir>((event, emit) async {
      emit(TvLoading());
      final result = await onTheAir.execute();

      result.fold((failure) {
        emit(TvError(failure.message));
      }, (data) {
        emit(TvSuccess(data));
      });
    });
  }
}

class PopularTvBloc extends Bloc<TvEvent, TvState> {
  final GetPopularTvShows popular;

  PopularTvBloc(this.popular) : super(TvEmpty()) {
    on<PopularTv>((event, emit) async {
      emit(TvLoading());
      final result = await popular.execute();

      result.fold((failure) {
        emit(TvError(failure.message));
      }, (data) {
        emit(TvSuccess(data));
      });
    });
  }
}

class TopRatedTvBloc extends Bloc<TvEvent, TvState> {
  final GetTopRatedTvShows topRated;

  TopRatedTvBloc(this.topRated) : super(TvEmpty()) {
    on<TopRatedTv>((event, emit) async {
      emit(TvLoading());
      final result = await topRated.execute();

      result.fold((failure) {
        emit(TvError(failure.message));
      }, (data) {
        emit(TvSuccess(data));
      });
    });
  }
}

class TvRecommendationBloc extends Bloc<TvEvent, TvState> {
  final GetTvShowRecommendations tvRecommendations;

  TvRecommendationBloc(this.tvRecommendations) : super(TvEmpty()) {
    on<TvRecommendations>((event, emit) async {
      emit(TvLoading());
      final result = await tvRecommendations.execute(event.id);

      result.fold((failure) {
        emit(TvError(failure.message));
      }, (data) {
        emit(TvSuccess(data));
      });
    });
  }
}

class TvDetailBloc extends Bloc<TvEvent, TvState> {
  final GetTvShowDetail tvDetail;

  TvDetailBloc(this.tvDetail) : super(TvEmpty()) {
    on<TvDetails>((event, emit) async {
      emit(TvLoading());
      final result = await tvDetail.execute(event.id);

      result.fold((failure) {
        emit(TvError(failure.message));
      }, (data) {
        emit(TvDetailSuccess(data));
      });
    });
  }
}

class TvWatchlistBloc extends Bloc<TvEvent, TvState> {
  final GetWatchlistTvShows watchlistTv;
  final GetWatchlistTvStatus watchlistTvStatus;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  TvWatchlistBloc(
    this.watchlistTv,
    this.watchlistTvStatus,
    this.saveWatchlistTv,
    this.removeWatchlistTv,
  ) : super(TvEmpty()) {
    on<WatchlistTv>((event, emit) async {
      emit(TvLoading());
      final result = await watchlistTv.execute();

      result.fold((failure) {
        emit(TvError(failure.message));
      }, (data) {
        emit(TvSuccess(data));
      });
    });

    on<WatchlistStatusTv>((event, emit) async {
      emit(TvLoading());
      final result = await watchlistTvStatus.execute(event.id);

      emit(TvWatchlistStatus(result));
    });

    on<SaveTvWatchlist>((event, emit) async {
      emit(TvLoading());
      final result = await saveWatchlistTv.execute(event.tvDetail);

      result.fold((failure) {
        emit(TvError(failure.message));
      }, (data) {
        emit(const WatchlistTvMessage(watchlistAddSuccessMessage));
      });
    });

    on<RemoveTvWatchlist>((event, emit) async {
      emit(TvLoading());
      final result = await removeWatchlistTv.execute(event.tvDetail);

      result.fold((failure) {
        emit(TvError(failure.message));
      }, (data) {
        emit(const WatchlistTvMessage(watchlistRemoveSuccessMessage));
      });
    });
  }
}

class TvSeasonDetailBloc extends Bloc<TvEvent, TvState> {
  final GetTvSeasonDetail tvSeasonDetail;

  TvSeasonDetailBloc(this.tvSeasonDetail) : super(TvEmpty()) {
    on<TvSeasonDetail>((event, emit) async {
      emit(TvLoading());
      final result = await tvSeasonDetail.execute(event.id, event.seasonNumber);

      result.fold((failure) {
        emit(TvError(failure.message));
      }, (data) {
        emit(TvSeasonDetailSuccess(data));
      });
    });
  }
}

class SearchTvBloc extends Bloc<TvEvent, TvState> {
  final SearchTvShows _searchTv;

  SearchTvBloc(this._searchTv) : super(TvEmpty()) {
    on<SearchTvQuery>((event, emit) async {
      final query = event.query;

      emit(TvLoading());
      final result = await _searchTv.execute(query);

      result.fold((failure) {
        emit(TvError(failure.message));
      }, (data) {
        emit(TvSuccess(data));
      });
    }, transformer: debounce(const Duration(milliseconds: 300)));
  }
}
