import 'package:core/common/state_enum.dart';
import 'package:core/domain/entities/tv/tv_show.dart';
import 'package:core/domain/usecases/tv/get_popular_tv_shows.dart';
import 'package:flutter/cupertino.dart';

class PopularTvNotifier extends ChangeNotifier {
  final GetPopularTvShows getPopularTvShows;

  PopularTvNotifier({required this.getPopularTvShows});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvShow> _tvShows = [];
  List<TvShow> get tvShows => _tvShows;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTvShows() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvShows.execute();
    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _state = RequestState.Loaded;
        _tvShows = tvData;
        notifyListeners();
      },
    );
  }
}
