import 'package:core/common/state_enum.dart';
import 'package:core/domain/entities/tv/tv_show.dart';
import 'package:core/domain/usecases/tv/get_on_the_air_tv_shows.dart';
import 'package:core/domain/usecases/tv/get_popular_tv_shows.dart';
import 'package:core/domain/usecases/tv/get_top_rated_tv_shows.dart';
import 'package:flutter/widgets.dart';

class TvListNotifier extends ChangeNotifier {
  var _onTheAirTvShows = <TvShow>[];
  List<TvShow> get onTheAirTvShows => _onTheAirTvShows;

  RequestState _onTheAirTvState = RequestState.Empty;
  RequestState get onTheAirTvState => _onTheAirTvState;

  var _popularTvShows = <TvShow>[];
  List<TvShow> get popularTvShows => _popularTvShows;

  RequestState _popularTvState = RequestState.Empty;
  RequestState get popularTvState => _popularTvState;

  var _topRatedTvShows = <TvShow>[];
  List<TvShow> get topRatedTvShows => _topRatedTvShows;

  RequestState _topRatedTvState = RequestState.Empty;
  RequestState get topRatedState => _topRatedTvState;

  String _message = '';
  String get message => _message;

  final GetOnTheAirTvShows getOnTheAirTvShows;
  final GetPopularTvShows getPopularTvShows;
  final GetTopRatedTvShows getTopRatedTvShows;

  TvListNotifier({
    required this.getOnTheAirTvShows,
    required this.getPopularTvShows,
    required this.getTopRatedTvShows,
  });

  Future<void> fetchOnTheAirTvShows() async {
    _onTheAirTvState = RequestState.Loading;
    notifyListeners();

    final result = await getOnTheAirTvShows.execute();
    result.fold(
      (failure) {
        _onTheAirTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _onTheAirTvState = RequestState.Loaded;
        _onTheAirTvShows = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvShows() async {
    _popularTvState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvShows.execute();
    result.fold(
      (failure) {
        _popularTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _popularTvState = RequestState.Loaded;
        _popularTvShows = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvShows() async {
    _topRatedTvState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvShows.execute();
    result.fold(
      (failure) {
        _topRatedTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _topRatedTvState = RequestState.Loaded;
        _topRatedTvShows = tvData;
        notifyListeners();
      },
    );
  }
}
