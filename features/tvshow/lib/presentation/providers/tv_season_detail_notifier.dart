import 'package:core/common/state_enum.dart';
import 'package:core/domain/entities/tv/season_detail.dart';
import 'package:core/domain/entities/tv/tv_detail.dart';
import 'package:core/domain/entities/tv/tv_show.dart';
import 'package:core/domain/usecases/tv/get_tv_season_detail.dart';
import 'package:core/domain/usecases/tv/get_tv_show_recommendations.dart';
import 'package:core/domain/usecases/tv/get_watchlist_tv_status.dart';
import 'package:core/domain/usecases/tv/remove_watchlist_tv.dart';
import 'package:core/domain/usecases/tv/save_watchlist_tv.dart';
import 'package:flutter/widgets.dart';

class TvSeasonDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSeasonDetail getTvSeasonDetail;
  final GetTvShowRecommendations getTvShowRecommendations;
  final GetWatchlistTvStatus getWatchlistTvStatus;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;

  TvSeasonDetailNotifier({
    required this.getTvSeasonDetail,
    required this.getTvShowRecommendations,
    required this.getWatchlistTvStatus,
    required this.removeWatchlistTv,
    required this.saveWatchlistTv,
  });

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
          (recommendationFailure) {
            _recommendationState = RequestState.Error;
            _message = recommendationFailure.message;
            notifyListeners();
          },
          (recommendations) {
            _tvRecommendations = recommendations;
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
