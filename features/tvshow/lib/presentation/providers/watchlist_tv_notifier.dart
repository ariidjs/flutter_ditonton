import 'package:core/common/state_enum.dart';
import 'package:core/domain/entities/tv/tv_show.dart';
import 'package:core/domain/usecases/tv/get_watchlist_tv_shows.dart';
import 'package:flutter/widgets.dart';

class WatchlistTvNotifier extends ChangeNotifier {
  var _watchlistTvShows = <TvShow>[];
  List<TvShow> get watchlistTvShows => _watchlistTvShows;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  final GetWatchlistTvShows getWatchlistTvShows;

  WatchlistTvNotifier({required this.getWatchlistTvShows});

  Future<void> fetchWatchlistTvShows() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTvShows.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTvShows = tvData;
        notifyListeners();
      },
    );
  }
}
