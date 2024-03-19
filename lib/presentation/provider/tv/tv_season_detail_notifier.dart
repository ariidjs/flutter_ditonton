import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/season_detail.dart';

import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/domain/entities/tv/tv_show.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_season_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_show_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_show_recommendations.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv_status.dart';
import 'package:ditonton/domain/usecases/tv/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv/save_watchlist_tv.dart';
import 'package:flutter/widgets.dart';

class TvSeasonDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvShowDetail getTvShowDetail;
  final GetTvSeasonDetail getTvSeasonDetail;
  final GetTvShowRecommendations getTvShowRecommendations;
  final GetWatchlistTvStatus getWatchlistTvStatus;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;

  TvSeasonDetailNotifier({
    required this.getTvShowDetail,
    required this.getTvSeasonDetail,
    required this.getTvShowRecommendations,
    required this.getWatchlistTvStatus,
    required this.removeWatchlistTv,
    required this.saveWatchlistTv,
  });

  late TvDetail _tvDetail;
  TvDetail get tvDetail => _tvDetail;

  RequestState _tvDetailState = RequestState.Empty;
  RequestState get tvDetailState => _tvDetailState;

  late SeasonDetail _seasonDetail;
  SeasonDetail get seasonDetail => _seasonDetail;

  RequestState _seasonState = RequestState.Empty;
  RequestState get seasonState => _seasonState;

  List<TvShow> _tvRecommendations = [];
  List<TvShow> get tvRecommendations => _tvRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  Future<void> fetchSeasonDetail(int tvId, int seasonNumber) async {
    _seasonState = RequestState.Loading;
    notifyListeners();

    final detailResult = await getTvSeasonDetail.execute(tvId, seasonNumber);
    final recommendationResult = await getTvShowRecommendations.execute(tvId);
    final tvDetailResult = await getTvShowDetail.execute(tvId);

    detailResult.fold(
      (failure) {
        _seasonState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (seasonDetail) {
        _recommendationState = RequestState.Loading;
        _seasonDetail = seasonDetail;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
            notifyListeners();
          },
          (tvDetail) {
            _tvDetailState = RequestState.Loading;
            _tvRecommendations = tvDetail;
            notifyListeners();
            tvDetailResult.fold(
              (failure) {
                _tvDetailState = RequestState.Error;
                _message = failure.message;
                notifyListeners();
              },
              (tvDetail) {
                _tvDetailState = RequestState.Loaded;
                _tvDetail = tvDetail;
                notifyListeners();
              },
            );
            _recommendationState = RequestState.Loaded;
            notifyListeners();
          },
        );
        _seasonState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  bool _isAddedToWatchlist = false;
  bool get isAddedToWatchlist => _isAddedToWatchlist;

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchlistTvStatus.execute(id);
    _isAddedToWatchlist = result;
    notifyListeners();
  }

  Future<void> addWatchlist(TvDetail tv) async {
    final result = await saveWatchlistTv.execute(tv);

    await result.fold(
      (failure) async => _watchlistMessage = failure.message,
      (successMessage) async => _watchlistMessage = successMessage,
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> removeFromWatchlist(TvDetail tv) async {
    final result = await removeWatchlistTv.execute(tv);

    await result.fold(
      (failure) async => _watchlistMessage = failure.message,
      (successMessage) async => _watchlistMessage = successMessage,
    );

    await loadWatchlistStatus(tv.id);
  }
}
